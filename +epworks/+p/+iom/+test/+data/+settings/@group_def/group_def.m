classdef group_def < epworks.p.parse_object
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

            a = s.array;
            n_children = length(a);
            objs = cell(1,n_children);
            for i = 1:n_children
                s2 = a{i};
                obj = epworks.p.iom.test.data.settings.group_def(s2,r);
                objs{i} = obj;
            end
            objs = [objs{:}];
        end
    end

    methods
        function obj = group_def(s,r)
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

                    case 'CaptureChime'
                        obj.capture_chime = value;
                    case 'CaptureEnable'
                        obj.capture_enable = value;
                    case 'CaptureThreshold'
                        obj.capture_threshold = value;
                    case 'CollectMaxData'
                        obj.collect_max_data = value;
                    case 'DesiredUpdateInterval'
                        obj.desired_update_interval = value;
                    case 'DiscreteReadings'
                        obj.discrete_readings = value;
                    case 'DisplayMode'
                        obj.display_mode = value;
                    case 'EMGCableMode'
                        obj.emg_cable_mode = value;
                    case 'FWaveFilter'
                        obj.fwave_filter = value;
                    case 'ForcedDecimation'
                        obj.forced_decimation = value;
                    case 'ID'
                        obj.id = value;
                        r.logID(obj,obj.id);
                    case 'IsEegGroup'
                        obj.is_eeg_group = value;
                    case 'LimitedHBDecimation'
                        obj.limited_hb_decimation = value;
                    case 'Location'
                        obj.location = value;
                    case 'MaacsGroupId'
                        obj.maacs_group_id = value;
                    case 'Name'
                        obj.name = value;
                    case 'NumDivisionsToCollect'
                        obj.num_divisions_to_collect = value;
                    case 'PreTriggerDCOffset'
                        obj.pre_trigger_dc_offset = value;
                    case 'PreTriggerTriggerDelay'
                        obj.pre_trigger_trigger_delay = value;
                    case 'RollingWindow'
                        obj.rolling_window = value;
                    case 'ShowLiveTriggered'
                        obj.show_live_triggered = value;
                    case 'SignalType'
                        obj.signal_type = value;
                    case 'SpecialType'
                        obj.special_type = value;
                    case 'StartOnTestActivation'
                        obj.start_on_test_activation = value;
                    case 'SweepsPerAvg'
                        obj.sweeps_per_avg = value;
                    case 'TimelineID'
                        obj.timeline_id = value;
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