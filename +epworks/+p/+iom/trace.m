classdef trace < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.trace
    %
    %   See Also
    %   --------
    %   epworks.p.trace.data

    properties (Hidden)
        id_props = {'parent'}
    end

    properties
        name
        children
        groups
        eeg_waveforms

        rec_data
        history

        data
        id
        is_root
        parent
        schema
        type
    end

    methods 
        function value = get.name(obj)
            try
                value = obj.data.name;
            catch
                value = '';
            end
        end
    end

    methods
        function obj = trace(s,r)
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                
                switch cur_name
                    case 'Children'
                        obj.children = value;
                    case 'Data'
                        obj.data = epworks.p.iom.trace.data(value,r);
                    case 'Id'
                        obj.id = value;
                        r.logID(obj,obj.id);
                    case 'IsRoot'
                        obj.is_root = value;
                    case 'Parent'
                        obj.parent = value;
                    case 'Schema'
                        obj.schema = value;
                    case 'Type'
                        obj.type = value;
                    otherwise
                        keyboard
                end
            end
        end
    function childrenToProps(obj)
            if ~isempty(obj.children)
                class_names = cellfun(@epworks.utils.getShortClassName,obj.children,'un',0);
                mask = class_names == "group";
                obj.groups = [obj.children{mask}];
                
                mask = class_names == "eeg_waveform";
                obj.eeg_waveforms = [obj.children{mask}];
            end
        end
    end
end