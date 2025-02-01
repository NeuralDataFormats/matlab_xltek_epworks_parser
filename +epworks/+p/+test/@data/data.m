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
        stimbox_connected
        test_set_obj_count
        version_info
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


                    case 'CreationTime'
                        obj.creation_time = epworks.utils.processType1time(s2.raw_data);
                    case 'Settings'
                        obj.settings = epworks.p.test.data.settings(s2,r);
                    case 'SimulationMode'
                        obj.simulation_mode = double(typecast(s2.raw_data,'uint32'));
                    case 'State'
                        obj.state = double(typecast(s2.raw_data,'uint32'));
                    case 'StimboxConnected'
                        obj.stimbox_connected = double(typecast(s2.raw_data,'uint32'));
                    case 'TestSetObjCount'
                        obj.test_set_obj_count = double(typecast(s2.raw_data,'uint32'));
                    case 'VersionInfo'
                        obj.version_info = epworks.p.test.version_info(s2,r);
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end