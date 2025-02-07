classdef group < epworks.objects.result_object
    %
    %   Class:
    %   epworks.objects.group
    %
    %   See Also
    %   --------
    %   epworks.main
    %   epworks.objects.trace

    properties (Hidden)
        id_props = {'parent','traces'}
    end

    properties
        name
        state
        sweeps_per_avg
        trigger_delay

        parent
        traces
    end

    methods
        function obj = group(p_main,p,logger)
            obj = obj@epworks.objects.result_object(p,logger);
            obj.name = p.data.name;
            obj.state = p.data.state;
            obj.sweeps_per_avg = p.data.sweeps_per_avg;
            obj.trigger_delay = p.data.trigger_delay;

            obj.parent = p.parent.id;
            obj.traces = {p.traces.id};
        end
    end
end