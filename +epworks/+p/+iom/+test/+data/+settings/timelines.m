classdef timelines < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.test.data.settings.timelines

    properties
        s
        id
        is_enabled
        is_paused
        is_running
        is_waiting
        restart_delay
        start_waiting
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
                        obj.start_waiting = value;
                    case 'Type'
                        obj.type = value;
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end