classdef raw_object
    %
    %   Class:
    %   epworks.parse.iom.raw_object
    %
    %   Maybe rename as raw_entry or something



    properties
        n_bytes_to_next
        n_props
        props
        prop_types
        depth
    end

    methods
        function obj = raw_object(bytes,I1,r,depth)
            %
            %   obj = epworks.parse.raw_object(bytes,I1,r)
            %
            %   Inputs
            %   ------
            %   r : epworks.parse.iom.logger

            depth = depth + 1;
            obj.depth = depth;

            %We may want to do more here
            r.logEntry();
            
            %fprintf('Processing obj: %d:%d\n',I1,depth)

            obj.n_bytes_to_next = double(typecast(bytes(I1+1:I1+4),'uint32'));
            %   Format
            %   ------
            %   1: value 5 - object
            %   2:5: u32, n bytes to next object
            %   6:9: u32, n properties
            %   10 - starts the type of the next thing
            obj.n_props = double(typecast(bytes(I1+5:I1+8),'uint32'));
            I1 = I1 + 9;
            props = cell(1,obj.n_props);
            prop_types = zeros(1,obj.n_props);
            for i = 1:obj.n_props
                [value,I1,prop_type] = epworks.parse.iom.parse_type(bytes,I1,r,depth);
                prop_types(i) = prop_type;
                props{i} = value;
            end
            obj.prop_types = prop_types;
            obj.props = props;
        end
        function s = getStruct(obj)
            s = struct;
            p = struct;
            any_array = false;
            array_indices = zeros(1,obj.n_props);
            array_values = cell(1,obj.n_props);

            guid_string = '';
            for i = 1:obj.n_props
                p2 = obj.props{i};
                name = p2.props{1};
                if isscalar(p2.props)
                    %I've seen this if a property is not populated so
                    %all we have is the property name and no value
                    value = [];
                elseif length(p2.props) == 2
                    value = p2.props{2};
                else
                    error('Assumption violatled')
                end
                if isobject(value)
                    temp = value.getStruct();
                    value = temp;
                end
                %TODO: Check # of entries, should only be 2

                %TODO: error check on name setting
                
                if name(1) == '{'
                    I = find(name == '}',1,'last');
                    if isempty(I)
                        error('assumption violated')
                    end
                    guid_string = name(1:I);
                    name = name(I+1:end);
                    name = epworks.utils.getSafeVariableName(name);
                    p.(name) = value;
                elseif isstrprop(name(1),'digit')
                    if all(isstrprop(name,'digit'))
                        any_array = true;
                        index = str2double(name);
                        array_values{i} = value;
                        array_indices(i) = index+1;
                    else
                        name = ['x' name];
                        name = epworks.utils.getSafeVariableName(name);
                        p.(name) = value;
                    end
                    
                else
                    %no issues except maybe safety
                    name = epworks.utils.getSafeVariableName(name);
                    p.(name) = value;
                end
            end

            s.guid = guid_string;


            if any_array
                if all(array_indices > 0) && issorted(array_indices)
                    s.array = array_values;
                else
                    error('Not yet implemented')
                end
            else
                s.array = [];
            end

            s.props = p;
            if isfield(s.props,'Type')
                s.type = s.props.Type;
            else
                s.type = '';
            end
            s.depth = obj.depth;
        end
    end
end