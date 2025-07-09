function [value,I1,prop_type] = parse_type(bytes,I1,r,depth,temp_name)
%
%   [value,I1] = epworks.parse.iom.parse_type(bytes,I1,r)
%
%   See Also
%   --------
%   epworks.parse.iom.raw_object

    prop_type = bytes(I1);
    n_next = double(typecast(bytes(I1+1:I1+4),'uint32'));
    %fprintf('%d: %d\n',I1,n_next);
    switch bytes(I1)
        case -1
            error('Unexpected value')
        case 0
            %4 bytes, interpretation varies
            %   - often int32
            %   - sometimes color ...
            start_I = I1+5;
            stop_I = I1+8;
            %value = bytes(start_I:stop_I);
            value = double(typecast(bytes(start_I:stop_I),'int32'));
        case 1
            %double
            start_I = I1+5;
            stop_I = I1+12;
            value = typecast(bytes(start_I:stop_I),'double');
        case 2
            %string, null terminated
            start_I = I1+5;
            %-1 for edge, e.g., grabbing 5:7 is 5:(3-1)
            %-1 for null terminated (last is 0)
            %-2 in total
            stop_I = I1+n_next-2;
            value = char(bytes(start_I:stop_I));
        case 3
            %often ID, but sometimes it is time
            %
            %   For time zone this is some long time
            start_I = I1+5;
            %stop_I = I1+20;
            stop_I = I1 + n_next-1;
            % % % if n_next ~= 21
            % % %     %Timestamp - only 12
            % % %     %SourceData
            % % %     %CreateTime
            % % %     %StartWaiting
            % % %     %FullScreen
            % % %     %Minimized
            % % %     %{object_name}<lots of values>
            % % %     %STLiveTimestamp
            % % % 
            % % %     %Ignore these two, what else do we get?
            % % % 
            % % %     % if temp_name == "Timestamp" || temp_name == "SourceData" || temp_name == "CreateTime" || temp_name == "STLiveTimestamp"
            % % %     % 
            % % %     % else
            % % %     %     fprintf('%s\n',temp_name);
            % % %     % end
            % % % end
            value = bytes(start_I:stop_I);
        case 4
            %array
            value = epworks.parse.iom.raw_array(bytes,I1,r,depth);
        case 5
            %object
            value = epworks.parse.iom.raw_object(bytes,I1,r,depth);
        case 6
            start_I = I1+5;
            %TODO: Check n_next here
            stop_I = I1+20;
            if n_next ~= 21
                error('Fix this code like we did for case 3')
                %Make it look like 3
                %- this will have downstream effects with value parsing
                
            end
            value = bytes(start_I:stop_I);
        otherwise
            error('Unrecognized type: %d',bytes(I1))
    end
    I1 = I1 + n_next;


end