classdef stims
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
        s

        
        aud_stim_output
        audio_onset
        audio_ramp
        colour
        const_voltage
        contra_mode  
        delay
        device_type
        divisions
        id
        init_intensity
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
        pulses_per_train
        range
        rate
        relay_port
        relay_switch_delay
        second_pulse_intensity
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

            n_children = length(s.child_indices);
            objs = cell(1,n_children);
            for i = 1:n_children
                index = s.child_indices(i);
                r.processed(index) = true;
                s2 = r.getStruct(index);
                obj = epworks.p.test.data.settings.stims(s2,r);
                objs{i} = obj;
            end
            objs = [objs{:}];
        end
    end

    methods
        function obj = stims(s,r)
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

                    case '2ndPulseIntensity'
                    case 'AudStimOutput'
                    case 'AudioOnset'
                    case 'AudioRamp'
                    case 'Colour'
                    case 'ContraMode'
                    case 'ConstVoltage'
                    case 'Delay'
                    case 'DeviceType'
                    case 'Divisions'
                    case 'ID'
                    case 'InitIntensity'
                    case 'InterPulseDuration'
                    case 'IpsiMode'
                    case 'IsActiveHigh'
                    case 'IsOutput'
                    case 'Location'
                    case 'MaskIntensity'
                    case 'Mode'
                    case 'Nerve'
                    case 'NumberOfPhases'
                    case 'OnTimeline'
                    case 'PhysName'
                    case 'PhysNum'
                    case 'Polarity'
                    case 'PrimingGap'
                    case 'PrimingPulses'
                    case 'PulseDuration'
                    case 'PulseIntensity'
                    case 'PulsesPerTrain'
                    case 'Range'
                    case 'Rate'
                    case 'RelayPort'
                    case 'RelaySwitchDelay'
                    case 'SwStimId'
                    case 'TrainRate'
                    case 'TriggerToStimLat'
                    case 'Type'
                    case 'VisualField'
                    case 'VisualFlash'
                    case 'VisualStimOutput'
                    case 'VisualTrigger'
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end