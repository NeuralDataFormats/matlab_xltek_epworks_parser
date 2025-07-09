classdef cursor_view < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.iom.test.data.settings.element_layouts.elements.groups

    properties
        y
    end

    methods
        function obj = cursor_view(s,r)
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'Y'
                        obj.y = value;
                    otherwise
                        safe_name = epworks.utils.getSafeVariableName(cur_name);
                        obj.unhandled_props.(safe_name) = value;
                end
            end

            r.logUnhandledProps(obj);
            
        end
    end
end