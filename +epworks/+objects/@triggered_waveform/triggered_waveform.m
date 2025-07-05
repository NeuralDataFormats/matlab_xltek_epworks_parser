classdef triggered_waveform < epworks.objects.result_object
    %
    %   Class:
    %   epworks.objects.triggered_waveform
    %
    %   This primarily holds the info for the stimulation.
    %
    %   It also holds the data but I need to fix some redundancy issues
    %   with respect to the trace.
    %
    %   ??? When is the stimulus
    %
    %   ?? How many 
    %
    %   - Sets
    %   - triggered waveform - points to sets
    %   - traces
    %
    %   Steps
    %   -----
    %   1) For each trace, find how many times
    %   it is listed as a triggered waveform
    %       - does this align with the # of data
    %       points
    %
    %   I guess what I am asking is whether you can
    %   have something be triggered and also not triggered
    %
    %   - unique triggered_waveforms
    %   - 
    %
    %
    %
    %   See Also
    %   --------
    %   epworks.main
    %   epworks.objects.trace
    %   epworks.objects.signal
    %   epworks.objects.eeg_waveform
    %   epworks.objects.freerun_waveform
    %   epworks.p.iom.triggered_waveform
    %
    %   

    properties (Hidden)
        id_props = {'parent','trace','set'}
    end

    properties
        name
        group_name
        lff_cutoff
        hff_cutoff
        notch_cutoff
        
        color
        stim_intensity
        trigger_delay

        is_captured
        is_for_review
        is_from_history
        is_grabbed

        is_rejected_data
        
        parent
        trace
        set
        
        %epworks.objects.signal
        data
        t0 = NaT
        fs = NaN
        n_samples = 0

        source_data

        n_children

        %Note, the data is populated afterwards by the main object
        %after we have linked the trace object
    end

    properties (Dependent)
        set_number
        trace_id
        time
    end

    methods
        function value = get.set_number(obj)
            %   Note, this doesn't work until 
            %   the set object has been populated
            if isempty(obj.set)
                value = NaN;
            else
                value = obj.set.set_number;
            end
        end
        function value = get.trace_id(obj)
            if isempty(obj.trace)
                value = zeros(1,16,'uint8');
            else
                value = obj.trace.id;
            end
        end
        function value = get.time(obj)
            if isempty(obj.data)
                value = [];
            else
                n_m_1 = length(obj.data) - 1;
                value = obj.t0 + seconds((0:n_m_1)/obj.fs);
            end
        end
    end

    methods
        function obj = triggered_waveform(p_main,p,logger)
            %
            %
            %   Inputs
            %   ------
            %

            obj = obj@epworks.objects.result_object(p,logger);
            d = p.data;
            obj.name = d.trace_obj.name;
            obj.lff_cutoff = d.lff_cutoff;
            obj.hff_cutoff = d.hff_cutoff;
            obj.notch_cutoff = d.notch_cutoff;
            obj.color = d.color;
            obj.stim_intensity = d.saved_stim_intensity;
            obj.trigger_delay = d.trigger_delay;
            obj.source_data = d.source_data;

            obj.is_captured = d.is_captured;
            obj.is_for_review = d.is_for_review;
            obj.is_from_history = d.is_from_history;
            obj.is_grabbed = d.is_grabbed;
            obj.is_rejected_data = d.is_rejected_data;

            obj.parent = p.parent.id;
            obj.trace = d.trace_obj.id;

            [mask,loc] = ismember(obj.id,p_main.waveform_ids,'rows');

            if mask
                w = p_main.all_waveforms(loc);
                obj.data = w.data;
                obj.t0 = w.timestamp;
                obj.fs = w.fs;
                obj.n_samples = length(obj.data);
            end
            
            obj.set = d.set_obj.id;

            obj.n_children = p.n_children;
        end
        function s = plot(objs,options)
            %
            %
            %   TODO: Lots of possible improvements here
            %
            %   Filtering not yet implemented ...
            %
            %   Outputs
            %   -------
            %   s : struct
            %       .h_plot
            %       .h_label

            arguments
                objs
                options.time_units string {mustBeMember(options.time_units, ["datetime", "duration", "numeric"])} = "duration"
                options.filter = false; %NYI
                options.add_chan_label = true;
                options.reverse_y = true;
            end

            n_objs = length(objs);

            %TODO: Check that we have duration on x axis

            origin_y = zeros(n_objs,1);

            %We could eventually update this
            ax = gca;

            s = struct;
            h_plot = struct;
            hold(ax,"on")
            for i = 1:length(objs)
                obj = objs(i);
                %What does a origin_x shift mean???
                x = obj.time;
                switch options.time_units
                    case "datetime"
                        %done
                    case "duration"
                        %Without this the labeling was not great
                        x = x - x(1);
                        if x(end) < seconds(1)
                            x = milliseconds(milliseconds(x));
                        end
                    case "numeric"
                        x = seconds(x - x(1));
                end

                h_temp = plot(x,obj.data+obj.trace.origin_y);
                safe_name = epworks.utils.getSafeVariableName(obj.name);
                h_plot.(safe_name) = h_temp;
                origin_y(i) = obj.trace.origin_y;
            end
            hold(ax,"off")

            if options.reverse_y 
                ax.YDir = "reverse";
            end
            
            

            %Labels - do this after all plots to establish limits
            %--------------------------------------------------------------
            xlim = ax.XLim;

            h_label = struct;
            for i = 1:length(objs)
                obj = objs(i);
                yval = obj.trace.origin_y;
                h_temp = text(xlim(1), yval, obj.name, ...
                    'VerticalAlignment', 'bottom', ...
                    'HorizontalAlignment', 'left');
                safe_name = epworks.utils.getSafeVariableName(obj.name);
                h_label.(safe_name) = h_temp;

            end

            s.h_plot = h_plot;
            s.h_label = h_label;
           % keyboard

        end
    end
end