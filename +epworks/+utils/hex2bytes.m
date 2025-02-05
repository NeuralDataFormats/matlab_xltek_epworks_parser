function output = hex2bytes(hex_value)
%
%   output = epworks.utils.hex2bytes(hex_value)

temp = reshape(hex_value,2,[])';
%temp => rows are now 2 chars each

dec_values = hex2dec(temp);

output = uint8(dec_values)';

end