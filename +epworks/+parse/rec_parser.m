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
    %   epworks.p.rec.waveform
    %   

    
    properties
        bytes
    end
    
    properties
        loop_id
        file_path
        file_name
        folder_time

        name = ''

        first_ID %The first ID seen in the file. This is the same
        %for all .REC files I've seen;
        %
        %   value => [4679572887378700461 14937479848262515882]
        %       0	168	193	100	191	46	241	64	0	64	62	163	199	150	76	207
        %
        %   I have yet to find an id that matches this version string.
        %   Even in other studies this seems to be the same.
        
        
        %I think this means 2 IDs
        first_unknown   %A value of 2 has always been observed 
        %   2 IDs being:
        %   1) trace ID
        %   2) ochan ID

        file_timestamp  %matlab time converted to seconds
        default_length %Length of each section of data
        
        waveforms %[1 x n], epworks.history.rec_waveform
        
        merged_waveforms

        trace
        ochan
        fs = NaN

        is_trace_orphan = false %This is true 
    end

    methods
        function obj = rec_parser(file_path,logger,tz_offset,loop_id,iom_bytes)
            %
            %
            %   Called By
            %   ---------
            %   epworks.parse.main
            %
            %   Inputs
            %   ------
            %   file_path
            %   logger :
            %   tz_offset :
            %   loop_id :
            %       This number helps us keep track of which rec file
            %       generated each waveform. It is simply the looping
            %       variable from the caller (1,2,3,etc.)
            
            obj.loop_id = loop_id;

            INTRO_BYTE_LENGTH = 96;

            obj.file_path = file_path;

            [root,obj.file_name] = fileparts(file_path);

            %Extraction of time from folder name
            %--------------------------------------------------------------
            %The timing info is in the name of the parent folder
            %so go up one more level

            [~,~,ext] = fileparts(root);
            %The period '.' in the folder path causes the part we care
            %about to be in the extension not in the name
            %
            %   Note, we could alternatively parse the the folder name

            %start at 2 to skip period
            temp = epworks.utils.hex2bytes(ext(2:end));

            %Stored in reverse byte order, flip and pass in
            obj.folder_time = epworks.utils.processType3time(temp(end:-1:1));
            

            %Read and process file
            %--------------------------------------------------------------
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
            %    - only the value 2 has been observed
            %    - 'first_unknown'
            %3) 8 bytes
            %    - 21:28
            %    - 'file_timestamp'
            %4) 32 bytes - two IDs?
            %    - 29:44 - trace_ID
            %    - 45:60 - ochan_ID
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
            obj.file_timestamp = obj.file_timestamp + tz_offset;
                        
            other_IDs = reshape(intro(29:60),16,2)';
            
            trace_ID = other_IDs(1,:);
            ochan_ID = other_IDs(2,:);
            obj.trace = logger.getObjectByID(trace_ID);
            obj.ochan = logger.getObjectByID(ochan_ID);


            %TODO: This will no longer be needed soon
            %----------------------------------------------------
            %----------------------------------------------------
            %Link this object from the trace
            if ~isempty(obj.trace)

                %TODO: We should probably make this more explicit
                %
                %   i.e., when building traces, go through and find
                %   relevant rec files
                obj.trace.rec_data = [obj.trace.rec_data {obj}];
    
                obj.name = obj.trace.name;
            else
                if ~isempty(obj.ochan)
                    obj.name = obj.ochan.name;
                end
                %error('Need to verify this only occurs for empty')
                %otherwise we're losing data

                %{
                %Checking if I somehow missed this in the iom file.
                %
                %  Perhaps it is in the .tst file?

                wtf = char(iom_bytes);
                wtf2 = char(trace_ID);
                wtf3 = char(ochan_ID);

                strfind(wtf,wtf2)
                strfind(wtf,wtf3)

                %}

                obj.is_trace_orphan = true;

                %Does this mean we have no data? No, but we can't link it
                %to anything
            end
            %----------------------------------------------------
            %----------------------------------------------------
            
            obj.default_length = double(typecast(intro(61:64),'uint32'));
            
            if ~all(intro(65:96) == 0)
                error('Padded zeros assumption violated')
            end

            %Note, this assumes eeg_waveforms
            %
            %   TODO: Determine type automatically
            %
            %   UNKNOWN: When there is no trace object, what is actually
            %   being logged here? The code seems to work (no errors) but
            %   not sure if there is a larger parsing issue.
            if ~isempty(obj.trace) && ~isempty(obj.trace.children)

                %JAH: 6/24/2025 - If we have no children it is possible we could get
                %the type some other way but for now we'll set fs to NaN
                if ~isempty(obj.trace.eeg_waveforms)
                    info = obj.trace.eeg_waveforms(1).data;
                else
                    info = obj.trace.triggered_waveforms(1).data;
                end

                %What if we have only a freerun_waveform?????
    
                %JAH: 6/24/2025 - why is this not just samp_freq?
                %       - should describe file where I found this to be
                %       true
                obj.fs = info.samp_freq/info.timebase;
                %obj.fs = info.samp_freq;
            elseif ~isempty(obj.ochan)
                %JAH: 6/24/2025 - this may not be correct ...

                temp = obj.ochan.to;
                obj.fs = temp.sampling_freq/obj.ochan.timebase;
                %obj.fs = temp.sampling_freq;
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

            %TODO: Best to not reshape and to iterate through
            %starts and stops ...
            data_matrix = reshape(d2,obj.default_length,n_waveforms);

            entries = cell(1,n_waveforms);
            for i = 1:n_waveforms
                temp = epworks.p.rec.waveform(i,data_matrix(:,i),...
                    obj.default_length,obj.trace,obj.ochan,obj.fs,...
                    tz_offset,loop_id);
                entries{i} = temp;
                %These IDs match the parsed objects
                %In particular, the first one I saw matched:
                %   epworks.p.iom.triggered_waveform
                %logger.logID(entries{i},temp.id);
            end

            obj.waveforms = [entries{:}];

            
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
            
            for i = 1:length(obj.merged_waveforms)
                y = obj.merged_waveforms(i).data;
                t = obj.merged_waveforms(i).time;

                half = obj.fs/2;

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
        function getWaveformInfo(objs)

            w = [objs.waveforms];

            wtf = vertcat(w.first_400);

           keyboard
        end
    end
    
end

