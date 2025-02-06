classdef trace < epworks.objects.result_object
    %
    %   Class:
    %   epworks.objects.trace
    %
    %   See Also
    %   --------
    %   epworks.main

    properties
        name
        state
        origin_x
        origin_y
        data
    end

    methods
        function obj = trace(p_main,p,logger)
            obj = obj@epworks.objects.result_object(p,logger);
            obj.p = p;
            obj.name = p.name;
            obj.state = p.data.state;
            obj.origin_x = p.data.origin_x;
            obj.origin_y = p.data.origin_y;

            if ~isempty(p.rec_data)
                obj.data = epworks.objects.signal(p.rec_data,obj.name);
            end
        end
    end
end