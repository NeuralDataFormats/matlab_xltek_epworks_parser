classdef cursor_def < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.iom.test.data.settings.cursor_calc

    properties (Hidden)
        id_props = {'trace_id'}
    end

    properties
        display_name
        group_def
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
            %   objs = epworks.p.iom.test.data.settings.cursor_def.initialize(s,r)

            a = s.array;
            n_children = length(a);
            objs = cell(1,n_children);
            for i = 1:n_children
                s2 = a{i};
                obj = epworks.p.iom.test.data.settings.cursor_def(s2,r);
                objs{i} = obj;
            end
            objs = [objs{:}];
        end
    end

    methods
        function obj = cursor_def(s,r)
            r.logObject(obj);
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

                    case 'DisplayName'
                        obj.display_name = value;
                    case 'GroupDef'
                        obj.group_def = value;
                    case 'ID'
                        obj.id = value;
                        r.logID(obj,value);
                    case 'IsMarker'
                        obj.is_marker = value;
                    case 'LatencyFrom'
                        obj.latency_from = value;
                    case 'LatencyTo'
                        obj.latency_to = value;
                    case 'Name'
                        obj.name = value;
                    case 'Placement'
                        obj.placement = value;
                    case 'Style'
                        obj.style = value;
                    case 'TraceID'
                        obj.trace_id = value;
                    case 'UseType'
                        obj.use_type = value;
                    case 'VisiblePlacementOnly'
                        obj.visible_placement_only = value;
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end