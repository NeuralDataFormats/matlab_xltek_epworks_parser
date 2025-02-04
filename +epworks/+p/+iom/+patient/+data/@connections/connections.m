classdef connections  < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.patient.data.connections

    properties
        client
        sink
        source
    end

    methods
        function obj = connections(s,r)
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'Client'
                        obj.client = epworks.p.iom.patient.data.connections.client(value,r);
                    case 'Sink'
                        obj.sink = epworks.p.iom.patient.data.connections.sink(value,r);
                    case 'Source'
                        obj.source = epworks.p.iom.patient.data.connections.source(value,r);
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end