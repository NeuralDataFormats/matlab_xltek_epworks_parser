classdef group < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.iom.group
    %
    %   See Also
    %   --------
    %   epworks.p.iom.group.data
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
        children

        sets

        traces

        data epworks.p.iom.group.data

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
        function childrenToProps(obj,logger)
            class_names = cellfun(@epworks.utils.getShortClassName,obj.children,'un',0);

            mask = class_names == "set";
            obj.sets = [obj.children{mask}];

            mask = class_names == "trace";
            obj.traces = [obj.children{mask}];
        end
    end
end