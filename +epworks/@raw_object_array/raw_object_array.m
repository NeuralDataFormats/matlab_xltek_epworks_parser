classdef raw_object_array < handle
    %
    %   Class:
    %   epworks.raw_object_array
    %
    %   See Also
    %   --------
    %   epworks.raw_object

    %These propertie are all arrays, which speeds up processing, rather
    %than single elements with multiple objects.

    %TODO: Update these definitions from epworks.raw_object class
    properties
        VERSION = 1

        id_tracker

        parent_index %index of the parent, -1 indicates no parent

        depth
        total_byte_length
        raw_start_I %index (byte #) in the raw data file of where
        %the object specification starts
        raw_end_I
        name

        full_name %cellstr
        %%'a.b.c.d.f' instead of just 'f'

        type %
        % -1 : no data
        %  0 : length 4, interpretation seems to vary
        %       - logical
        %       - single
        %       - etc.
        %  TODO: finish - see raw_object
        %  1 : double? - definitely double, not sure if anything else as
        %       well
        %  2 : string
        %  3 : 
        %       - id, 16 bytes
        %       - times (type 3 format)
        %  4 : complex object types?

        n_props
        data_start_I
        data_length
        data_value

        raw_data %raw bytes associated with this name

        children_indices
        n_objs %The size of all the arrays above
        processed
        logged_objects
        n_logged_objects = 0

        struct_array
    end

    methods
        function obj = raw_object_array()

            %??? Who calls this?

            obj.id_tracker = epworks.parse.id_tracker(); 

            INIT_SIZE = 100000;
            obj.parent_index = -1*ones(1,INIT_SIZE);
            obj.depth        = ones(1,INIT_SIZE);
            obj.total_byte_length = zeros(1,INIT_SIZE);
            obj.raw_start_I  = zeros(1,INIT_SIZE);
            obj.raw_end_I    = zeros(1,INIT_SIZE);
            obj.name         = cell(1,INIT_SIZE);
            %obj.full_name    = cell(1,INIT_SIZE);
            %We do this later ...
            obj.type         = -1*ones(1,INIT_SIZE);
            obj.n_props      = ones(1,INIT_SIZE);
            obj.data_start_I = zeros(1,INIT_SIZE);
            obj.data_length  = zeros(1,INIT_SIZE);
            obj.data_value   = cell(1,INIT_SIZE);
            obj.raw_data     = cell(1,INIT_SIZE);
            obj.children_indices = cell(1,INIT_SIZE);
        end
        function trim(obj,current_object_index)
            c = current_object_index + 1;
            obj.parent_index(c:end) = [];
            obj.depth(c:end)        = [];
            obj.total_byte_length(c:end) = [];
            obj.raw_start_I(c:end)  = [];
            obj.raw_end_I(c:end)    = [];
            obj.name(c:end)         = [];
            %obj.full_name(c:end)    = [];
            obj.type(c:end)         = [];
            obj.n_props(c:end)      = [];
            obj.data_start_I(c:end) = [];
            obj.data_length(c:end)  = [];
            obj.data_value(c:end)   = [];
            obj.raw_data(c:end)     = [];
            obj.children_indices(c:end) = [];
            obj.n_objs = current_object_index;
            obj.processed = false(1,obj.n_objs);
            obj.logged_objects = cell(1,obj.n_objs);
        end
        function finalize(obj)
            t = obj.getTable();
            s = table2struct(t);
            obj.struct_array = s;
        end
        function doObjectLinking(obj)
            %
            %
            %   Called by: epworks.iom_parser.translateData
            
            %Logging is simply to make it easier to iterate over
            %the objects
            for i = 1:length(obj.logged_objects)
                cur_obj = obj.logged_objects{i};
                if ~isempty(cur_obj)
                    cur_obj.linkObjects(obj.id_tracker);
                end
            end
        end
        function s = getStruct(obj,index)
            s = obj.struct_array(index);
            % t = obj.getTable('index',index);
            % s = table2struct(t);
        end
        function logObject(obj,obj_to_log,index)
            obj.logged_objects{index} = obj_to_log;
            obj.n_logged_objects = obj.n_logged_objects + 1;
        end
        function logID(obj,obj_to_log,id)
            obj.id_tracker.logID(obj_to_log,id);
        end
        function [t,I] = getTable(obj,varargin)

            in.type = [];
            in.index = [];
            in = sl.in.processVarargin(in,varargin);

            if ~isempty(in.type)
                mask = in.type == obj.type;
            elseif ~isempty(in.index)
                mask = false(1,obj.n_objs);
                mask(in.index) = true;
            else
                mask = true(1,obj.n_objs);
            end

            depth = obj.depth(mask)';
            n_bytes = obj.total_byte_length(mask)';
            raw_start_I = obj.raw_start_I(mask)';
            raw_stop_I = obj.raw_end_I(mask)';
            name = obj.name(mask)';
            full_name = obj.full_name(mask)';
            type = obj.type(mask)';
            n_props = obj.n_props(mask)';
            data_start_I = obj.data_start_I(mask)';
            data_length = obj.data_length(mask)';
            data_value = obj.data_value(mask)';
            raw_data = obj.raw_data(mask)';
            child_indices = obj.children_indices(mask)';
            t = table(depth,n_bytes,raw_start_I,raw_stop_I,name,full_name,...
                type,n_props,data_start_I,data_length,...
                data_value,raw_data,child_indices);

            I = find(mask);


        end
    end

end

