classdef view_position
    %
    %   Class:
    %   epworks.p.test.data.settings.element_layouts.elements.view_position

    properties
        full_screen
        height
        height_fraction
        minimized
        width
        width_fraction
        x
        x_fraction
        y
        y_fraction
    end

    methods
        function obj = view_position(s,r)
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'FullScreen'
                        obj.full_screen = value;
                    case 'Height'
                        obj.height = value;
                    case 'HeightFraction'
                        obj.height_fraction = value;
                    case 'Minimized'
                        obj.minimized = value;
                    case 'Width'
                        obj.width = value;
                    case 'WidthFraction'
                        obj.width_fraction = value;
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