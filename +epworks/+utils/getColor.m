function out = getColor(value)
%
%   epworks.utils.getColor(value)

%value - double
temp = int32(value);
out = typecast(temp,'uint8');

end