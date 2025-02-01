classdef note_log_view
    %
    %   Class:
    %   epworks.p.test.data.settings.element_layouts.elements.waveform_view

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
        function obj = note_log_view(s,r)
            obj.s = s;
            n_children = length(s.child_indices);
            for i = 1:n_children
                index = s.child_indices(i);
                r.processed(index) = true;
                s2 = r.getStruct(index);
                I = find(s2.name == '}',1,'last');
                name_use = s2.name(I+1:end);
                reg_tag = s2.name(2:I);
                obj.reg_tag = reg_tag;

                switch name_use
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
                        obj.min_position = epworks.p.test.data.settings.element_layouts.elements.view_min_position(s2,r);
                    case 'Position'
                        obj.position = epworks.p.test.data.settings.element_layouts.elements.view_position(s2,r);
                    case 'SuppressVisibility'
                    case 'WindowTitlePrefix'
                    case 'Columns!Count'
                    case 'Columns[0]'
                        obj.columns0 = epworks.p.test.data.settings.element_layouts.elements.columns(s2,r);
                    case 'Columns[1]'
                        obj.columns1 = epworks.p.test.data.settings.element_layouts.elements.columns(s2,r);
                    case 'Columns[2]'
                        obj.columns2 = epworks.p.test.data.settings.element_layouts.elements.columns(s2,r);
                    case 'Columns[3]'
                        obj.columns3 = epworks.p.test.data.settings.element_layouts.elements.columns(s2,r);
                    case 'SortAscending'
                    case 'SortColumn'

                    otherwise
                        keyboard
                end
            end
            
        end
    end
end