classdef source < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.patient.data.connections.source

    properties
        host
    end

    methods
        function obj = source(s,r)
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'Host'
                        obj.host = value;
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end