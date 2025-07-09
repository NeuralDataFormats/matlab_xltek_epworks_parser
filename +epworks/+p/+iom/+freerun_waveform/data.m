classdef data < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.freerun_waveform.data
    %
    %   See Also
    %   --------
    %   epworks.p.set
    %   
    %   

    properties (Hidden)
        id_props = {'set_obj','trace_obj'}
    end

    properties
        audio_volume
        color
        hff_cutoff
        is_alarmed_wave
        left_display_gain
        lff_cutoff
        notch_cutoff
        original_decim
        original_samp_freq
        range
        resolution
        right_display_gain
        samp_freq
        saved_stim_intensity
        sequence_number
        set_obj
        timebase
        timestamp
        timestamp_part2
        trace_obj
        trigger_delay
        ui_settings
        visibile
        visibility
        sourcedata
        explicitsave
    end

    methods
        function obj = data(s,r)

            arguments
                s struct
                r epworks.parse.iom.logger
            end
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'AudioVolume'
                        obj.audio_volume = value;
                    case 'Color'           
                        obj.color = epworks.utils.getColor(value);
                    case 'HffCutoff'       
                        obj.hff_cutoff = value;
                    case 'IsAlarmedWave'   
                        obj.is_alarmed_wave = value;
                    case 'LeftDisplayGain' 
                        obj.left_display_gain = value;
                    case 'LffCutoff'       
                        obj.lff_cutoff = value;
                    case 'NotchCutoff'     
                        obj.notch_cutoff = value;
                    case 'OriginalDecim'   
                        obj.original_decim = value;
                    case 'OriginalSampFreq'
                        obj.original_samp_freq = value;
                    case 'Range'           
                        obj.range = value;
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
                    case 'Timebase'        
                        obj.timebase = value;
                    case 'Timestamp'       
                        obj.timestamp = epworks.utils.processType3time(value(1:8));
                        %This may have been a parse error and this may no
                        %longer ever get called
                        if length(value) > 8
                            fprintf(2,'epworks.p.freerun_waveform.data, This was actually called\n')
                            obj.timestamp_part2 = double(typecast(value(9:16),'int32'));
                        end
                    case 'TraceObjId'     
                        obj.trace_obj = value;
                    case 'TriggerDelay'    
                        obj.trigger_delay = value;
                    case 'UISettings'      
                        obj.ui_settings = value;
                    case 'Visible'         
                        obj.visibile = value;
                    case 'Visibility'
                        obj.visibility = value;
                    case 'SourceData'
                        obj.sourcedata = value;
                    case 'ExplicitSave'
                        obj.explicitsave = value;
                    otherwise
                        safe_name = epworks.utils.getSafeVariableName(cur_name);
                        obj.unhandled_props.(safe_name) = value;
                end
            end

            r.logUnhandledProps(obj);
            
        end
    end
end