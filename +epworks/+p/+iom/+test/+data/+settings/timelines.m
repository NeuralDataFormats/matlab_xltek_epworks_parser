classdef timelines < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.test.data.settings.timelines

    properties
        s
        id
        is_enabled
        is_paused = 0
        is_running = 0
        is_waiting = 0
        restart_delay
        start_waiting = NaT
        type
    end

    methods (Static)
        function objs = initialize(s,r)
            %
            %   objs = epworks.p.test.data.settings.timelines.initialize(s,r)

            a = s.array;
            n_children = length(a);
            objs = cell(1,n_children);
            for i = 1:n_children
                s2 = a{i};
                obj = epworks.p.iom.test.data.settings.timelines(s2,r);
                objs{i} = obj;
            end
            objs = [objs{:}];
        end
    end

    methods
        function obj = timelines(s,r)
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'ID'
                        obj.id = value;
                        r.logID(obj,obj.id);
                    case 'IsEnabled'
                        obj.is_enabled = value;
                    case 'IsPaused'
                        obj.is_paused = value;
                    case 'IsRunning'
                        obj.is_running = value;
                    case 'IsWaiting'
                        obj.is_waiting = value;
                    case 'RestartDelay'
                        obj.restart_delay = value;
                    case 'StartWaiting'
                        if ~isempty(value)
                            obj.start_waiting = epworks.utils.processType3time(value);
                        end
                    case 'Type'
                        obj.type = value;
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end