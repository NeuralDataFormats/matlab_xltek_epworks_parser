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

    properties (Hidden)
        id_props = {'parent','trace'}
    end

    properties
        name
        lff_cutoff
        hff_cutoff
        notch_cutoff
        parent
        trace
        note = 'should really use getData() instead of accessing .data'
        data epworks.objects.signal
    end

    methods
        function obj = eeg_waveform(p_main,p,logger)
            obj = obj@epworks.objects.result_object(p,logger);
            obj.name = p.data.trace_obj.name;
            obj.lff_cutoff = p.data.lff_cutoff;
            obj.hff_cutoff = p.data.hff_cutoff;
            obj.notch_cutoff = p.data.notch_cutoff;

            obj.parent = p.parent.id;
            %Is this needed, I think the parent is the same
            obj.trace = p.data.trace_obj.id;

            %???? How is .data populated?
            %   - must be from: epworks.objects.result_object

        end
        function s = getData(obj,index,in)
            %
            %
            %   TODO: document
            %
            %   This does:
            %   1. computes time array (if desired)
            %   2. filters
            %
            %   Note, there is a discrepancy between this and what is
            %   shown in the appplication - need to access:
            %   f.tests.raw_settings.eeg.applied_montage_key_tree.channels

            arguments
                obj epworks.objects.eeg_waveform
                index (1,1) {mustBeNumeric}
                in.filter (1,1) {mustBeNumericOrLogical} = false
                in.time_format {mustBeMember(in.time_format,{'datetime','numeric','none'})} = 'datetime';
                in.notch_width (1,1) {mustBeNumeric} = 20
                in.notch_order (1,1) {mustBeNumeric} = 8
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
end