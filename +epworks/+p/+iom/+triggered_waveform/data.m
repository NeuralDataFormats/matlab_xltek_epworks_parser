classdef data < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.triggered_waveform.data
    %
    %   See Also
    %   --------
    %   epworks.p.iom.triggered_waveform
    %   
    %   

    properties (Hidden)
        id_props = {'set_obj','trace_obj','clone'}
    end

    properties
        applied_hw_filter_hff
        applied_hw_filter_lff
        audio_volume
        baseline
        clone
        color
        explicit_save
        hff_cutoff
        iom_local_object
        is_alarmed_wave = -1
        is_captured = -1
        is_for_review = -1
        is_from_history = -1
        is_grabbed = -1
        is_rejected_data = false
        left_display_gain
        lff_cutoff
        me_clone
        notch_cutoff
        num_notes
        original_decim
        original_samp_freq
        range
        raw_sweep_number
        resolution
        right_display_gain
        samp_freq
        saved_stim_intensity = NaN
        sequence_number
        set_obj
        smooth_sel
        source_data
        timebase
        timestamp
        timestamp_part2
        trace_obj
        trigger_delay
        ui_settings
        visible
        visibility
        was_baseline
    end

    methods
        function obj = data(s,r)
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'AppliedHWFilterHFF'
                        obj.applied_hw_filter_hff = value;
                    case 'AppliedHWFilterLFF'
                        obj.applied_hw_filter_lff = value;
                    case 'AudioVolume'       
                        obj.audio_volume = value;
                    case 'Baseline'
                        obj.baseline = value;
                    case 'Clone'
                        obj.clone = value;
                    case 'Color'             
                        obj.color = epworks.utils.getColor(value);
                    case 'ExplicitSave'
                        obj.explicit_save = value;
                    case 'HffCutoff'      
                        obj.hff_cutoff = value;
                    case 'IOMLocalObject'
                        obj.iom_local_object = value;
                    case 'IsAlarmedWave'     
                        obj.is_alarmed_wave = value;
                    case 'IsCaptured'
                        obj.is_captured = value;
                    case 'IsForReview'
                        obj.is_for_review = value;
                    case 'IsFromHistory'
                        obj.is_from_history = value;
                    case 'IsGrabbed'
                        obj.is_grabbed = value;
                    case 'IsRejectedData'
                        obj.is_rejected_data = value;
                    case 'LeftDisplayGain'   
                        obj.left_display_gain = value;
                    case 'LffCutoff'         
                        obj.lff_cutoff = value;
                    case 'MeClone'
                        obj.me_clone = value;
                    case 'NotchCutoff'       
                        obj.notch_cutoff = value;
                    case 'NumNotes'
                        obj.num_notes = value;
                    case 'OriginalDecim'     
                        obj.original_decim = value;
                    case 'OriginalSampFreq'  
                        obj.original_samp_freq = value;
                    case 'Range'             
                        obj.range = value;
                    case 'RawSweepNum'
                        obj.raw_sweep_number = value;
                    case 'Resolution'      
                        obj.resolution = value;
                    case 'RightDisplayGain'  
                        obj.right_display_gain = value;
                    case 'SampFreq'          
                        obj.samp_freq = value;
                    case 'SavedStimIntensity'
                        obj.saved_stim_intensity = value;
                    case 'SequenceNumber'    
                        obj.sequence_number = value;
                    case 'SetObjId'          
                        obj.set_obj = value;
                    case 'SmoothSel'
                        obj.smooth_sel = value;
                    case 'SourceData'       
                        obj.source_data = value;
                    case 'Timebase'          
                        obj.timebase = value;
                    case 'Timestamp'         
                        obj.timestamp = epworks.utils.processType3time(value(1:8));
                        if length(value) > 8
                            obj.timestamp_part2 = double(typecast(value(9:16),'int32'));
                        end
                    case 'TraceObjId'        
                        obj.trace_obj = value;
                    case 'TriggerDelay'      
                        obj.trigger_delay = value;
                    case 'UISettings'        
                        obj.ui_settings = value;
                    case 'Visible'           
                        obj.visible = value;
                    case 'Visibility'
                        obj.visibility = value;
                    case 'WasBaseline'
                        obj.was_baseline = value;
                    otherwise
                        safe_name = epworks.utils.getSafeVariableName(cur_name);
                        obj.unhandled_props.(safe_name) = value;
                end
            end

            r.logUnhandledProps(obj);
            
        end
    end
end