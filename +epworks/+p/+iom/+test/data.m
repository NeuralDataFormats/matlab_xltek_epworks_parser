classdef data < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.iom.test.data
    
    properties
        baseline_set_id
        capture_enable

        
        creation_time

        iom32_noise_spectrum_base_frequency
        %This is probably wrong and should be typecasted
        warn = 'These next two properties are probably interpreted wrong currently'
        iom32_noise_spectrum_bins
        %This is probably wrong
        iom32_noise_spectrum_number_of_bins
        iom32_stim_reset_required
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
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'CreationTime'
                        obj.creation_time = epworks.utils.processType1time(value);
                    case 'IOM32NoiseSpectrumBaseFrequency'
                        obj.iom32_noise_spectrum_base_frequency = value;
                    case 'IOM32NoiseSpectrumBins'
                        obj.iom32_noise_spectrum_bins = value;
                    case 'IOM32NoiseSpectrumNumberOfBins'
                        obj.iom32_noise_spectrum_number_of_bins = value;
                    case 'IOM32StimResetRequired'
                        obj.iom32_stim_reset_required = value;
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