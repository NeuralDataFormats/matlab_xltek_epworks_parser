classdef note_log_view
    %
    %   Class:
    %   epworks.p.test.data.settings.element_layouts.elements.waveform_view

    properties
        friendly_name
        view_type
        min_position
        position
        suppress_visibility
        window_title_prefix
        columns_count
        columns_0
        columns_1
        columns_2
        columns_3
        sort_ascending
        sort_column
    end

    methods
        function obj = note_log_view(s,r)
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'FriendlyName'
                    case 'ViewType'
                    case 'MinPosition'
                        obj.min_position = epworks.p.iom.test.data.settings.element_layouts.elements.view_min_position(value,r);
                    case 'Position'
                        obj.position = epworks.p.iom.test.data.settings.element_layouts.elements.view_position(value,r);
                    case 'SuppressVisibility'
                    case 'WindowTitlePrefix'
                    case 'Columns_Count'
                    case 'Columns_0_'
                        obj.columns_0 = epworks.p.iom.test.data.settings.element_layouts.elements.columns(value,r);
                    case 'Columns_1_'
                        obj.columns_1 = epworks.p.iom.test.data.settings.element_layouts.elements.columns(value,r);
                    case 'Columns_2_'
                        obj.columns_2 = epworks.p.iom.test.data.settings.element_layouts.elements.columns(value,r);
                    case 'Columns_3_'
                        obj.columns_3 = epworks.p.iom.test.data.settings.element_layouts.elements.columns(value,r);
                    case 'SortAscending'
                    case 'SortColumn'

                    otherwise
                        keyboard
                end
            end
            
        end
    end
end