classdef version_info < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.iom.test.version_info

    properties
        s
        raw_data
    end

    methods
        function obj = version_info(s,r)
            r.logObject(obj);
            obj.raw_data = s;
        end
    end
end