classdef parse_object < handle
    %
    %   Class:
    %   epworks.p.parse_object
    %
    %   This is the main class that parsed objects inherit from.
    
    properties
        unhandled_props
    end

    %{
         < epworks.p.parse_object
    %}
    %{
    properties (Hidden)
        id_props = {'baseline_set_id','preview_set_id','raw_sweep_set_id','test_obj_id'}
    end
    %}

    methods
        function logUnhandled(obj,name,value,r)
            %What do we want to do here?
        end
        function linkObjects(obj,id_tracker)
            if isprop(obj,'id_props')
                id_props = obj.id_props; %#ok<MCNPN>
                for i = 1:length(id_props)
                    id_name = id_props{i};
                    id_value = obj.(id_name);
                    if ~isempty(id_value)
                        linked_object = id_tracker.getObjectByID(id_value);
                        obj.(id_name) = linked_object;
                    end
                end
            end
            if isprop(obj,'children')
                n_children = length(obj.children); %#ok<MCNPN>
                child_objects = cell(1,n_children);
                for i = 1:n_children
                    id_value = obj.children{i}; %#ok<MCNPN>
                    linked_object = id_tracker.getObjectByID(id_value);
                    child_objects{i} = linked_object;
                end
                obj.children = child_objects; %#ok<MCNPR>
            end
        end
        function childrenToProps(obj,logger)
            %Null to override
        end
    end

end

%   r.logObject(obj.client,index);
%   r.logID(obj,obj.id);
%{
    properties (Hidden)
        id_props = {'baseline_set_id','preview_set_id','raw_sweep_set_id','test_obj_id'}
    end


    properties (Hidden)
        id_props = {'parent'}
    end

                        obj.id = s2.raw_data;
                        r.logID(obj,obj.id);


%}