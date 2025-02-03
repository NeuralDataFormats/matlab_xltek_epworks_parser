classdef study < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.study
    %
    %   See Also
    %   --------
    %   epworks.p.patient
    %   epworks.p.test
    %   epworks.p.study.children
    %   epworks.p.study.data
    %
    %   Hierarchy
    %   ----------
    %   - patient
    %       - study
    %           - test

    properties (Hidden)
        id_props = {'parent'}
    end

    properties
        s

        children
        tests

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
        function obj = study(s,r)
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'Children'
                        obj.children = value;
                    case 'Data'
                        obj.data = epworks.p.iom.study.data(value,r);
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
            mask = obj.children.class_names == "test";
            obj.tests = [obj.children.objects{mask}];
        end
    end
end