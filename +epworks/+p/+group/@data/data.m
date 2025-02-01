classdef data
    %
    %   Class:
    %   epworks.p.eeg_waveform.data

    properties
        s

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
            obj.s = s;
            n_children = length(s.child_indices);
            for i = 1:n_children
                index = s.child_indices(i);
                r.processed(index) = true;
                s2 = r.getStruct(index);
                switch s2.name
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
                        obj.baseline_set_id = s2.raw_data;
                    case 'CaptureEnable'
                        obj.capture_enable = double(typecast(s2.raw_data,'uint32'));
                    case 'CaptureThreshold'
                        obj.capture_threshold = typecast(s2.raw_data,'double');
                    case 'DisplayMode'
                        obj.display_mode = s2.raw_data;
                    case 'GroupId'
                        obj.group_id = s2.raw_data;
                    case 'IsEegGroup'
                        obj.is_eeg_group = double(typecast(s2.raw_data,'uint32'));
                    case 'Name'
                        obj.name = s2.data_value;
                    case 'PreviewSetId'
                        obj.preview_set_id = s2.raw_data;
                    case 'RawSweepSetId'
                        obj.raw_sweep_set_id = s2.raw_data;
                    case 'RollingWindow'
                        obj.rolling_window = double(typecast(s2.raw_data,'uint32'));
                    case 'SignalType'
                        obj.signal_type = double(typecast(s2.raw_data,'uint32'));
                    case 'State'
                        obj.state = double(typecast(s2.raw_data,'uint32'));
                    case 'SweepsPerAvg'
                        obj.sweeps_per_avg = double(typecast(s2.raw_data,'uint32'));
                    case 'TestObjId'
                        obj.test_obj_id = s2.raw_data;
                    case 'TriggerDelay'
                        obj.trigger_delay = typecast(s2.raw_data,'double');
                    case 'TriggerSource'
                        obj.trigger_source = s2.raw_data;
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end