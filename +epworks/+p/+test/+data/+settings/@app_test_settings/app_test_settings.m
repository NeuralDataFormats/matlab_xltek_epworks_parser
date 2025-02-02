classdef app_test_settings < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.test.data.settings.app_test_settings

    properties
        s

        build
        version
    end

    methods
        function obj = app_test_settings(s,r)
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

                    case 'Build'
                        obj.build = s2.raw_data;
                    case 'Version'
                        obj.build = s2.raw_data;
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end