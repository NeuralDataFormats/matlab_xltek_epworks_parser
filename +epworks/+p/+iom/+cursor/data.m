classdef data < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.cursor.data
    %
    %   See Also
    %   --------
    %   epworks.p.cursor
    %   
    %   

    properties (Hidden)
        id_props = {'clone','cursor_def'}
    end

    properties
        amp
        clone
        cursor_def
        has_dragged
        label
        lat
        origin_x
        origin_y
        placement
        style
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
                    case 'Amp' 
                        obj.amp = value;
                    case 'Clone'
                        obj.clone = value;
                    case 'CursorDefId'
                        obj.cursor_def = value;
                    case 'HasDragged'
                        obj.has_dragged = value;
                    case 'Label'      
                        obj.label = value;
                    case 'Lat'        
                        obj.lat = value;
                    case 'OriginX'
                        obj.origin_x = value;
                    case 'OriginY'
                        obj.origin_y = value;
                    case 'Placement'  
                        obj.placement = value;
                    case 'Style'      
                        obj.style = value;
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end