classdef test_dir_view < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.test.data.settings.element_layouts.elements.test_dir_view

    properties
        guid
        friendly_name
        view_type
        min_position
        position
        suppress_visibility
        window_title_prefix
        columns_count
        columns0
        columns1
        columns2
        columns3
        sort_ascending
        sort_column
    end

    methods
        function obj = test_dir_view(s,r)
            obj.guid = s.guid;
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
                    case 'Columns_Count'
                        obj.columns_count = value;
                    case 'Columns_0_'
                        obj.columns0 = epworks.p.iom.test.data.settings.element_layouts.elements.columns(value,r);
                    case 'Columns_1_'
                        obj.columns1 = epworks.p.iom.test.data.settings.element_layouts.elements.columns(value,r);
                    case 'Columns_2_'
                        obj.columns2 = epworks.p.iom.test.data.settings.element_layouts.elements.columns(value,r);
                    case 'Columns_3_'
                        obj.columns3 = epworks.p.iom.test.data.settings.element_layouts.elements.columns(value,r);
                    case 'SortAscending'
                        obj.sort_ascending = value;
                    case 'SortColumn'
                        obj.sort_column = value;
                    otherwise
                        safe_name = epworks.utils.getSafeVariableName(cur_name);
                        obj.unhandled_props.(safe_name) = value;
                end
            end

            r.logUnhandledProps(obj);
            
        end
    end
end