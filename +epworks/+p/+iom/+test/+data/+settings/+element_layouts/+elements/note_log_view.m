classdef note_log_view < epworks.p.parse_object
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
        columns
        % columns_0
        % columns_1
        % columns_2
        % columns_3
        sort_ascending
        sort_column
    end

    methods
        function obj = note_log_view(s,r)
            r.logObject(obj);
            p = s.props;

            fn = fieldnames(p);
            temp = regexp(fn,'^Columns_\d','once');
            n_columns = sum(~cellfun('isempty',temp))+1;
            columns = cell(1,n_columns);

            
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
                    % % case 'Columns_0_'
                    % %     obj.columns_0 = epworks.p.iom.test.data.settings.element_layouts.elements.columns(value,r);
                    % % case 'Columns_1_'
                    % %     obj.columns_1 = epworks.p.iom.test.data.settings.element_layouts.elements.columns(value,r);
                    % % case 'Columns_2_'
                    % %     obj.columns_2 = epworks.p.iom.test.data.settings.element_layouts.elements.columns(value,r);
                    % % case 'Columns_3_'
                    % %     obj.columns_3 = epworks.p.iom.test.data.settings.element_layouts.elements.columns(value,r);
                    case 'SortAscending'
                        obj.sort_ascending = value;
                    case 'SortColumn'
                        obj.sort_column = value;
                    otherwise
                        if startsWith(cur_name,'Columns')
                            temp = regexp(cur_name,'\d+','once','match');
                            % if isempty(temp) || ismissing(temp)
                            %     %0 doesn't have a number
                            %     index = 1;
                            % else
                                %Note, they start at 0
                                index = str2double(temp) + 1;
                            % end
                            column = epworks.p.iom.test.data.settings.element_layouts.elements.columns(value,r);
                            columns{index} = column;
                        else
                            safe_name = epworks.utils.getSafeVariableName(cur_name);
                            obj.unhandled_props.(safe_name) = value;
                        end
                end
            end
            obj.columns = [columns{:}];

            r.logUnhandledProps(obj);
            
        end
    end
end