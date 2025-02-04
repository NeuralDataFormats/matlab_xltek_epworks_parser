classdef sink < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.patient.data.connections.sink

    properties
        host
    end

    methods
        function obj = sink(s,r)
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