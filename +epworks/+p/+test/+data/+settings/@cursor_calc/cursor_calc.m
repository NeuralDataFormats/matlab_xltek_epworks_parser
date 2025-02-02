classdef cursor_calc < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.test.data.settings.cursor_calc

    properties
        s
        alarm_in_prcnt
        alarm_level
        area_type
        display_type
        from_def
        id
        is_marker
        name
        neg_alarm_level
        to_def
        value_type
    end

    methods (Static)
        function objs = initialize(s,r)
            %
            %   objs = epworks.p.test.data.settings.cursor_calc.initialize(s,r)

            n_children = length(s.child_indices);
            objs = cell(1,n_children);
            for i = 1:n_children
                index = s.child_indices(i);
                r.processed(index) = true;
                s2 = r.getStruct(index);
                obj = epworks.p.test.data.settings.cursor_calc(s2,r);
                objs{i} = obj;
            end
            objs = [objs{:}];
        end
    end

    methods
        function obj = cursor_calc(s,r)
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

                    case 'AlarmInPrcnt'
                    case 'AlarmLevel'
                    case 'AreaType'
                    case 'DisplayType'
                    case 'FromDef'
                    case 'ID'
                        obj.id = s2.raw_data;
                        r.logID(obj,obj.id);
                    case 'IsMarker'
                    case 'Name'
                        obj.name = s2.data_value;
                    case 'NegAlarmLevel'
                    case 'ToDef'
                    case 'ValueType'

                    otherwise
                        keyboard
                end
            end
            
        end
    end
end