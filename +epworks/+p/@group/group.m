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
            obj.s = s;
            n_children = length(s.child_indices);
            for i = 1:n_children
                index = s.child_indices(i);
                r.processed(index) = true;
                s2 = r.getStruct(index);
                switch s2.name
                    case 'Children'
                        obj.children = epworks.p.children(s2,r);
                        obj.n_children = obj.children.n_children;
                        r.logObject(obj.children,index);
                    case 'Data'
                        obj.data = epworks.p.group.data(s2,r);
                        r.logObject(obj.data,index);
                    case 'Id'
                        obj.id = s2.raw_data;
                        r.logID(obj,obj.id);
                    case 'IsRoot'
                        obj.is_root = double(typecast(s2.raw_data,'uint32'));
                    case 'Parent'
                        obj.parent = s2.raw_data;
                    case 'Schema'
                        obj.schema = double(typecast(s2.raw_data,'uint32'));
                    case 'Type'
                        obj.type = s2.data_value;
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