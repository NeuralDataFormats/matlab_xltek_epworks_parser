function short_name = getShortClassName(obj)
%
%   short_name = epworks.utils.getShortClassName(obj)

class_name = class(obj);
I = find(class_name == '.',1,'last');

if isempty(I)
    short_name = class_name;
else
    short_name = class_name(I+1:end);
end

end