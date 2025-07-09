classdef history_view < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.test.data.settings.element_layouts.elements.waveform_view

    properties
        guid
        friendly_name
        view_type
        min_position
        position
        suppress_visibility
        window_title_prefix
        absolute_latency_cursors_count
        active_history_set
        history_end_time_high
        history_end_time_low
        history_start_time_high
        history_start_time_low
        history_time_scale
        lock_to_live
        minutes
        show_cursors
    end

    methods
        function obj = history_view(s,r)
            r.logObject(obj);
            obj.guid = s.guid;
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
                    case 'AbsoluteLatencyCursors_Count'
                        obj.absolute_latency_cursors_count = value;
                    case 'ActiveHistorySet'
                        obj.active_history_set = value;
                    case 'HistoryEndTimeHigh'
                        obj.history_end_time_high = value;
                    case 'HistoryEndTimeLow'
                        obj.history_end_time_low = value;
                    case 'HistoryStartTimeHigh'
                        obj.history_start_time_high = value;
                    case 'HistoryStartTimeLow'
                        obj.history_start_time_low = value;
                    case 'HistoryTimeScale'
                        obj.history_time_scale = value;
                    case 'LockToLive'
                        obj.lock_to_live = value;
                    case 'Minutes'
                        obj.minutes = value;
                    case 'ShowCursors'
                        obj.show_cursors = value;
                    otherwise
                        safe_name = epworks.utils.getSafeVariableName(cur_name);
                        obj.unhandled_props.(safe_name) = value;
                end
            end

            r.logUnhandledProps(obj);
            
        end
    end
end