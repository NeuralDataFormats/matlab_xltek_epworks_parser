classdef traces < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.test.data.settings.element_layouts.elements.traces

    properties
        guid
    end

    methods
        function obj = traces(s,r)
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'Guid'
                        obj.guid = value;
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end