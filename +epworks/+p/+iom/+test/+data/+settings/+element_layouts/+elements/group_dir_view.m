classdef group_dir_view < epworks.p.parse_object
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
    end

    methods
        function obj = group_dir_view(s,r)
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

                    otherwise
                        keyboard
                end
            end

        end
    end
end