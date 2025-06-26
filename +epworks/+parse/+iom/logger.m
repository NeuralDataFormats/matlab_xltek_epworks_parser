classdef logger < handle
    %
    %   Class:
    %   epworks.parse.iom.logger
    %
    %   This gets passed to object construction both in the initial parse 
    %   and the population of MATLAB objects.
    %
    %   It makes it easier to do logging and to iterate over objects
    %
    %   See Also

    properties
        first_past_object_count = 0
        logging_index = 0
        logged_objects
        time_offset

        %This one is for parsing
        id_tracker epworks.parse.id_tracker

        %This one is for the final object construction
        id_tracker2 epworks.parse.id_tracker

        %NOT USED, for reference
        %TODO: Move to raw_object
        type

        %-1 : nothing
        % 0 : 4 bytes, format varies
        % 1 : double
        % 2 : string
        % 3 : 16 bytes (not always), IDs or times
        % 4 : array?
        % 5 : object
        % 6 : GUIds???
    end

    methods
        function obj = logger()
            obj.id_tracker = epworks.parse.id_tracker;
            obj.id_tracker2 = epworks.parse.id_tracker;
        end
        function initializeObjectHolder(obj)
            obj.logged_objects = cell(1,obj.first_past_object_count);
        end
        function logEntry(obj)
            obj.first_past_object_count = obj.first_past_object_count + 1;
            %fprintf('Object: %d\n',obj.I)
        end
        function logObject(obj,obj_to_log)
            obj.logging_index = obj.logging_index + 1;
            obj.logged_objects{obj.logging_index} = obj_to_log;
        end
        function logID(obj,obj_to_log,id)
            obj.id_tracker.logID(obj_to_log,id);
        end
        function logUnknownID(obj,description,id)
            obj.id_tracker2.logID(description,id);
        end
        function doObjectLinking(obj)
            %
            %
            
            %Logging is simply to make it easier to iterate over
            %the objects
            for i = 1:length(obj.logged_objects)
                cur_obj = obj.logged_objects{i};
                if ~isempty(cur_obj)
                    cur_obj.linkObjects(obj.id_tracker);
                end
            end
        end
        function out = getDescByUnknownID(obj,id)
            out = obj.id_tracker2.getObjectByID(id);
        end
        function out = getObjectByID(obj,id)
            out = obj.id_tracker.getObjectByID(id);
        end
        function convertChildrenToProps(obj)
            for i = 1:length(obj.logged_objects)
                cur_obj = obj.logged_objects{i};
                if ~isempty(cur_obj)
                    cur_obj.childrenToProps(obj);
                end
            end
        end
    end
end