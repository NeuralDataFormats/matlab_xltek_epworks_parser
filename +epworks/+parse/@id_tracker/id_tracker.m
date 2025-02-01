classdef id_tracker < handle
    %
    %   Class:
    %   epworks.parse.id_tracker

    properties
        map
    end

    methods
        function obj = id_tracker()
            obj.map = containers.Map('KeyType','char','ValueType','any');
        end
        function logID(obj,obj_to_log,id)
            %
            %   id: 16 bytes
            id2 = char(id);

            %Note, if this is slow we can store as a matrix, as we
            %always have 16 bytes ...

            obj.map(id2) = obj_to_log;
        end
        function out = getObjectByID(obj,id)
            id2 = char(id);

            if isKey(obj.map,id2)
                out = obj.map(id2);
            else
                out = [];
            end
        end
    end
end