function name = getSafeVariableName(name)
%
%   name = epworks.utils.getSafeVariableName(name)

%Decided not to use this

%name = regexprep(name,'[!\-\[\]]','_');
name = regexprep(name,'[!\-\[\]\(\)\s]','_');

end