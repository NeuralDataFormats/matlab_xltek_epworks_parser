classdef eeg_waveform_view < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.iom.test.data.settings.element_layouts.elements.eeg_waveform_view

    properties
        guid
        is_default_size_applied
        timebase
        view_type
        min_position
        position
        supress_visibility
        window_title_prefix
    end

    methods
        function obj = eeg_waveform_view(s,r)
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'IsDefaultSizeApplied'
                        obj.is_default_size_applied = value;
                    case 'Timebase'
                        obj.timebase = value;
                    case 'ViewType'
                        obj.view_type = value;
                    case 'MinPosition'
                        obj.min_position = epworks.p.iom.test.data.settings.element_layouts.elements.view_min_position(value,r);
                    case 'Position'
                        obj.position = epworks.p.iom.test.data.settings.element_layouts.elements.view_position(value,r);
                    case 'SuppressVisibility'
                        obj.supress_visibility = value;
                    case 'WindowTitlePrefix'
                        obj.window_title_prefix = value;
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end