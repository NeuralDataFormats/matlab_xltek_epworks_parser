classdef trace
    %
    %   Class:
    %   epworks.p.trace

    properties
        s
        names
        objs
        
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
        function obj = trace(s,r)
            obj.s = s;
            n_children = length(s.child_indices);
            names = cell(1,n_children);
            objs = cell(1,n_children);
            for i = 1:n_children
                index = s.child_indices(i);
                r.processed(index) = true;
                s2 = r.getStruct(index);
                names{i} = s2.name;
                switch s2.name
                    case 'Children'
                        obj.children = epworks.p.trace.children(s2,r);
                    case 'Data'
                        obj.data = epworks.p.trace.data(s2,r);
                    case 'Id'
                        obj.id = s2.raw_data;
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
            obj.names = names;
            obj.objs = objs;

        end
    end
end