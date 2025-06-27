classdef settings < epworks.objects.result_object
    %
    %   Class:
    %   epworks.objects.test.settings
    %
    %   See Also
    %   --------
    %   epworks.objects.test

    properties (Hidden)
        %id_props = {'parent','traces'}
        id_props = {};
    end

    properties
        raw
    end

    methods
        function obj = settings(p_main,p,logger)
            obj = obj@epworks.objects.result_object(p,logger);
            obj.raw = p;
        end
    end
end