classdef result_object < handle
    %
    %   Class:
    %   epworks.objects.result_object
    %
    %   Top level for results objects that are shown to the user
    %
    %   See Also
    %   --------
    %   epworks.parse.iom.logger
    %   epworks.p.parse_object
    
    properties
        p
        id
    end

    methods
        function obj = result_object(p,logger)
            obj.p = p;
            obj.id = p.id;
            logger.logObject(obj);
            logger.logID(obj,p.id);
        end
        function linkObjects(obj,id_tracker)
            if isprop(obj,'id_props')
                id_props = obj.id_props; %#ok<MCNPN>
                for i = 1:length(id_props)
                    id_name = id_props{i};
                    id_value = obj.(id_name);
                    if ~isempty(id_value)
                        if iscell(id_value)
                            n_ids = length(id_value);
                            objs = cell(1,n_ids);
                            for j = 1:n_ids
                                cur_id = id_value{j};
                                objs{j} = id_tracker.getObjectByID(cur_id);
                            end
                            obj.(id_name) = [objs{:}];
                        else
                            linked_object = id_tracker.getObjectByID(id_value);
                            obj.(id_name) = linked_object;
                        end
                    end
                end
            end
            % if isprop(obj,'children')
            %     n_children = length(obj.children); %#ok<MCNPN>
            %     child_objects = cell(1,n_children);
            %     for i = 1:n_children
            %         id_value = obj.children{i}; %#ok<MCNPN>
            %         linked_object = id_tracker.getObjectByID(id_value);
            %         child_objects{i} = linked_object;
            %     end
            %     obj.children = child_objects; %#ok<MCNPN>
            % end
        end
    end
end