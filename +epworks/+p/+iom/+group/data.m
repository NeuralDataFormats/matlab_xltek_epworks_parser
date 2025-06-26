classdef data < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.eeg_waveform.data

    properties (Hidden)
        id_props = {'baseline_set','preview_set','raw_sweep_set','test_obj','group','trigger_source'}
    end

    properties
        name

        baseline_set
        capture_enable

        %Threshold for capture, not whether to capture
        capture_threshold
        display_mode
        enable = -1
        group
        is_eeg_group = 0
        preview_set
        raw_sweep_set
        rolling_window
        signal_type = -1
        state = -1
        sweeps_per_avg = -1
        test_obj
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
                    case 'BaselineSetId'
                        obj.baseline_set = value;
                    case 'CaptureEnable'
                        obj.capture_enable = value;
                    case 'CaptureThreshold'
                        obj.capture_threshold = value;
                    case 'DisplayMode'
                        obj.display_mode = value;
                    case 'Enable'
                        obj.enable = value;
                    case 'GroupId'
                        obj.group = value;
                    case 'IsEegGroup'
                        obj.is_eeg_group = value;
                    case 'Name'
                        obj.name = value;
                    case 'PreviewSetId'
                        obj.preview_set = value;
                    case 'RawSweepSetId'
                        obj.raw_sweep_set = value;
                    case 'RollingWindow'
                        obj.rolling_window = value;
                    case 'SignalType'
                        obj.signal_type = value;
                    case 'State'
                        obj.state = value;
                    case 'SweepsPerAvg'
                        obj.sweeps_per_avg = value;
                    case 'TestObjId'
                        obj.test_obj = value;
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