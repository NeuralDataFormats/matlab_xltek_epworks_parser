classdef cursor < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.iom.cursor

    properties (Hidden)
        id_props = {'parent'}
    end

    properties
        children
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
        function obj = cursor(s,r)
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
                        obj.data = epworks.p.iom.cursor.data(value,r);
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
                        safe_name = epworks.utils.getSafeVariableName(cur_name);
                        obj.unhandled_props.(safe_name) = value;
                end
            end

            r.logUnhandledProps(obj);

        end
    end
end