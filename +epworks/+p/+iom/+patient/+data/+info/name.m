classdef name < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.patient.data.info.name

    properties
        s

        first_name
        last_name
        middle_name
    end

    methods
        function obj = name(s,r)
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'FirstName'
                        obj.first_name = value;
                    case 'LastName'
                        obj.last_name = value;
                    case 'MiddleName'
                        obj.middle_name = value;

                    otherwise
                        keyboard
                end
            end
            
        end
    end
end