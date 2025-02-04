classdef history_sets < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.iom.test.data.settings.history_sets

    properties (Hidden)
        id_props = {'history_trace_0','history_trace_1','history_trace_2','history_trace_3'}
    end

    properties
        history_trace_0
        history_trace_1
        history_trace_2
        history_trace_3
        id
        name
    end

    methods (Static)
        function objs = initialize(s,r)
            %
            %   objs = epworks.p.test.data.settings.history_sets.initialize(s,r)

            a = s.array;
            n_children = length(a);
            objs = cell(1,n_children);
            for i = 1:n_children
                s2 = a{i};
                obj = epworks.p.iom.test.data.settings.history_sets(s2,r);
                objs{i} = obj;
            end
            objs = [objs{:}];
        end
    end

    methods
        function obj = history_sets(s,r)
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'HistoryTrace0'
                        obj.history_trace_0 = value;
                    case 'HistoryTrace1'
                        obj.history_trace_1 = value;
                    case 'HistoryTrace2'
                        obj.history_trace_2 = value;
                    case 'HistoryTrace3'
                        obj.history_trace_3 = value;
                    case 'ID'
                        obj.id = value;
                    case 'Name'
                        obj.name = value;
                    otherwise
                        keyboard
                end
            end

        end
    end
end