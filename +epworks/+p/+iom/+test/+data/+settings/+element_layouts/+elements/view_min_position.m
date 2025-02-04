classdef view_min_position < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.test.data.settings.element_layouts.elements.view_min_position

    properties
        x
        x_fraction
        y
        y_fraction
    end

    methods
        function obj = view_min_position(s,r)
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'X'
                        obj.x = value;
                    case 'XFraction'
                        obj.x_fraction = value;
                    case 'Y'
                        obj.y = value;
                    case 'YFraction'
                        obj.y_fraction = value;
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end