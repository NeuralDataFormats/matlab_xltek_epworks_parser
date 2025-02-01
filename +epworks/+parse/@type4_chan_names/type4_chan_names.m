classdef type4_chan_names
    %
    %   Class:
    %   epworks.parse.type4_chan_names

    properties
        name
        full_name
        raw_data
        n_props
        
    end

    methods
        function obj = type4_chan_names(s)
            %
            %   obj = epworks.parse.type4_chan_names
            obj.name = s.name;
            obj.full_name = s.full_name;
            obj.raw_data = s.raw_data;
            obj.n_props = s.n_props;

            if isequal(obj.raw_data,uint8([0 0 0 0]))
                return
            end
        end
    end
end