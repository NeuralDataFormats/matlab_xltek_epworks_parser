classdef id_tracker < handle
    %
    %   Class:
    %   epworks.parse.id_tracker
    %
    %   See Also
    %   ---------

    properties
        map containers.Map
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
            if isKey(obj.map,id2)
                %TODO: Have optional warning that can be surpressed
                %error("Redundant logging of ID, fix code")
            else
                obj.map(id2) = obj_to_log;
            end
        end
        function out = getObjectByID(obj,id)
            %
            %
            %   id: [1x16] uint8 OR {[1x16] uint8]}

            if iscell(id)
                out = cell(1,length(id));
                for i = 1:length(id)
                    temp = id{i};
                    id2 = char(temp);
                    try
                        out{i} = obj.map(id2);
                    end
                end
            else
                id2 = char(id);
    
                if isKey(obj.map,id2)
                    out = obj.map(id2);
                else
                    out = [];
                end
            end
        end
    end
end