classdef history_sets < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.test.data.settings.history_sets

    properties (Hidden)
        id_props = {'history_trace_0','history_trace_1','history_trace_2','history_trace_3'}
    end

    properties
        s
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

            n_children = length(s.child_indices);
            objs = cell(1,n_children);
            for i = 1:n_children
                index = s.child_indices(i);
                r.processed(index) = true;
                s2 = r.getStruct(index);
                obj = epworks.p.test.data.settings.history_sets(s2,r);
                objs{i} = obj;
            end
            objs = [objs{:}];
        end
    end

    methods
        function obj = history_sets(s,r)
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

                    case 'HistoryTrace0'
                        obj.history_trace_0 = s2.raw_data;
                    case 'HistoryTrace1'
                        obj.history_trace_1 = s2.raw_data;
                    case 'HistoryTrace2'
                        obj.history_trace_2 = s2.raw_data;
                    case 'HistoryTrace3'
                        obj.history_trace_3 = s2.raw_data;
                    case 'ID'
                        obj.id = s2.raw_data;
                    case 'Name'
                        obj.name = s2.data_value;

                    otherwise
                        keyboard
                end
            end

        end
    end
end