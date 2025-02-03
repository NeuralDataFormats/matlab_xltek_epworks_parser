classdef group < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.group
    %
    %   See Also
    %   --------
    %   epworks.p.study
    %   epworks.p.test
    %   epworks.p.group
    %   epworks.p.set
    %   epworks.p.traces
    %   
    %
    %   Hierarchy
    %   ---------
    %   - study
    %       - test
    %           - group
    %               - sets
    %               - traces

    properties (Hidden)
        id_props = {'parent'}
    end

    properties
        s
        
        children
        n_children

        sets
        traces

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
        function obj = group(s,r)
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'Children'
                        obj.children = value;
                    case 'Data'
                        obj.data = epworks.p.iom.group.data(value,r);
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
        function childrenToProps(obj)
            mask = obj.children.class_names == "set";
            obj.sets = [obj.children.objects{mask}];

            mask = obj.children.class_names == "trace";
            obj.traces = [obj.children.objects{mask}];
        end
    end
end