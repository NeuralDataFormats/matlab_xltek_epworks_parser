classdef eeg_waveform < epworks.objects.result_object
    %
    %   Class:
    %   epworks.objects.eeg_waveform
    %
    %   See Also
    %   --------
    %   epworks.main
    %   epworks.objects.trace
    %   epworks.objects.signal
    %   epworks.objects.triggered_waveform
    %   epworks.objects.freerun_waveform
    %   epworks.p.re    

    properties (Hidden)
        id_props = {'parent','trace'}
    end

    
    properties
        name
        group_name
        lff_cutoff
        hff_cutoff
        notch_cutoff
        parent
        trace
        note = 'should really use getData() instead of accessing .data'

        %When does this get populated?
        %   - constructor, loads based on IDs found in REC files
        %
        %   
        data epworks.objects.signal

        trace_id
    end

    properties (Dependent)
        n_snippets
    end

    methods
        function value = get.n_snippets(obj)
            if isempty(obj.data)
                value = 0;
            else
                value = obj.data.n_snippets;
            end
        end
    end

    methods
        function obj = eeg_waveform(p_main,p,logger)
            %
            %
            %   Inputs
            %   ------
            %   p_main : epworks.parse.main
            %   p : epworks.p.iom.eeg_waveform
            %   logger : epworks.parse.iom.logger

            obj = obj@epworks.objects.result_object(p,logger);
            obj.name = p.data.trace_obj.name;
            obj.lff_cutoff = p.data.lff_cutoff;
            obj.hff_cutoff = p.data.hff_cutoff;
            obj.notch_cutoff = p.data.notch_cutoff;

            obj.parent = p.parent.id;
            
            %This gets overridden with the object
            obj.trace = p.data.trace_obj.id;

            %This we will not override
            obj.trace_id = obj.trace;

            wtg = p_main.getWaveformTraceGroupFromTraceID(obj.trace);
            if ~isempty(wtg)
                obj.data = epworks.objects.signal(wtg,p.data.trace_obj.name);
            end

        end
        function s = getData(obj,index,in)
            %X Retrieves data with optional filtering
            %
            %   s = getData(obj,index,varargin)
            %
            %   Inputs
            %   ------
            %   index :
            %       Which snippet to extract.
            %
            %   Optional Inputs
            %   ---------------
            %   filter : logical, default false
            %       If true the data are filtered. Cutoffs must be > 0
            %       to be used. Set to -1 to ignore/disable
            %       Note filtering is currently done using Butterworth
            %       filters with no phase correction (filter function,
            %       not filt/filt)
            %   time_format :
            %       - datetime - default
            %       - numeric - starting at 0 (in seconds)
            %       - none
            %       Specifies the format of the returned time array
            %   notch_width : default 20
            %   notch_order : default 8
            %
            %   Outputs
            %   -------
            %       s
            %
            %   This does:
            %   1. computes time array (if desired)
            %   2. filters
            %
            %   Note, there is a discrepancy between this and what is
            %   shown in the appplication - need to access:
            %   f.tests.raw_settings.eeg.applied_montage_key_tree.channels
            %
            %   Improvements
            %   ------------
            %   1. May want to return as an object with extra meta 
            %   info that allows nice plotting (stacking) like the
            %   triggered and freerun waveforms

            arguments
                obj epworks.objects.eeg_waveform
                index (1,1) {mustBeNumeric}
                in.filter (1,1) {mustBeNumericOrLogical} = false
                in.time_format {mustBeMember(in.time_format,{'datetime','numeric','none'})} = 'datetime';
                in.notch_width (1,1) {mustBeNumeric} = 20
                in.notch_order (1,1) {mustBeNumeric} = 8
                %I grabbed these from the defaults settings ...
                %
                %   Under, customize -> waveforms
                %
                %Not sure where to find if they have been updated
                in.hff_order (1,1) {mustBeNumeric} = 4
                in.lff_order (1,1) {mustBeNumeric} = 2
            end

            s = struct();
            
            d = obj.data.data{index};

            s.raw_data = d;

            if in.filter
                d2 = d;
                half_fs = obj.data.fs/2;
                if obj.lff_cutoff > 0
                    [B,A] = butter(1,obj.lff_cutoff/half_fs,"high");
                    d2 = filter(B,A,d2);
                end
                if obj.hff_cutoff > 0
                    [B,A] = butter(1,obj.hff_cutoff/half_fs,"low");
                    d2 = filter(B,A,d2);
                end
                if obj.notch_cutoff > 0
                    hw = 0.5*in.notch_width;
                    f1 = obj.notch_cutoff-hw;
                    f2 = obj.notch_cutoff+hw;

                    wn = [f1 f2]./half_fs;
                    [B,A] = butter(in.notch_order,wn,"stop");
                    d2 = filter(B,A,d2);
                end
                d = d2;
            end

            s.data = d;

            switch in.time_format
                case 'datetime'
                    t0 = obj.data.t0(index);
                    n_samples = length(d);
                    t = 0:(n_samples-1);
                    s.time = t0 + seconds(t/obj.data.fs);
                case 'numeric'
                    n_samples = length(d);
                    t = 0:(n_samples-1);
                    s.time = t/obj.data.fs;
                case 'none'
                    s.time = [];
            end

        end
    end
    methods (Hidden)
        function processPostLinking(objs)
            for i = 1:length(objs)
                obj = objs(i);
                obj.group_name = obj.trace.group_name;
            end
        end
    end
end