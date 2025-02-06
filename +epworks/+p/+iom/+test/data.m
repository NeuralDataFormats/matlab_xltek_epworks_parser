classdef data < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.iom.test.data
    
    properties
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
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
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