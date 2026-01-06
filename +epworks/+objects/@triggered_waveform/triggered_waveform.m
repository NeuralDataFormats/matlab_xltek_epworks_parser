classdef triggered_waveform < epworks.objects.result_object
    %
    %   Class:
    %   epworks.objects.triggered_waveform
    %
    %   Note this is exposed to the user in the class:
    %   epworks.objects.triggered_waveform_group
    %
    %   Structure
    %   ---------
    %   file
    %       .triggered_waveforms (triggered_waveform_group)
    %           .trig_objs (this class)
    %
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
    %       - does this align with the # of data points
    %
    %   I guess what I am asking is whether you can
    %   have something be triggered and also not triggered
    %
    %   Note, in the implementation we don't prevent a waveform from being
    %   in both. Our search for triggered waveforms is over all waveforms,
    %   not over the list of waveforms that are not used elsewhere.
    %
    %   See epworks.parse.main, note when 'waveform_ids' gets populated
    %   relative to the grouping of waveforms (which is used for continuous
    %   data plotting). Below we use 'waveform_ids' to grab our data.
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

        source_data %What is this?

        n_children

        %Note, the data is populated afterwards by the main object
        %after we have linked the trace object
    end

    properties (Dependent)
        set_number
        trace_id
        time
        origin_y
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
        function value = get.origin_y(obj)
            if isempty(obj.trace)
                value = 0;
            else
                value = obj.trace.origin_y;
            end
        end
    end

    methods
        function obj = triggered_waveform(p_main,p,logger)
            %
            %
            %   Inputs
            %   ------
            %   p_main : epworks.parse.main
            %
            %   See Also
            %   --------
            %   epworks.objects.triggered_waveform_group

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

            %Grab data, if available
            %-----------------------------------------------------------
            [mask,loc] = ismember(obj.id,p_main.waveform_ids,'rows');

            if mask
                %This is a debugging step
                p_main.used_waveform_ids(loc) = 1;

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
            %
            %   Optional Inputs
            %   ---------------
            %   spacing:
            %     -'file' from file
            %     -'data' from data - note, this becomes hard across sets
            %           (NYI)
            %    - scalar - scaling proportional to file
            %       > 1 - more spacing
            %       < 1 - less spacing
            %       e.g., 2 is twice as much spacing as estimated from file
            %
            %    - numeric array - hardcoded offsets for each channel
            %    - [] - everything level but with legend (legend NYI)
            %
            %   See Also
            %   --------
            %   epworks.objects.set

            arguments
                objs
                options.time_units string {mustBeMember(options.time_units, ["datetime", "duration", "numeric"])} = "duration"
                options.filter = false; %NYI
                options.add_chan_label = true;
                options.reverse_y = true;

                %Spacing options
                %---------------
                %NYI
                %- 'file' from file
                %- 'data' from data - note, this becomes hard across sets
                %           (NYI)
                %- #### - scaling based on file
                %       - use 1 as default for easier interpretation
                %- array - hardcoded offsets
                %- [] - everything level but with legend (legend NYI)

                options.spacing = 'file';
                options.clear_axes = true;

                %For 
                options.color = []; %NYI
            end

            n_objs = length(objs);

            %TODO: Check that we have duration on x axis


            if strcmpi(options.spacing,'file') || ...
                    (isnumeric(options.spacing) && isscalar(options.spacing))
                %For display gain I only want to change the spacing, not
                %the actual scaling on the plot
                %
                %   These are ideally equivalent. By reducing spacing we make
                %   each signal larger on the plot (for a given y-range)

                if strcmpi(options.spacing,'file') 
                    k = 1;
                else
                    k = options.spacing;
                end

                origin_y2 = [objs.origin_y];
                left_disp_gains = zeros(1,n_objs);
                for i = 1:length(objs)
                    obj = objs(i);
                    try
                        left_disp_gains(i) = obj.trace.o_chan.left_display_gain;
                    end
                end
    
                left_disp_gain_avg = median(left_disp_gains,'omitmissing');
                if isnan(left_disp_gain_avg)
                    left_disp_gain_avg = 1;
                end
    
                %This 0.5 and /50 is approximate. As you change the 
                %plot size in the program these change. But in general this
                %gets us pretty close.
                %
                %   This may be in the waveform views:
                %   epworks.p.test.data.settings.element_layouts.elements.waveform_view
                origin_y2 = k*0.50*origin_y2*left_disp_gain_avg/50;
            elseif strcmpi(options.spacing,'data')
                error('Not yet implemented')
            elseif length(options.spacing) == n_objs
                origin_y2 = options.spacing;
            elseif isempty(options.spacing)
                origin_y2 = zeros(n_objs,1);
            else
                error('Unrecognized spacing option')
            end

            %We could eventually update this
            ax = gca;
            if options.clear_axes
                cla(ax);
            end

            s = struct;
            h_plot = struct;
            hold(ax,"on")
            for i = 1:length(objs)
                obj = objs(i);
                safe_name = epworks.utils.getSafeVariableName(obj.name);
                %What does a origin_x shift mean???
                x = obj.time;
                if isempty(x)
                    h_temp = [];
                else
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

                    y = obj.data + origin_y2(i);

                    color_options = {};
                    if isstruct(options.color) && isfield(options.color,safe_name)
                        color2 = options.color.(safe_name);
                        color_options = {'color' color2};
                    end
                    h_temp = plot(x,y,color_options{:});

                end

                
                h_plot.(safe_name) = h_temp;
            end
            hold(ax,"off")

            if options.reverse_y 
                ax.YDir = "reverse";
            end
            
            

            %Labels - do this after all plots to establish x limits
            %--------------------------------------------------------------
            xlim = ax.XLim;

            h_label = struct;
            for i = 1:length(objs)
                obj = objs(i);
                y_val = origin_y2(i);
                h_temp = text(xlim(1), y_val, obj.name, ...
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