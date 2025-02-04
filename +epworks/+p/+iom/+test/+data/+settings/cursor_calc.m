classdef cursor_calc < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.iom.test.data.settings.cursor_calc

    properties
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

            a = s.array;
            n_children = length(a);
            objs = cell(1,n_children);
            for i = 1:n_children
                s2 = a{i};
                obj = epworks.p.iom.test.data.settings.cursor_calc(s2,r);
                objs{i} = obj;
            end
            objs = [objs{:}];
        end
    end

    methods
        function obj = cursor_calc(s,r)
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'AlarmInPrcnt'
                        obj.alarm_in_prcnt = value;
                    case 'AlarmLevel'
                        obj.alarm_level = value;
                    case 'AreaType'
                        obj.area_type = value;
                    case 'DisplayType'
                        obj.display_type = value;
                    case 'FromDef'
                        obj.from_def = value;
                    case 'ID'
                        obj.id = value;
                        r.logID(obj,obj.id);
                    case 'IsMarker'
                        obj.is_marker = value;
                    case 'Name'
                        obj.name = value;
                    case 'NegAlarmLevel'
                        obj.neg_alarm_level = value;
                    case 'ToDef'
                        obj.to_def = value;
                    case 'ValueType'
                        obj.value_type = value;
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end