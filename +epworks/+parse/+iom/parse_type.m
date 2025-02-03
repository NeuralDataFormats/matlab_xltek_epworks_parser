function [value,I1,prop_type] = parse_type(bytes,I1,r,depth)
%
%   [value,I1] = epworks.parse.iom.parse_type(bytes,I1,r)

    prop_type = bytes(I1);
    n_next = double(typecast(bytes(I1+1:I1+4),'uint32'));
    %fprintf('%d: %d\n',I1,n_next);
    switch bytes(I1)
        case -1
            keyboard
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
            stop_I = I1+n_next-2;
            value = char(bytes(start_I:stop_I));
        case 3
            %often ID, but sometimes it is time
            start_I = I1+5;
            stop_I = I1+20;
            value = bytes(start_I:stop_I);
        case 4
            %array
            value = epworks.parse.iom.raw_array(bytes,I1,r,depth);
        case 5
            %object
            value = epworks.parse.iom.raw_object(bytes,I1,r,depth);
        case 6
            start_I = I1+5;
            stop_I = I1+20;
            value = bytes(start_I:stop_I);
        otherwise
            error('Unrecognized type: %d',bytes(I1))
    end
    I1 = I1 + n_next;


end