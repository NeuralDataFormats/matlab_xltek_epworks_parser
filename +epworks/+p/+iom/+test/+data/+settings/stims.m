classdef stims < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.test.data.settings.stims
    %
    %   Note, I think there are different types and we've merged
    %   the properties for all of them. Eventually we should clean this up
    %   ...
    %
    %
    %

    properties        
        aud_stim_output
        audio_onset
        audio_ramp
        color
        const_voltage
        contra_mode  
        delay
        device_type
        divisions
        id
        init_intensity
        intensity
        inter_pulse_duration
        ipsi_mode
        is_active_high
        is_output
        location
        mask_intensity
        mode
        nerve
        number_of_phases
        on_timeline
        phys_name
        phys_num
        polarity
        priming_gap
        priming_pulses
        pulse_duration
        pulse_intensity
        pulse_intensity_2
        pulses_per_train
        range
        rate
        relay_port
        relay_switch_delay
        sw_stim_id
        train_rate
        trigger_to_stim_lat
        type
        visual_field
        visual_flash
        visual_stim_output
        visual_trigger
    end

    methods (Static)
        function objs = initialize(s,r)
            %
            %   objs = epworks.p.test.data.settings.cursor_calc.initialize(s,r)

            a = s.array;
            n_children = length(a);
            objs = cell(1,n_children);
            for i = 1:n_children
                s2 = a{i};
                obj = epworks.p.iom.test.data.settings.stims(s2,r);
                objs{i} = obj;
            end
            objs = [objs{:}];
        end
    end

    methods
        function obj = stims(s,r)
            %
            %   r : 
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'x2ndPulseIntensity'
                        obj.pulse_intensity_2 = value;
                    case 'AudStimOutput'
                        obj.aud_stim_output = value;
                    case 'AudioOnset'
                        obj.audio_onset = value;
                    case 'AudioRamp'
                        obj.audio_ramp = value;
                    case 'Colour'
                        obj.color = epworks.utils.getColor(value);
                    case 'ContraMode'
                        obj.contra_mode = value;
                    case 'ConstVoltage'
                        obj.const_voltage = value;
                    case 'Delay'
                        obj.delay = value;
                    case 'DeviceType'
                        obj.device_type = value;
                    case 'Divisions'
                        obj.divisions = value;
                    case 'ID'
                        obj.id = value;
                        r.logID(obj,obj.id);
                    case 'InitIntensity'
                        obj.init_intensity = value;
                    case 'Intensity'
                        obj.intensity = value;
                    case 'InterPulseDuration'
                        obj.inter_pulse_duration = value;
                    case 'IpsiMode'
                        obj.ipsi_mode = value;
                    case 'IsActiveHigh'
                        obj.is_active_high = value;
                    case 'IsOutput'
                        obj.is_output = value;
                    case 'Location'
                        obj.location = value;
                    case 'MaskIntensity'
                        obj.mask_intensity = value;
                    case 'Mode'
                        obj.mode = value;
                    case 'Nerve'
                        obj.nerve = value;
                    case 'NumberOfPhases'
                        obj.number_of_phases = value;
                    case 'OnTimeline'
                        obj.on_timeline = value;
                    case 'PhysName'
                        obj.phys_name = value;
                    case 'PhysNum'
                        obj.phys_num = value;
                    case 'Polarity'
                        obj.polarity = value;
                    case 'PrimingGap'
                        obj.priming_gap = value;
                    case 'PrimingPulses'
                        obj.priming_pulses = value;
                    case 'PulseDuration'
                        obj.pulse_duration = value;
                    case 'PulseIntensity'
                        obj.pulse_intensity = value;
                    case 'PulsesPerTrain'
                        obj.pulses_per_train = value;
                    case 'Range'
                        obj.range = value;
                    case 'Rate'
                        obj.rate = value;
                    case 'RelayPort'
                        obj.relay_port = value;
                    case 'RelaySwitchDelay'
                        obj.relay_switch_delay = value;
                    case 'SwStimId'
                        obj.sw_stim_id = value;
                    case 'TrainRate'
                        obj.train_rate = value;
                    case 'TriggerToStimLat'
                        obj.trigger_to_stim_lat = value;
                    case 'Type'
                        obj.type = value;
                    case 'VisualField'
                        obj.visual_field = value;
                    case 'VisualFlash'
                        obj.visual_flash = value;
                    case 'VisualStimOutput'
                        obj.visual_stim_output = value;
                    case 'VisualTrigger'
                        obj.visual_trigger = value;
                    otherwise
                        safe_name = epworks.utils.getSafeVariableName(cur_name);
                        obj.unhandled_props.(safe_name) = value;
                end
            end

            r.logUnhandledProps(obj);
            
        end
    end
end