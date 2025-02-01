classdef electrode
    %
    %   Class:
    %   epworks.p.test.data.settings.electrode

    properties
        s
        eeg_site_guid
        id
        location
        phys_electrode
        phys_name
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
                obj = epworks.p.test.data.settings.electrode(s2,r);
                objs{i} = obj;
            end
            objs = [objs{:}];
        end
    end

    methods
        function obj = electrode(s,r)
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

                    case 'EEGSiteGUID'
                    case 'ID'
                    case 'Location'
                    case 'PhysElectrode'
                    case 'PhysName'

                    otherwise
                        keyboard
                end
            end
            
        end
    end
end