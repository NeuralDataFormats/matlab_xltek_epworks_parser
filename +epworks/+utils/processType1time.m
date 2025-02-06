function out = processType1time(raw_data)
%
%   out = epworks.utils.processType1time(raw_data)

% temp2 = epworks.sl.datetime.msVariantToMatlab(raw_data);
% 
temp1 = typecast(raw_data,'double');
temp2 = epworks.sl.datetime.msVariantToMatlab(temp1);
out = datetime(temp2,'ConvertFrom','datenum');

end