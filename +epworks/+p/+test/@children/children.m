classdef children
    %
    %   Class:
    %   epworks.p.test.children

    properties
        s
        names
        objs
    end

    methods
        function obj = children(s,r)
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
                    otherwise
                        keyboard
                end
            end
            obj.names = names;
            obj.objs = objs;
            
        end
    end
end