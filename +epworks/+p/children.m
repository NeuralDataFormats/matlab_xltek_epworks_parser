classdef children < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.test.children

    properties
        raw_data
        ids
    end

    methods
        function obj = children(s,r)
            

            obj.raw_data = s.raw_data;
            if length(obj.raw_data) > 4
                bytes = obj.raw_data(10:end);
                n_entries = length(bytes)/16;
                obj.ids = reshape(bytes,16,n_entries)';
                if n_entries > 1

                end
            end
            %Format:
            %1 : # of children
            %2:9 : ????
            %   0 0 0 3 21 0 0 0
            %10:x
            %   - 16 byte ids


            % % % 
            % % % 
            % % % obj.s = s;
            % % % n_children = length(s.child_indices);
            % % % names = cell(1,n_children);
            % % % objs = cell(1,n_children);
            % % % for i = 1:n_children
            % % %     index = s.child_indices(i);
            % % %     r.processed(index) = true;
            % % %     s2 = r.getStruct(index);
            % % %     names{i} = s2.name;
            % % %     switch s2.name
            % % %         otherwise
            % % %             keyboard
            % % %     end
            % % % end
            % % % obj.names = names;
            % % % obj.objs = objs;
            
        end
        function linkObjects(obj,id_tracker)
            if isprop(obj,'id_props')
                id_props = obj.id_props;
                for i = 1:length(id_props)
                    id_name = id_props{i};
                    id_value = obj.(id_name);
                    linked_object = id_tracker.getObjectByID(id_value);
                    obj.(id_name) = linked_object;
                end
            end
        end
    end
end