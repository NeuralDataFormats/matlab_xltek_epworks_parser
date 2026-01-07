function t = objectsPropsToTable(objs, prop_names)
%
%   t = epworks.utils.objectsPropsToTable(objs, prop_names)
%
%
%   Example
%   -------
%   t = epworks.utils.objectsPropsToTable(trig_objs,...
%       ["stim_intensity","trigger_delay","is_for_review","is_from_history","is_grabbed","is_rejected_data","n_samples","set_number"])

% Convert property names to cell array if it's a string array
if isstring(prop_names)
    prop_names = cellstr(prop_names);
end

% Get number of objects and properties
n_objs = numel(objs);
n_props = numel(prop_names);

% Initialize cell array to store all data
data = cell(n_objs, n_props);

% Extract each property from each object
for i = 1:n_objs
    for j = 1:n_props
        % Get property value
        prop_value = objs(i).(prop_names{j});
        % Store in cell array
        data{i, j} = prop_value;
    end
end

% Create table with property names as variable names
t = cell2table(data, 'VariableNames', prop_names);
end