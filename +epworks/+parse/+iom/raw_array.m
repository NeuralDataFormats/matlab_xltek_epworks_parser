classdef raw_array
    %
    %   Class:
    %   epworks.parse.iom.raw_array
    %
    %   See Also
    %   --------
    %   epworks.parse.iom.raw_object

    properties
        n_entries
        entries
    end

    methods
        function obj = raw_array(bytes,I1,r,depth)
            obj.n_entries = double(typecast(bytes(I1+5:I1+8),'uint32'));
            I1 = I1 + 9;
            temp = cell(1,obj.n_entries);
            for i = 1:obj.n_entries
                [temp{i},I1,prop_type] = epworks.parse.iom.parse_type(bytes,I1,r,depth);
            end
            obj.entries = temp;
        end
        function out = getStruct(obj)
            %
            %   really getArray, but I didn't put swtich
            %   case in epworks.parse.iom.raw_object
            if obj.n_entries == 0
                out = [];
            else
                out = cell(1,obj.n_entries);
                for i = 1:obj.n_entries
                    value = obj.entries{i};
                    if isobject(value)
                        temp = value.getStruct();
                        value = temp;
                    end
                    out{i} = value;
                        
                end
            end 
        end
    end
end