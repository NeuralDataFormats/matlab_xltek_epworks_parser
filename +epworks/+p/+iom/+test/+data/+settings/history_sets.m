classdef history_sets < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.iom.test.data.settings.history_sets

    properties (Hidden)
        %Does a cell work?
        id_props = {'history_traces'}
    end

    properties
        % history_trace_0
        % history_trace_1
        % history_trace_2
        % history_trace_3
        history_traces
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

            temp = regexp(fn,'^HistoryTrace\d','once');
            n_traces = sum(~cellfun('isempty',temp))+1;
            traces = cell(1,n_traces);


            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    % case 'HistoryTrace0'
                    %     obj.history_trace_0 = value;
                    % case 'HistoryTrace1'
                    %     obj.history_trace_1 = value;
                    % case 'HistoryTrace2'
                    %     obj.history_trace_2 = value;
                    % case 'HistoryTrace3'
                    %     obj.history_trace_3 = value;
                    case 'ID'
                        obj.id = value;
                    case 'Name'
                        obj.name = value;
                    otherwise
                        cur_name = string(cur_name);
                        if startsWith(cur_name,'HistoryTrace')
                            temp = regexp(cur_name,'\d+','once','match');

                            %Note, they start at 0
                            index = str2double(temp) + 1;
                            traces{index} = value;
                        else
                            safe_name = epworks.utils.getSafeVariableName(cur_name);
                            obj.unhandled_props.(safe_name) = value;
                        end
                end
            end
            obj.history_traces = traces;
            r.logUnhandledProps(obj);

        end
    end
end