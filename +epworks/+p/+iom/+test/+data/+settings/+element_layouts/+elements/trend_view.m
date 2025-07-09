classdef trend_view < epworks.p.parse_object
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
        active_trendset
        cutoff_on
        final_time
        initial_time
        lock_to_live
        manualtop_cutoff
        top_cutoff_on
        trend_compact_gaps
        trend_time_scale
    end

    methods
        function obj = trend_view(s,r)
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
                    case 'ActiveTrendSet'
                        obj.active_trendset = value;
                    case 'CutoffON'
                        obj.cutoff_on = value;
                    case 'FinalTime'
                        obj.final_time = value;
                    case 'InitialTime'
                        obj.initial_time = value;
                    case 'LockToLive'
                        obj.lock_to_live = value;
                    case 'ManualTopCutoff'
                        obj.manualtop_cutoff = value;
                    case 'TopCutoffON'
                        obj.top_cutoff_on = value;
                    case 'TrendCompactGaps'
                        obj.trend_compact_gaps = value;
                    case 'TrendTimeScale'
                        obj.trend_time_scale = value;
                    otherwise
                        safe_name = epworks.utils.getSafeVariableName(cur_name);
                        obj.unhandled_props.(safe_name) = value;
                end
            end

            r.logUnhandledProps(obj);
            
        end
    end
end