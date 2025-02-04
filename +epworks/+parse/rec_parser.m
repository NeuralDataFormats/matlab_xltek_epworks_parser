classdef rec_parser < epworks.id_object
    %
    %   Class:
    %   epworks.parse.rec_parser
    %
    %   Contains results of parsed .REC files in the history folders
    %
    %   Format:
    %   - header
    %   - followed by waveforms
    %   See Also
    %   --------
    %   epworks.p.main

    
    properties
        bytes
    end


    properties (Hidden)
        raw_ustr
        ID = uint64([0 0]) %This is a hack
    end
    
    %Introduction properties ==============================================
    properties
        file_path
        d0 = '-----  Intro properties  ----'
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
        file_timestamp_string %datestr of time
        trace_ID 
        ochan_ID
        default_length %Length of each section of data
        
        waveforms %[1 x n], epworks.history.rec_waveform
        
        all_data
        d1 = '----  Pointers to Other Objects  ----'
        trace
        ochan
        
    end
    properties (Constant,Hidden)
        ID_PROP_INFO_1 = {
            'trace_ID'   'trace'
            'ochan_ID'   'ochan'
            }
    end
    methods
        function obj = rec_parser(file_path)
            
            INTRO_BYTE_LENGTH = 96;
            
            F.typeMatrix = @epworks.sl.io.typecastMatrix;
            F.rowsToCell = @epworks.sl.array.rowsToCell;
            
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

            %97 219 1 <= look for these bytes to help with finding
            %            structure since they are unique
            %            Note, this is like the year and maybe month
            %            and day so change this for YOUR file
            obj.file_timestamp = epworks.utils.processType3time(intro(21:28));
                        
            other_IDs = reshape(intro(29:60),16,2)';
            
            obj.trace_ID = other_IDs(1,:);
            obj.ochan_ID = other_IDs(2,:);
            
            obj.default_length = double(typecast(intro(61:64),'uint32'));
            
            if ~all(intro(65:96) == 0)
                error('Padded zeros assumption violated')
            end
            
            %Data Processing
            %---------------------------------------------------------------
            
            d2 = r(97:end);

            %Find the same timestamps
            I = strfind(d2,uint8([97 219 1]));
            %26
            %10514
            %.... => 57 entries total

            %10488 - default length


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
                entries{i} = epworks.p.rec.waveform(data_matrix(:,i),obj.default_length);
            end

            obj.waveforms = [entries{:}];

            obj.all_data = vertcat(obj.waveforms.data);

            return
            
            keyboard

            for i = 1:n_waveforms
                plot(obj.waveforms(i).data)
                title(sprintf('%d',i))
                pause
            end

            %{
            keyboard
            
            temp = reshape(r(97:end),obj.default_length,n_waveforms)';
            
            %The first 88 bytes seem to be not data ...
            info = temp(:,1:88);
            
            %NOTE: We currently ignore bytes 1-4, as we assume
            %this is equal to the default length ...
            %TODO: Check this assumption ...
            
            %sz = F.typeMatrix(info(:,1:4),'uint32',false);
            
            d(n_waveforms) = epworks.history.rec_waveform;
            
            ids_cell = F.rowsToCell(F.typeMatrix(info(:,5:20),'uint64',false));
            [d.ID] = deal(ids_cell{:});
            
            %TODO: remove these F calls
            timestamp = F.typeMatrix(info(:,21:28),'uint64',false);

            times_local = epworks.utils.processType3time(timestamp);
            times_cell = num2cell(times_local);
            [d.timestamp] = deal(times_cell{:});

            word_0  = num2cell(F.typeMatrix(info(:,29:32),'uint32',false));
            word_1  = num2cell(F.typeMatrix(info(:,33:36),'uint32',false));
            word_2  = num2cell(F.typeMatrix(info(:,37:40),'uint32',false));
            bytes   = F.rowsToCell(F.typeMatrix(info(:,41:44),'uint8',false));
            word_3  = num2cell(F.typeMatrix(info(:,45:48),'uint32',false));
            word_4  = num2cell(F.typeMatrix(info(:,49:52),'uint32',false));
            word_5  = num2cell(F.typeMatrix(info(:,53:56),'uint32',false));
            stim_amp = num2cell(F.typeMatrix(info(:,57:60),'single',false));
            more_words = F.rowsToCell(F.typeMatrix(info(:,61:88),'uint32',false));
            
            [d.bytes]   = deal(bytes{:});
            [d.stim_amp] = deal(stim_amp{:});
            
            [d.word_0] = deal(word_0{:});
            [d.word_1] = deal(word_1{:});    
            [d.word_2] = deal(word_2{:});    
            [d.word_3] = deal(word_3{:});
            [d.word_4] = deal(word_4{:});
            [d.word_5] = deal(word_5{:});
            [d.more_words] = deal(more_words{:});
            
            temp_data = F.rowsToCell(F.typeMatrix(temp(:,89:end),'single',false));
            
            [d.data] = deal(temp_data{:});
            obj.waveforms = d;
            
            rep_obj = repmat({obj},1,length(d));
            
            [d.m_parent] = deal(rep_obj{:});
            %}
        end
    end
    
end

