function out = getColor(value)
%
%   epworks.utils.getColor(value)

%value - double
temp = int32(value);
out = double(typecast(temp,'uint8'));
%MATLAB likes colors as 0 to 1 double
out = out/255;

end