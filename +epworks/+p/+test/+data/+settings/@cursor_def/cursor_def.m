classdef cursor_def
    %
    %   Class:
    %   epworks.p.test.data.settings.cursor_calc

    properties
        s

        display_name
        id
        is_marker
        latency_from
        latency_to
        name
        placement
        style
        trace_id
        use_type
        visible_placement_only
    end

    methods (Static)
        function objs = initialize(s,r)
            %
            %   objs = epworks.p.test.data.settings.cursor_def.initialize(s,r)

            n_children = length(s.child_indices);
            objs = cell(1,n_children);
            for i = 1:n_children
                index = s.child_indices(i);
                r.processed(index) = true;
                s2 = r.getStruct(index);
                obj = epworks.p.test.data.settings.cursor_def(s2,r);
                objs{i} = obj;
            end
            objs = [objs{:}];
        end
    end

    methods
        function obj = cursor_def(s,r)
            obj.s = s;
            n_children = length(s.child_indices);
            for i = 1:n_children
                index = s.child_indices(i);
                r.processed(index) = true;
                s2 = r.getStruct(index);

                switch s2.name
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

                    case 'DisplayName'
                    case 'GroupDef'
                    case 'ID'
                    case 'IsMarker'
                    case 'LatencyFrom'
                    case 'LatencyTo'
                    case 'Name'
                    case 'Placement'
                    case 'Style'
                    case 'TraceID'
                    case 'UseType'
                    case 'VisiblePlacementOnly'

                    otherwise
                        keyboard
                end
            end
            
        end
    end
end