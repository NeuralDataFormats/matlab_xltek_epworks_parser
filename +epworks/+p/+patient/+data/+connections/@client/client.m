classdef client  < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.patient.data.connections.client

    properties (Hidden)
        id_props = {'process_id'}
    end

    properties
        s

        process_id
    end

    methods
        function obj = client(s,r)
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

                    case 'ProcessId'
                        obj.process_id = s2.raw_data;
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end