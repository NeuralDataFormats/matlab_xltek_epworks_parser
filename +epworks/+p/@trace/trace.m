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
        s
        children

        eeg_waveform

        data epworks.p.trace.data

        id

        %u32
        is_root

        %type: id
        parent

        schema

        %string
        type

        name
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
            obj.s = s;
            n_children = length(s.child_indices);

            for i = 1:n_children
                index = s.child_indices(i);
                r.processed(index) = true;
                s2 = r.getStruct(index);

                switch s2.name
                    case 'Children'
                        obj.children = epworks.p.children(s2,r);
                        r.logObject(obj.children,index);
                    case 'Data'
                        obj.data = epworks.p.trace.data(s2,r);
                        r.logObject(obj.data,index);
                    case 'Id'
                        obj.id = s2.raw_data;
                        r.logID(obj,obj.id);
                    case 'IsRoot'
                        obj.is_root = double(typecast(s2.raw_data,'uint32'));
                    case 'Parent'
                        obj.parent = s2.raw_data;
                    case 'Schema'
                        obj.schema = double(typecast(s2.raw_data,'uint32'));
                    case 'Type'
                        obj.type = s2.data_value;
                    otherwise
                        keyboard
                end
            end
        end
    function childrenToProps(obj)
            mask = obj.children.class_names == "eeg_waveform";
            obj.eeg_waveform = [obj.children.objects{mask}];
        end
    end
end