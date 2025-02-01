function out = processType3time(raw_data)
%
%   out = epworks.utils.processType3time(raw_data)

temp1 = typecast(raw_data,'uint64');
temp2 = epworks.sl.datetime.msBase1601ToMatlab(temp1);
out = datetime(temp2,'ConvertFrom','datenum');

end