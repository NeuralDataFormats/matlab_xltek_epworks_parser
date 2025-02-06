classdef children < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.test.children
    %
    %   Improvement
    %   ------------
    %   We could make this a dynamic props object
    %   and add props that are arrays for each object type
    %
    %   

    properties
        raw_data
        n_children = 0
        ids
        objects
        class_names
        unique_class_names
    end

    methods
        function obj = children(s,r)
            
            obj.raw_data = s.raw_data;
            if length(obj.raw_data) > 4
                obj.n_children = double(typecast(obj.raw_data(1:4),'uint32'));
                bytes = obj.raw_data(5:end);
                temp = reshape(bytes,21,obj.n_children)';
                obj.ids = temp(:,6:end);
            end
            %Format:
            %1:4 # of children
            %5:9 : 
            %   3 21 0 0 0
            %10:x
            %   - 16 byte ids
            
        end
        function linkObjects(obj,id_tracker)
            temp = cell(1,obj.n_children);
            for i = 1:obj.n_children
                id_value = obj.ids(i,:);
                linked_object = id_tracker.getObjectByID(id_value);
                temp{i} = linked_object;
            end
            obj.objects = temp;
            obj.class_names = cellfun(@epworks.utils.getShortClassName,temp,'UniformOutput',false)';
            obj.unique_class_names = unique(obj.class_names);
        end
    end
end