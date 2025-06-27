classdef tst_parser < epworks.RNEL.handle_light
    %
    %   Class:
    %   epworks.tst_parser
    
    properties
        raw_data
        all_objects_out
        logger
        top_objects
        unknowns
        s

    end
    
    methods
        function obj = tst_parser(file_path)
            %
            %   tst = epworks.tst_parser(file_path);
            
            if isempty(file_path)
                return
            end
            
            obj.raw_data = epworks.sl.io.fileRead(file_path,'*uint8');
            bytes = obj.raw_data;
            
            %obj.all_objects_out = epworks.raw_object.getTSTrawObjects(obj.raw_data);
            % start_I = 21;
            cur_obj_index = 0;

            r = epworks.parse.iom.logger;
            obj.logger = r;

            object_I = 0;
            top_objects = cell(1,1000);
            %Processing of the top-level objects
            depth = 0;
            unknowns = zeros(1000,20);
            %--------------------------------------------------------------
            %77 is the '5' that indicates an object, leaving code in place
            %with the unknown although I'm only seeing one object ...
            start_I = 77 - 20;
            
            while start_I < length(bytes)
                cur_obj_index = cur_obj_index + 1;

                unknowns(cur_obj_index,:) = bytes(start_I:start_I+19);
                start_I = start_I + 20;

                object_I = object_I + 1;

                temp_obj = epworks.parse.iom.raw_object(bytes,start_I,r,depth);
                top_objects{object_I} = temp_obj;
                start_I = start_I + temp_obj.n_bytes_to_next;
            end

            %obj.top_objects : epworks.parse.iom.raw_object
            obj.top_objects = [top_objects{:}];

            n_objects = length(obj.top_objects);

            obj.unknowns = unknowns(1:n_objects,:);

            %Creation of a structure array
            %---------------------------------------------------------
            %
            %   This makes the properties have safe names.
            %
            %   It also rearranges things a bit.
            %   
            s_all = cell(1,n_objects);
            for i = 1:n_objects
                %   epworks.parse.iom.raw_object.getStruct
                s = obj.top_objects(i).getStruct();
                s_all{i} = s;
            end

            %s - struct
            %   .guid
            %   .array
            %   .props
            %       - field names are variable here, value is the value
            %         for that property (field name)
            %   .type
            %   .depth
            obj.s = [s_all{:}];

            r.initializeObjectHolder();

        end
    end
    
end

%{
function roa = getTSTrawObjects(raw_data)
            %
            %
            %   epworks.iom_raw_object.getTSTrawObjects
            %
            START_BYTE       = 82; %point to first value after:
            %5 a a a a
            %
            %   (a) is a u32 representing the size
            %
            %5 is proceeded by a bunch of nulls
            
            cur_obj_index    = 0;
            
            roa = epworks.raw_object_array;
            
            roh = epworks.raw_object_helper(raw_data,roa,cur_obj_index);
            
            %Yikes, this is a bit of a hack ...
            roh.depth = 0;
            %The roh code is setup to assume that we have already specified
            %the first level ...
            
            new_parent_indices = -1*START_BYTE; %Look away :/
            %See the hack I put in createRawObjects for when no
            %parents are actually present, instead we point to
            %the start index, the negative value indicates the difference
            %in interpretation between true parent_indices and the start
            %value
            
            roa = epworks.raw_object.recursiveGetAllObjects(roh,cur_obj_index,new_parent_indices);

            epworks.raw_object.applyCharDataValues(roa,roh)
            epworks.raw_object.createFullNames(roa,false);
            epworks.raw_object.finalizeObjects(roa,roh)

%}