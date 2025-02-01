classdef type4_children
    %
    %   Class:
    %   epworks.parse.type4_children

    properties
        name
        full_name
        raw_data
        n_props
    end

    methods
        function obj = type4_children(s)
            %
            %   obj = epworks.parse.type4_children
            obj.name = s.name;
            obj.full_name = s.full_name;
            obj.raw_data = s.raw_data;
            obj.n_props = s.n_props;

            if isequal(obj.raw_data,uint8([0 0 0 0]))
                return
            end

            %TODO: Do processing here ...
        end
    end
end