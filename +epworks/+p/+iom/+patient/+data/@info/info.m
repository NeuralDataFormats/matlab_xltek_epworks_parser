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
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'Address'
                        obj.address = epworks.p.iom.patient.data.info.address(value,r);
                    case 'Admin'
                        obj.admin = epworks.p.iom.patient.data.info.admin(value,r);
                    case 'Name'
                        obj.name = epworks.p.iom.patient.data.info.name(value,r);
                    case 'Personal'
                        obj.personal = epworks.p.iom.patient.data.info.personal(value,r);
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end