classdef patient
    %
    %   Class:
    %   epworks.p.patient

    properties
        s

        children
        data

        id

        %u32
        is_root

        %type: id
        parent

        schema

        %string
        type
    end

    methods
        function obj = patient(s,r)
            obj.s = s;
            n_children = length(s.child_indices);
            for i = 1:n_children
                index = s.child_indices(i);
                r.processed(index) = true;
                s2 = r.getStruct(index);
                switch s2.name
                    case 'Children'
                        obj.children = epworks.p.patient.children(s2,r);
                    case 'Data'
                        obj.data = epworks.p.patient.data(s2,r);
                    case 'Id'
                        obj.id = s2.raw_data;
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
    end
end