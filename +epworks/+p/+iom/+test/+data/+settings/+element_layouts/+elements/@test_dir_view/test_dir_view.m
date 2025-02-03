classdef test_dir_view
    %
    %   Class:
    %   epworks.p.test.data.settings.element_layouts.elements.test_dir_view

    properties
        s
        reg_tag
        %TODO
        min_position
        position
        columns0
        columns1
        columns2
        columns3
    end

    methods
        function obj = test_dir_view(s,r)
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    %{
                    case 'AudioVolume'
                        obj.audio_volume = double(typecast(s2.raw_data,'uint32'));
                    case 'Color'
                        obj.color = double(s2.raw_data);
                    case 'HffCutoff'
                        obj.hff_cutoff = typecast(s2.raw_data,'double');
                    case 'IsAlarmedWave'
                        obj.is_alarmed_wave = double(typecast(s2.raw_data,'uint32'));
                    %}
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
                        obj.columns0 = epworks.p.iom.test.data.settings.element_layouts.elements.columns(value,r);
                    case 'Columns_1_'
                        obj.columns1 = epworks.p.iom.test.data.settings.element_layouts.elements.columns(value,r);
                    case 'Columns_2_'
                        obj.columns2 = epworks.p.iom.test.data.settings.element_layouts.elements.columns(value,r);
                    case 'Columns_3_'
                        obj.columns3 = epworks.p.iom.test.data.settings.element_layouts.elements.columns(value,r);
                    case 'SortAscending'
                    case 'SortColumn'

                    otherwise
                        keyboard
                end
            end
            
        end
    end
end