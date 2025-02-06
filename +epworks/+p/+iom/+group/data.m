classdef data < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.eeg_waveform.data

    properties (Hidden)
        id_props = {'baseline_set_id','preview_set_id','raw_sweep_set_id','test_obj_id'}
    end

    properties
        name

        baseline_set_id
        capture_enable

        %Threshold for capture, not whether to capture
        capture_threshold
        display_mode
        group_id
        is_eeg_group
        
        preview_set_id
        raw_sweep_set_id
        rolling_window
        signal_type
        state
        sweeps_per_avg
        test_obj_id
        trigger_delay
        %type: ID
        trigger_source
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
                    %{
                    case 'AudioVolume'
                        obj.audio_volume = double(typecast(s2.raw_data,'uint32'));
                    case 'Color'
                        obj.color = double(s2.raw_data);
                    case 'HffCutoff'
                        obj.hff_cutoff = typecast(s2.raw_data,'double');
                    case 'IsAlarmedWave'
                        obj.is_alarmed_wave = double(typecast(s2.raw_data,'uint32'));
                    %}


                    case 'BaselineSetId'
                        obj.baseline_set_id = value;
                    case 'CaptureEnable'
                        obj.capture_enable = value;
                    case 'CaptureThreshold'
                        obj.capture_threshold = value;
                    case 'DisplayMode'
                        obj.display_mode = value;
                    case 'GroupId'
                        obj.group_id = value;
                    case 'IsEegGroup'
                        obj.is_eeg_group = value;
                    case 'Name'
                        obj.name = value;
                    case 'PreviewSetId'
                        obj.preview_set_id = value;
                    case 'RawSweepSetId'
                        obj.raw_sweep_set_id = value;
                    case 'RollingWindow'
                        obj.rolling_window = value;
                    case 'SignalType'
                        obj.signal_type = value;
                    case 'State'
                        obj.state = value;
                    case 'SweepsPerAvg'
                        obj.sweeps_per_avg = value;
                    case 'TestObjId'
                        obj.test_obj_id = value;
                    case 'TriggerDelay'
                        obj.trigger_delay = value;
                    case 'TriggerSource'
                        obj.trigger_source = value;
                    otherwise
                        keyboard
                end
            end
        end
    end
end