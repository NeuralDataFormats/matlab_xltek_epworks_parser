classdef num_divisions < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.test.data.settings.element_layouts.elements.num_divisions

    properties
        horizontal
    end

    methods
        function obj = num_divisions(s,r)
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'Horizontal'
                        obj.horizontal = value;
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end