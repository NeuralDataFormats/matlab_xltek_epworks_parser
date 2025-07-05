classdef set < epworks.objects.result_object
    %
    %   Class:
    %   epworks.objects.set
    %
    %   Why are the sets not unique in number? In one test file I am
    %   getting 408 objects and 221 unique set numbers.
    %
    %   Answer: because each set object points to a group. So multiple
    %   groups could share the same set number.
    %   
    %
    %   Parent:
    %   epworks.objects.group
    %
    %   Children:
    %   epworks.objects.triggered_waveform
    %
    %
    %   See Also
    %   --------
    %   
    %   epworks.main
    %   epworks.objects.trace
    %   epworks.p.iom.set
    %   epworks.p.iom.set.data

    properties (Hidden)
        %These are properties that are IDs
        %
        %   When the objects are created, these properties get replaced
        %   with the actual objects, rather than the IDs.
        id_props = {'parent'}
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


        parent %parent is group

        group_name
        triggered_waveforms epworks.objects.triggered_waveform
        % traces
        % sets
        schema
        set_number

        %It is unclear what these mean ...
        is_iom_local_object
        is_active
        is_from_history
        num_accepted
        num_rejected
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
                error('Unhandled case')
                keyboard
            end

            d = p.data;

            obj.parent = p.parent.id;

            obj.is_iom_local_object = d.iom_local_object;
            obj.is_active = d.is_active;
            obj.is_from_history = d.is_from_history;
            obj.num_accepted = d.num_accepted;
            obj.num_rejected = d.num_rejected;
        end
        function processPostLinking(objs)
            for i = 1:length(objs)
                objs(i).group_name = objs(i).parent.name;
            end
        end
        function plot(objs,options)
            %
            %   See Also
            %   --------
            %   epworks.objects.triggered_waveform>plot
            %
            %   Improvements
            %   ------------
            %   1. Allow a slight shift with each trigger

            arguments
                objs
                options.time_units string {mustBeMember(options.time_units, ["datetime", "duration", "numeric"])} = "duration"
                options.filter = false; %NYI
                options.add_chan_label = true;
                options.reverse_y = true;
            end

            %TODO: Validate that this is from one group/trace

            options_original = options;
            %TODO: Add on options for TW here
            for i = 1:length(objs)
                obj = objs(i);
                tw = obj.triggered_waveforms;
                if ~isempty(tw)
                    options = options_original;
                    if i ~= length(objs)
                        options.add_chan_label = false;
                    end
                    options_cell = epworks.sl.in.structToPropValuePairs(options);
                    plot(tw,options_cell{:});
                end
                if isscalar(objs)
                    title(sprintf('Set # %d',obj.set_number));
                end
            end

            if length(objs) > 1
                set_numbers = [objs.set_number];
                sprintf('Sets: %s',mat2str(set_numbers));
            end
        end
    end
end