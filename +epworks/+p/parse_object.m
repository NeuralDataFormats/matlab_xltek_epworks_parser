classdef parse_object < handle
    %
    %   Class:
    %   epworks.p.parse_object
    %
    %   This is the main class that parsed objects inherit from.
    
    % properties
    %     id_props
    % end

    %{
         < epworks.p.parse_object
    %}
    %{
    properties (Hidden)
        id_props = {'baseline_set_id','preview_set_id','raw_sweep_set_id','test_obj_id'}
    end
    %}

    methods
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
        end
        function childrenToProps(obj)
            %Null to override
        end
    end

end