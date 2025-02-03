classdef info  < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.patient.data.info

    properties
        s

        address
        admin
        name
        personal
    end

    methods
        function obj = info(s,r)
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

                    case 'Address'
                        obj.address = epworks.p.patient.data.info.address(s2,r);
                        r.logObject(obj.address,index);
                    case 'Admin'
                        obj.admin = epworks.p.patient.data.info.admin(s2,r);
                        r.logObject(obj.admin,index);
                    case 'Name'
                        obj.name = epworks.p.patient.data.info.name(s2,r);
                        r.logObject(obj.name,index);
                    case 'Personal'
                        obj.personal = epworks.p.patient.data.info.personal(s2,r);
                        r.logObject(obj.personal,index);
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end