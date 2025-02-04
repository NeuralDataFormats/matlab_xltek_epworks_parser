classdef address < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.iom.patient.data.info.address

    properties
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
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
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