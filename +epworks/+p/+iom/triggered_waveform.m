classdef triggered_waveform < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.iom.triggered_waveform

    properties (Hidden)
        id_props = {'parent'}
    end

    properties
        children
        n_children
        data

        id

        %u32
        is_root

        %type: id
        parent

        schema

        %string
        type
    end

    methods
        function obj = triggered_waveform(s,r)
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'Children'
                        obj.children = value;
                    case 'Data'
                        obj.data = epworks.p.iom.triggered_waveform.data(value,r);
                    case 'Id'
                        obj.id = value;
                        r.logID(obj,obj.id);
                    case 'IsRoot'
                        obj.is_root = value;
                    case 'Parent'
                        obj.parent = value;
                    case 'Schema'
                        obj.schema = value;
                    case 'Type'
                        obj.type = value;
                    otherwise
                        keyboard
                end
            end


        end
    end
end