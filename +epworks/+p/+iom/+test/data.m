classdef data < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.eeg_waveform.data

    properties
        s

        baseline_set_id
        capture_enable

        creation_time
        settings
        simulation_mode
        state
        %0 - active
        %1 - inactive
        
        stimbox_connected
        test_set_obj_count
        version_info
    end

    methods
        function obj = data(s,r)
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


                    case 'CreationTime'
                        obj.creation_time = epworks.utils.processType1time(value);
                    case 'Settings'
                        obj.settings = epworks.p.iom.test.data.settings(value,r);
                    case 'SimulationMode'
                        obj.simulation_mode = value;
                    case 'State'
                        obj.state = value;
                    case 'StimboxConnected'
                        obj.stimbox_connected = value;
                    case 'TestSetObjCount'
                        obj.test_set_obj_count = value;
                    case 'VersionInfo'
                        obj.version_info = epworks.p.iom.test.version_info(value,r);
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end