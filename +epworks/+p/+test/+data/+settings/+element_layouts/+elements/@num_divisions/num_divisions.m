classdef num_divisions
    %
    %   Class:
    %   epworks.p.test.data.settings.element_layouts.elements.num_divisions

    properties
        s

        horizontal

        %CursorView
        %   Y
        %Traces
        %   - Guid
    end

    methods
        function obj = num_divisions(s,r)
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
                    case 'Horizontal'

                    otherwise
                        keyboard
                end
            end
            
        end
    end
end