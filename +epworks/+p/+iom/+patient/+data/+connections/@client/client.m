classdef client  < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.iom.patient.data.connections.client

    properties (Hidden)
        id_props = {'process_id'}
    end

    properties
        process_id
    end

    methods
        function obj = client(s,r)
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'ProcessId'
                        obj.process_id = value;
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end