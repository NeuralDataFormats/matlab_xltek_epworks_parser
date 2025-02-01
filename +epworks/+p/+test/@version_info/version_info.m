classdef version_info
    %
    %   Class:
    %   epworks.p.test.version_info

    properties
        s
        raw_data
    end

    methods
        function obj = version_info(s,r)
            obj.s = s;
            obj.raw_data = s.raw_data;
        end
    end
end