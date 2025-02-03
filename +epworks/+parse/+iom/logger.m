classdef logger < handle
    %
    %   Class:
    %   epworks.parse.iom.logger
    %
    %   This gets passed to object construction
    %   both in the initial parse and the population of MATLAB objects.
    %
    %   It makes it easier to do logging and to iterate over objects
    %
    %   See Also

    properties
        first_past_object_count = 0
        logging_index = 0
        all_objects

        id_tracker epworks.parse.id_tracker

        %NOT USED, for reference
        %TODO: Move to raw_object
        type

        %-1 : nothing
        % 0 : 4 bytes, format varies
        % 1 : double
        % 2 : string
        % 3 : 16 bytes, IDs or times
        % 4 : array?
        % 5 : object
        % 6 : GUIds???
    end

    methods
        function obj = logger()
            obj.id_tracker = epworks.parse.id_tracker;
        end
        function initializeObjectHolder(obj)
            obj.all_objects = cell(1,obj.first_past_object_count);
        end
        function logEntry(obj)
            obj.first_past_object_count = obj.first_past_object_count + 1;
            %fprintf('Object: %d\n',obj.I)
        end
        function logObject(obj,obj_to_log)

        end
        function logID(obj,obj_to_log,id)
            obj.id_tracker.logID(obj_to_log,id);
        end
    end
end