classdef data < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.set.data
    %
    %   See Also
    %   --------
    %   epworks.p.set
    %   
    %   

    properties (Hidden)
        id_props = {'group_obj_id'}
    end

    properties
        set_number
        group_obj_id
        is_active
        num_accepted
    end

    methods
        function obj = data(s,r)
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'SetNumber'
                        obj.set_number = value;
                    case 'GroupObjId'
                        obj.group_obj_id = value;
                    case 'IsActive'
                        obj.is_active = value;
                    case 'NumAccepted'
                        obj.num_accepted = value;
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end