classdef address < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.patient.data.info.address

    properties
        s

        address1
        address2
        city
        country
        state
        state_label
        zip
        zip_label
    end

    methods
        function obj = address(s,r)
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
                    case 'Address1'
                    case 'Address2'
                    case 'City'
                    case 'Country'
                    case 'State'
                    case 'StateLabel'
                    case 'ZIP'
                    case 'ZIPLabel'
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end