classdef dsa_spectral_eeg_view < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.iom.test.data.settings.element_layouts.elements.dsa_spectral_eeg_view

    properties
        friendly_name
        view_type
        min_position
        position
        suppress_visibility
        window_title_prefix
        auto_scale_power_max
        background_color
        display_voltage
        duration_per_screen
        foreground_color
        frequency_max
        grid_height
        grid_width
        palette_id
        power_max
        spectral_edge_color
        spectral_edge_flag
        spectral_edge_width
    end

    methods
        function obj = dsa_spectral_eeg_view(s,r)
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'FriendlyName' 
                        obj.friendly_name = value;
                    case 'ViewType'          
                        obj.view_type = value;
                    case 'MinPosition'       
                        obj.min_position = epworks.p.iom.test.data.settings.element_layouts.elements.view_min_position(value,r);
                    case 'Position'    
                        obj.position = epworks.p.iom.test.data.settings.element_layouts.elements.view_position(value,r);
                    case 'SuppressVisibility'
                        obj.suppress_visibility = value;
                    case 'WindowTitlePrefix' 
                        obj.window_title_prefix = value;
                    case 'AutoScalePowerMax' 
                        obj.auto_scale_power_max = value;
                    case 'BackgroundColor'   
                        obj.background_color = epworks.utils.getColor(value);
                    case 'DisplayVoltage'    
                        obj.display_voltage = value;
                    case 'DurationPerScreen' 
                        obj.duration_per_screen = value;
                    case 'ForegroundColor'   
                        obj.foreground_color = epworks.utils.getColor(value);
                    case 'FrequencyMax'   
                        obj.frequency_max = value;
                    case 'GridHeight'        
                        obj.grid_height = value;
                    case 'GridWidth'         
                        obj.grid_width = value;
                    case 'PaletteID'         
                        obj.palette_id = value;
                    case 'PowerMax'          
                        obj.power_max = value;
                    case 'SpectralEdgeColour'
                        obj.spectral_edge_color = value;
                    case 'SpectralEdgeFlag'  
                        obj.spectral_edge_flag = value;
                    case 'SpectralEdgeWidth' 
                        obj.spectral_edge_width = value;
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end