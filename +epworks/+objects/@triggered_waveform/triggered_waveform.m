classdef triggered_waveform < epworks.objects.result_object
    %
    %   Class:
    %   epworks.objects.triggered_waveform
    %
    %   See Also
    %   --------
    %   epworks.main
    %   epworks.objects.trace
    %   epworks.objects.signal
    %   epworks.objects.eeg_waveform
    %   epworks.p.iom.triggered_waveform
    %
    %   

    properties (Hidden)
        id_props = {'parent','trace','set'}
    end

    properties
        name
        lff_cutoff
        hff_cutoff
        notch_cutoff
        
        color
        stim_intensity
        trigger_delay

        %{
%Others we could expose - not sure of defaults
  is_captured: -1
            is_for_review: -1
          is_from_history: -1
               is_grabbed: -1
        %}

        is_rejected_data
        
        parent
        trace
        set
        data
        

        %Note, the data is populated afterwards by the main object
        %after we have linked the trace object
    end

    methods
        function obj = triggered_waveform(p_main,p,logger)
            obj = obj@epworks.objects.result_object(p,logger);
            obj.name = p.data.trace_obj.name;
            obj.lff_cutoff = p.data.lff_cutoff;
            obj.hff_cutoff = p.data.hff_cutoff;
            obj.notch_cutoff = p.data.notch_cutoff;
            obj.color = p.data.color;
            obj.stim_intensity = p.data.saved_stim_intensity;
            obj.trigger_delay = p.data.trigger_delay;

            obj.is_rejected_data = p.data.is_rejected_data;

            obj.parent = p.parent.id;
            obj.trace = p.data.trace_obj.id;
            obj.set = p.data.set_obj.id;
        end
    end
end