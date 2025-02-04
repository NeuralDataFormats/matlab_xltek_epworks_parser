classdef rec_parser < handle
    %
    %   Class:
    %   epworks.parse.rec_parser
    %
    %   Contains results of parsed .REC files in the history folders
    %
    %   Format:
    %   - header
    %   - followed by waveforms
    %
    %   See Also
    %   --------
    %   epworks.parse.main

    
    properties
        bytes
    end
    
    properties
        file_path
        name
        first_ID %The first ID seen in the file. This is the same
        %for all .REC files I've seen;
        %
        %   value => [4679572887378700461 14937479848262515882]
        %       0	168	193	100	191	46	241	64	0	64	62	163	199	150	76	207
        %
        %   I have yet to find an id that matches this version string.
        %   Even in other studies this seems to be the same.
        
        
        %I think this means 2 IDS
        first_unknown   %A value of 2 has always been observed 

        file_timestamp  %matlab time converted to seconds
        trace_ID 
        ochan_ID
        default_length %Length of each section of data
        
        waveforms %[1 x n], epworks.history.rec_waveform
        
        all_data
        trace
        ochan
        fs
    end
    properties (Constant,Hidden)
        ID_PROP_INFO_1 = {
            'trace_ID'   'trace'
            'ochan_ID'   'ochan'
            }
    end
    methods
        function obj = rec_parser(file_path,logger)
            
            INTRO_BYTE_LENGTH = 96;

            obj.file_path = file_path;
            
            r = epworks.sl.io.fileRead(file_path,'*uint8');

            obj.bytes = r;

            intro = r(1:96);
            
            %Process Intro
            %---------------------------------------------------------------
            %1) 16 byte ID - seems same across multiple files
            %    - 1:16
            %    - 'first_ID'
            %2) 4 bytes
            %    - 17:20
            %    - only the  value 2 has been observed
            %    - 'first_unknown'
            %3) 8 bytes
            %    - 21:28
            %    - 'file_timestamp'
            %4) 32 bytes - two IDs?
            %    - 29:44
            %    - 45:60
            %5) default length?
            %    - 61:64
            %6) padded zeros
            %    - 65:96
                        
            obj.first_ID = r(1:16);
            
            %I think this is the # of IDs
            obj.first_unknown = double(typecast(intro(17:20),'uint32'));
            if obj.first_unknown ~= 2
                error('Assuming only 2 values')
            end 
            
            if obj.first_unknown ~= 2
                %What happens when this is not 2?
                error('Assumption violated')
            end

            obj.file_timestamp = epworks.utils.processType3time(intro(21:28));
                        
            other_IDs = reshape(intro(29:60),16,2)';
            
            obj.trace_ID = other_IDs(1,:);
            obj.ochan_ID = other_IDs(2,:);
            obj.trace = logger.getObjectByID(obj.trace_ID);
            obj.ochan = logger.getObjectByID(obj.ochan_ID);

            obj.trace.rec_data = obj;

            obj.name = obj.trace.name;
            
            obj.default_length = double(typecast(intro(61:64),'uint32'));
            
            if ~all(intro(65:96) == 0)
                error('Padded zeros assumption violated')
            end
            
            %Data Processing
            %---------------------------------------------------------------            
            d2 = r(97:end);

            %Let's assume for now everything is the default length ...
            bytes_remaining = length(r) - INTRO_BYTE_LENGTH;
            
            n_waveforms = bytes_remaining/obj.default_length;
            
            if n_waveforms ~= floor(n_waveforms)

                %Note, if this is ever violated we can just rewrite the
                %code to do one at a time and grow the results object
                error('Constant length assumption violated')
            end

            data_matrix = reshape(d2,obj.default_length,n_waveforms);

            entries = cell(1,n_waveforms);
            for i = 1:n_waveforms
                entries{i} = epworks.p.rec.waveform(i,data_matrix(:,i),...
                    obj.default_length,obj.trace,obj.ochan);
            end

            obj.waveforms = [entries{:}];

            eeg_info = obj.trace.eeg_waveforms.data;
            obj.fs = eeg_info.samp_freq/eeg_info.timebase;

        end
        function plot(obj,varargin)

            in.y_shift = 0;
            in = epworks.sl.in.processVarargin(in,varargin);


            colors = get(gca,'ColorOrder');
            index  = get(gca,'ColorOrderIndex');
            n_colors = size(colors,1);
            if index > n_colors
              index = 1;
            end
            next_color = colors(index,:);
            hold on
            
            for i = 1:length(obj.waveforms)
                y = obj.waveforms(i).data;
                t0 = obj.waveforms(i).timestamp;

                dt = 1/obj.fs;
                half = obj.fs/2;
                n_samples = length(y);
                t = t0 + seconds(((1:n_samples)*dt));

                %Filtering details in:
                %s.test.data.settings.eeg.applied_montage_key_tree.channels
                %
                %   TODO: import those rather than hard coding
                [B,A] = butter(1,[50 70]/half,'stop');
                y = filtfilt(B,A,y);
                [B,A] = butter(1,1/half,'high');
                y = filtfilt(B,A,y);
                [B,A] = butter(1,30/half,'low');
                y = filtfilt(B,A,y);
                y_plot = y + in.y_shift;
                if i == 1
                    plot(t,y_plot,'color',next_color,'DisplayName',obj.name)
                else
                    plot(t,y_plot,'color',next_color,'HandleVisibility','off')
                end
                %pause
            end
            hold off
        end
    end
    
end

