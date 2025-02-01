classdef group_def
    %
    %   Class:
    %   epworks.p.test.data.settings.group_def

    properties
        s
        capture_chime
        capture_enable
        capture_threshold
        collect_max_data
        desired_update_interval
        discrete_readings
        display_mode
        emg_cable_mode
        fwave_filter
        forced_decimation
        id
        is_eeg_group
        limited_hb_decimation
        location
        maacs_group_id
        name
        num_divisions_to_collect
        pre_trigger_dc_offset
        pre_trigger_trigger_delay
        rolling_window
        show_live_triggered
        signal_type
        special_type
        start_on_test_activation
        sweeps_per_avg
        timeline_id
        trigger_delay
        trigger_source
    end

    methods (Static)
        function objs = initialize(s,r)
            %
            %   objs = epworks.p.test.data.settings.group_def.initialize(s,r)

            n_children = length(s.child_indices);
            objs = cell(1,n_children);
            for i = 1:n_children
                index = s.child_indices(i);
                r.processed(index) = true;
                s2 = r.getStruct(index);
                obj = epworks.p.test.data.settings.group_def(s2,r);
                objs{i} = obj;
            end
            objs = [objs{:}];
        end
    end

    methods
        function obj = group_def(s,r)
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

                    case 'CaptureChime'
                    case 'CaptureEnable'
                    case 'CaptureThreshold'
                    case 'CollectMaxData'
                    case 'DesiredUpdateInterval'
                    case 'DiscreteReadings'
                    case 'DisplayMode'
                    case 'EMGCableMode'
                    case 'FWaveFilter'
                    case 'ForcedDecimation'
                    case 'ID'
                    case 'IsEegGroup'
                    case 'LimitedHBDecimation'
                    case 'Location'
                    case 'MaacsGroupId'
                    case 'Name'
                    case 'NumDivisionsToCollect'
                    case 'PreTriggerDCOffset'
                    case 'PreTriggerTriggerDelay'
                    case 'RollingWindow'
                    case 'ShowLiveTriggered'
                    case 'SignalType'
                    case 'SpecialType'
                    case 'StartOnTestActivation'
                    case 'SweepsPerAvg'
                    case 'TimelineID'
                    case 'TriggerDelay'
                    case 'TriggerSource'

                    otherwise
                        keyboard
                end
            end

        end
    end
end