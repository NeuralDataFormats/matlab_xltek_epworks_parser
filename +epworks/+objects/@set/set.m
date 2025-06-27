classdef set < epworks.objects.result_object
    %
    %   Class:
    %   epworks.objects.set
    %
    %   See Also
    %   --------
    %   epworks.main
    %   epworks.objects.trace
    %   epworks.p.iom.set
    %   epworks.p.iom.set.data

    properties (Hidden)
        %These are properties that are IDs
        %
        %   When the objects are created, these properties get replaced
        %   with the actual objects, rather than the IDs.
        id_props = {}
    end

    properties
        % name
        % 
        % state
        % %Observed values:
        % %- 2
        % 
        % signal_type
        % 
        % sweeps_per_avg
        % 
        % trigger_delay
        % 
        % parent
        % traces
        % sets
        schema
        set_number

    end

    methods
        function obj = set(p_main,p,logger)
            %
            %
            %   Inputs
            %   ------
            %   p_main
            %   p : epworks.p.iom.group
            %   logger : 

            obj = obj@epworks.objects.result_object(p,logger);
            
            obj.schema = p.schema;
            obj.set_number = p.data.set_number;

            if p.n_children > 0
                keyboard
            end

            % obj.name = p.data.name;
            % obj.state = p.data.state;
            % obj.signal_type = p.data.signal_type;
            % obj.sweeps_per_avg = p.data.sweeps_per_avg;
            % obj.trigger_delay = p.data.trigger_delay;
            % 
            % obj.parent = p.parent.id;
            % obj.traces = {p.traces.id};
            % obj.sets = {p.sets.id};
        end
        function processPostLinking(objs)
            keyboard
        end
    end
end