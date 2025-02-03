classdef iom_parser < handle
    %
    %   Class:
    %   epworks.parse.iom_parser
    %
    %   See Also
    %   --------
    %   epworks.p.main
    %   epworks.parse.raw_object

    properties
        bytes
        id1
        n
        unknowns

        top_objects
        s
        s2
    end

    methods
        function obj = iom_parser(file_path)
            %
            %
            %

            %1:16 - ID?
            %17:20 - n? - why would there be more than 1?

            bytes = epworks.sl.io.fileRead(file_path,'*uint8');

            obj.bytes = bytes;

            obj.id1 = bytes(1:16);
            obj.n = double(typecast(bytes(17:20),'uint32'));
            
            %37:40 - n_bytes_next - don't exactly understand this ...
            start_I = 21;
            cur_obj_index = 0;
            
            %Initialization of the output
            %------------------------------------
            %
            %   This helps us to track object creation
            r = epworks.parse.iom.logger;
            
            object_I = 0;
            top_objects = cell(1,1000);
            %Processing of the top-level objects
            depth = 0;
            unknowns = zeros(1000,20);
            %--------------------------------------------------------------
            while start_I < length(bytes)
                cur_obj_index = cur_obj_index + 1;

                unknowns(cur_obj_index,:) = bytes(start_I:start_I+19);
                start_I = start_I + 20;
                                
                object_I = object_I + 1;
                
                temp_obj = epworks.parse.iom.raw_object(bytes,start_I,r,depth);
                top_objects{object_I} = temp_obj;
                start_I = start_I + temp_obj.n_bytes_to_next;
            end

            obj.top_objects = [top_objects{:}];

            n_objects = length(obj.top_objects);

            obj.unknowns = unknowns(1:n_objects,:);

            %Creation of a structure array
            %---------------------------------------------------------
            s_all = cell(1,n_objects);
            for i = 1:n_objects
               s = obj.top_objects(i).getStruct();
               s_all{i} = s;
            end
            obj.s = [s_all{:}];


            %A little bit of organizing into specific top level types
            %---------------------------------------------------------
            s2 = struct;
            s2.trace = [];
            s2.eeg_waveform = [];
            s2.group = [];
            s2.set = [];
            s2.test = [];
            s2.study = [];
            s2.patient = [];
            
            for i = 1:n_objects
                s = obj.s(i);
                switch s.type
                    case 'EPTrace'
                        temp = epworks.p.iom.trace(s,r);
                        s2.trace = [s2.trace temp];
                    case 'EPEEGWaveform'
                        temp = epworks.p.iom.eeg_waveform(s,r);
                        s2.eeg_waveform = [s2.eeg_waveform temp];
                    case 'EPGroup'
                        temp = epworks.p.iom.group(s,r);
                        s2.group = [s2.group temp];
                    case 'EPSet'
                        temp = epworks.p.iom.set(s,r);
                        s2.set = [s2.set temp];
                    case 'EPTest'
                        temp = epworks.p.iom.test(s,r);
                        s2.test = [s2.test temp];
                    case 'EPStudy'
                        temp = epworks.p.iom.study(s,r);
                        s2.study = [s2.study temp];
                    case 'EPPatient'
                        temp = epworks.p.iom.patient(s,r);
                        s2.patient = [s2.patient temp];
                    otherwise
                        error('Unsupported top level type')
                end
            end
            %not logging the objs
            obj.s2 = s2;
        end
    end
end

