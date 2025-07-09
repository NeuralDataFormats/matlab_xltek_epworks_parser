classdef group < epworks.objects.result_object
    %
    %   Class:
    %   epworks.objects.group
    %
    %   See Also
    %   --------
    %   epworks.main
    %   epworks.objects.trace
    %   epworks.p.iom.group

    properties (Hidden)
        %These are properties that are IDs
        %
        %   When the objects are created, these properties get replaced
        %   with the actual objects, rather than the IDs.
        id_props = {'parent','traces','sets'}
    end

    properties
        name
        
        state
        %Observed values:
        %- 2

        is_eeg_group

        signal_type
        %0 - Free Run
        %3 - Normal Avg
        %1 - Triggered

        %MISSING - need to import
        %
        %stim_delay
        %   0 ms
        %   107 ms
        %   ---
        %
        %Timeline 
        %   Time 1 
        %   ----
        %   None
        %   Timeline 3
        %   Timeline 2
        %
        %Disp Mode
        %    Replace
        %    Vertical Curve Stack
        %
        %Disp Stack
        %    Traces Stack
        %    ----
        %
        %Nb. Div
        %    10
        %    -----

        sweeps_per_avg

        trigger_delay %ms
        stim_delay = NaN

        parent
        traces
        trace_info
        sets
        set_info

        note = 'settings is experimental and may change'
        settings
        %For EEG this can get you to the layout
        
        group_def_raw
    end

    methods
        function obj = group(p_main,p,logger)
            %
            %
            %   Inputs
            %   ------
            %   p_main
            %   p : epworks.p.iom.group
            %   logger : 

            obj = obj@epworks.objects.result_object(p,logger);
            obj.name = p.data.name;
            obj.state = p.data.state;
            obj.is_eeg_group = p.data.is_eeg_group;
            obj.signal_type = p.data.signal_type;
            obj.sweeps_per_avg = p.data.sweeps_per_avg;
            obj.trigger_delay = p.data.trigger_delay;

            if ~isempty(p.data.trigger_source)
                obj.stim_delay = p.data.trigger_source.delay;
            end
            
            obj.parent = p.parent.id;
            
            if ~isempty(p.traces)
                obj.traces = {p.traces.id};
            end
            
            if ~isempty(p.sets)
                obj.sets = {p.sets.id};
            end

        end
        function snips = getSnippets(obj,target,options)
            %
            %
            %   Inputs
            %   ------
            %   target
            %
            %   Optional Inputs
            %   ---------------
            %   near
            %   between
            %
            %   See Also
            %   --------
            %   epworks.objects.snippet_group

            arguments
                obj
                target
                options.near = [];
                options.between = [];
            end

            options = epworks.sl.in.structToPropValuePairs(options);
            snips = epworks.objects.snippet_group(obj.traces,target,options{:});
        end
        function set_objs = getSets(obj,set_numbers)
            [mask,loc] = ismember(set_numbers,obj.set_info.set_number);
            if ~all(mask)
                error('Unable to find all sets')
            end
            set_objs = obj.sets(loc);
        end
    end

    methods (Hidden)
        function processPostLinking(objs,test,options)
            %
            %
            %   Inputs
            %   ------
            %   objs
            %   test
            %   options

            group_defs = test.settings.raw.group_def;
            group_def_names = {group_defs.name};
            for i = 1:length(objs)
                obj = objs(i);

                if obj.is_eeg_group
                    %ASSUMPTION: This would cause problems if
                    %we have more than 1 EEG group
                    obj.settings = test.settings.raw.eeg;
                end

                obj.group_def_raw = group_defs(strcmpi(obj.name,group_def_names));

                if ~isempty(obj.traces)
                    origin_y = [obj.traces.origin_y]';
    
                    if options.sort_by_display
                        try %#ok<TRYNC>
                            if obj.is_eeg_group
                                c = obj.settings.applied_montage_key_tree.channels;
                                trace_names = string({obj.traces.name}');
                                montage_names = string({c.to_name});
                                %Montage names appear to be shorter (at least
                                %sometimes)
            
                                loc = zeros(1,length(montage_names));
                                for i = 1:length(montage_names)
                                    loc(i) = find(trace_names.contains(montage_names(i)),1);
                                end
    
                                obj.traces = obj.traces(loc);
                                origin_y = [obj.traces.origin_y]';
                            else
                                [origin_y,I] = sort(origin_y);
                                obj.traces = obj.traces(I);
                            end
                        end
                    end
    
    
                    %Trace Info Population
                    %----------------------------------------------------------
                    index = (1:length(obj.traces))';
                    name = string({obj.traces.name}'); %#ok<PROPLC>
                    origin_x = [obj.traces.origin_x]';
                    
                    if obj.is_eeg_group
                        y_order = (1:length(obj.traces))';
                    else
                        [~,I] = sort(origin_y);
                        rank = zeros(length(I),1);
                        rank(I) = 1:length(I);
                        y_order = rank;
                    end
                    obj.trace_info = table(index,name,origin_x,origin_y,y_order); %#ok<PROPLC>
                end

                %Set Info Population
                %----------------------------------------------------------
                if ~isempty(obj.sets)
                    set_numbers = [obj.sets.set_number];
                    [~,I] = sort(set_numbers);
                    obj.sets = obj.sets(I);
                end


            end
        end
        function processPostLinking2(objs)
            %
            %   This is done later because we need sets to have their
            %   triggered waveforms. This organization is ugly but it works
            %   for now
            for i = 1:length(objs)
                obj = objs(i);
                if ~isempty(obj.sets)
                    index = (1:length(obj.sets))';
                    set_number = [obj.sets.set_number]';
                    is_iom_local = [obj.sets.is_iom_local_object]';
                    is_active = [obj.sets.is_active]';
                    is_from_history = [obj.sets.is_from_history]';
                    num_accepted = [obj.sets.num_accepted]';
                    num_rejected = [obj.sets.num_rejected]';
                    n_data = arrayfun(@(x) length(x.triggered_waveforms),obj.sets)';
    
                    obj.set_info = table(index,set_number,is_iom_local,is_active,...
                        is_from_history,num_accepted,num_rejected,n_data);
                end

            end
        end

    end
end