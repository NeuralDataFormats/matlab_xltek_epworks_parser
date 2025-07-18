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
        id_props = {'group_obj'}
    end

    properties
        set_number
        group_obj
        iom_local_object = false
        is_active = false
        is_from_history = false
        num_accepted = NaN
        num_rejected = NaN
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
                        obj.group_obj = value;
                    case 'IOMLocalObject'
                        obj.iom_local_object = value;
                    case 'IsActive'
                        obj.is_active = value;
                    case 'IsFromHistory'
                        obj.is_from_history = value;
                    case 'NumAccepted'
                        obj.num_accepted = value;
                    case 'NumRejected'
                        obj.num_rejected = value;
                    otherwise
                        safe_name = epworks.utils.getSafeVariableName(cur_name);
                        obj.unhandled_props.(safe_name) = value;
                end
            end
            
            r.logUnhandledProps(obj);
        end
    end
end