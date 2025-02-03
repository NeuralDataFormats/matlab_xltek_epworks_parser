classdef data < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.eeg_waveform.data

    properties (Hidden)
        id_props = {'set_obj','trace_obj'}
    end

    properties
        s

        audio_volume
        color
        hff_cutoff
        is_alarmed_wave
        left_display_gain
        lff_cutoff
        notch_cutoff
        range
        resolution
        right_display_gain
        samp_freq
        sequence_number
        set_obj
        timebase
        timestamp
        trace_obj
        trigger_delay
        visible
    end

    methods
        function obj = data(s,r)
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
                    case 'Range'
                        obj.range = value;
                    case 'Resolution'
                        obj.resolution = value;
                    case 'RightDisplayGain'
                        obj.resolution = value;
                    case 'SampFreq'
                        obj.samp_freq = value;
                    case 'SequenceNumber'
                        obj.sequence_number = value;
                    case 'SetObjId'
                        obj.set_obj = value;
                    case 'Timebase'
                        obj.timebase = value;
                    case 'Timestamp'
                        obj.timestamp = epworks.utils.processType3time(value);
                    case 'TraceObjId'
                        obj.trace_obj = value;
                    case 'TriggerDelay'
                        obj.trigger_delay = value;
                    case 'Visible'
                        obj.visible = value;
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end