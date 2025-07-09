classdef snippet_group < handle
    %
    %   Class:
    %   epworks.objects.snippet_group
    %
    %   Goal: To have something that will be used for plotting

    properties
        traces
        names
        fs
        has_data
        data
        t0
    end

    methods
        function obj = snippet_group(traces,target,varargin)
            %
            %   obj = epworks.objects.snippet_group(traces,target,options)
            %
            %
            %   This is meant to be called on the traces of a group.
            %
            %   Inputs
            %   ------
            %   target:
            %       - free
            %       - eeg
            %
            %   Example
            %   -------
            %   TODO

            %   time requests
            %       - nearest to timepoint
            %       - between two time points



            if nargin == 0
                return
            end

            %options = epworks.sl.in.structToPropValuePairs(options);

            %Ugh, is there a better way of doing this? I want arguments
            %on this but I want to allow object construction without
            %arguments. I ended moving the constructor to a helper function
            %which unfortunately hides the argument tab completion.
            %
            %   TODO: I think if we set defaults they become optional
            %   although in reality I want to have different calling forms
            %   0 inputs, or 3 required
            obj.constructObject(traces,target,varargin{:})
        end

        function constructObject(obj,traces,target,options)
            arguments
                obj
                traces
                target
                options.merge_tolerance = seconds(1);
                options.near = [];
                %Note, this currently requires all entries with data
                %for a given row to be within range
                %
                %   as an expansion we could optionally zero those that are
                %   out of range if some of the row entries are within 
                %   range
                options.between = [];
            end
            obj.traces = traces;

            %Resolve waveforms (freerun or eeg)
            %--------------------------------------------------------------
            target = string(target);
            %ASSUMPTION: Only 1. Note, we'll also 
            if startsWith(target,'free','IgnoreCase',true)
                for i = 1:length(traces)
                    trace = traces(i);
                    if ~isscalar(trace.freerun_waveforms)
                        error('Code assumes single freerun_waveform for all traces')
                    end
                end
                w = [traces.freerun_waveforms];
            elseif startsWith(target,'eeg','IgnoreCase',true)
                for i = 1:length(traces)
                    trace = traces(i);
                    if ~isscalar(trace.eeg_waveforms)
                        error('Code assumes single eeg_waveform for all traces')
                    end
                end
                w = [traces.eeg_waveforms];
            else
                error('Unsupported target')
            end

            %Extract the data objects
            %--------------------------------------------------------------
            %ASSUMPTION: scalar data entry
            for i = 1:length(w)
                if ~isscalar(w(i).data)
                    error('Code assumes single eeg_waveform for all traces')
                end
            end

            %epworks.objects.signal
            data = [w.data];
            n_data = length(data);

            obj.names = {data.name};
            obj.fs = [data.fs];

            %Combine times 
            %--------------------------------------------------------------
            %Note, this is overkill for near option
            [merged_t0,source_indices] = mergeByTime({data.t0},options.merge_tolerance);
            %NaT for non-aligned waveform
            %0 for non-aligned index


            %Create the final resulting dataset
            %--------------------------------------------------------------
            if ~isempty(options.near)
                diffs = abs(options.near - merged_t0);
                [~,I] = min(diffs(:));
                [row,~] = ind2sub(size(diffs), I);
                %TODO: The row indicates what we should keep

                %For each waveform, grab:
                %t0 - array (store in matrix)
                %is_real_mask
                %data - cell array (store in matrix)
                %
                %
                % 

                indices = row;

            elseif ~isempty(options.between)
                mask = merged_t0 > options.between(1) & merged_t0 < options.between(2);
                mask = mask | isnat(merged_t0);
                mask = all(mask,2);
                indices = find(mask);
            else
                %just keep all merged
                indices = 1:size(merged_t0,1);
            end

            n_indices = length(indices);

            t0_final = NaT(n_indices,n_data);
            data_final = cell(n_indices,n_data);
            has_data = false(n_indices,n_data);

            %merged_t0 = merged_t0(indices,:);
            source_indices = source_indices(indices,:);

            %TODO: We can loop over data and apply a mask to remove i var
            for i = 1:n_indices
                for j = 1:n_data
                    target_index = source_indices(i,j);
                    if ~(target_index == 0)
                        has_data(i,j) = true;
                        data_final(i,j) = data(j).data(target_index);
                        t0_final(i,j) = data(j).t0(target_index);
                    end
                end
            end

            obj.has_data = has_data;
            obj.data = data_final;
            obj.t0 = t0_final;
        end
        %Eventually would like to do filtering of events that generates
        %a new object
        function obj2 = keepChans(obj,names_to_keep)
            %
            %   Keeps channels (helps with plotting)
            %
            % TODO: Do we want to keep the order stable
            %   
            %   Currently keeping the order stable. We could make it an
            %   option so that it matches the input order.
            [mask,loc] = ismember(names_to_keep,obj.names);
            if ~all(mask)
                error('Not all requested names were found')
            end
            I = sort(loc);
            
            obj2 = epworks.objects.snippet_group();
            obj2.traces = obj.traces(I);
            obj2.names = obj.names(I);
            obj2.fs = obj.fs(I);
            obj2.has_data = obj.has_data(:,I);
            obj2.data = obj.data(:,I);
            obj2.t0 = obj.t0(:,I);
        end
        function obj2 = dropChans(obj,names_to_drop)
            %
            %   Drops channels (helps with plotting)
            
            [mask,loc] = ismember(names_to_drop,obj.names);
            if ~all(mask)
                error('Not all requested names were found')
            end
            I = 1:length(obj.names);
            I(loc) = [];
            obj2 = epworks.objects.snippet_group();
            obj2.traces = obj.traces(I);
            obj2.names = obj.names(I);
            obj2.fs = obj.fs(I);
            obj2.has_data = obj.has_data(:,I);
            obj2.data = obj.data(:,I);
            obj2.t0 = obj.t0(:,I);

        end
        function obj2 = newFromIndices(obj,indices)
            %
            %   Generates new objects, keeping only
            %   the desired indices (helps with plotting)
            
            obj2 = epworks.objects.snippet_group();
            obj2.traces = obj.traces;
            obj2.names = obj.names;
            obj2.fs = obj.fs;
            obj2.has_data = obj.has_data(indices,:);
            obj2.data = obj.data(indices,:);
            obj2.t0 = obj.t0(indices,:);
        end
        function varargout = plot(obj,options)
            %
            %   See Also
            %   --------
            %   epworks.objects.triggered_waveform>plot

            arguments
                obj
                %TODO: For numeric and duration do we want to reset
                %
                %Trigger - we want the reset
                %
                %Should probably give both
                %
                %   make everything with reference to first data point
                %duration_extend?
                %numeric_extend?
                options.time_units string {mustBeMember(options.time_units, ["samples","datetime", "duration", "numeric"])} = "datetime"
                options.x_multi string {mustBeMember(options.x_multi, ["preserve","extend", "zero"])} = "preserve"
                options.filter = false; %NYI
                options.add_chan_label = true;
                options.reverse_y = true;

                %Spacing options
                %---------------
                %NYI
                %- 'file' from file
                %- 'data' from data - note, this becomes hard across sets
                %           (NYI)
                %- #### - scaling based on file
                %       - use 1 as default for easier interpretation
                %- array - hardcoded offsets
                %- [] - everything level but with legend (legend NYI)

                options.spacing = 'file';
                options.clear_axes = true;

                %For 
                options.color = []; %NYI
                options.line_options = {};
            end

            s = struct;

            ax = gca;
            if options.clear_axes
                cla(ax)
            end

            traces2 = obj.traces;
            n_objs = length(traces2);

            %TODO: This code is shared with triggered_waveforms and would
            %ideally be shared ....
            %
            %   see epworks.utils.plot_helper
            if strcmpi(options.spacing,'file') || ...
                    (isnumeric(options.spacing) && isscalar(options.spacing))
                %For display gain I only want to change the spacing, not
                %the actual scaling on the plot
                %
                %   These are ideally equivalent. By reducing spacing we make
                %   each signal larger on the plot (for a given y-range)

                if strcmpi(options.spacing,'file') 
                    k = 1;
                else
                    k = options.spacing;
                end
                
                origin_y2 = [traces2.origin_y];
                left_disp_gains = ones(1,n_objs);
                for i = 1:n_objs
                    try
                        left_disp_gains(i) = traces2(i).o_chan.left_display_gain;
                    end
                end

                %signals may have different gains, which is confusing
                %on a plot, so we'll adjust origin by the median gain
                left_disp_gain_avg = median(left_disp_gains,'omitmissing');
                if isnan(left_disp_gain_avg)
                    left_disp_gain_avg = 1;
                end
    
                %This 0.5 and /50 is approximate. As you change the 
                %plot size in the program these change. But in general this
                %gets us pretty close.
                origin_y2 = k*0.50*origin_y2*left_disp_gain_avg/50;

            elseif strcmpi(options.spacing,'data')
                error('Not yet implemented')
            elseif length(options.spacing) == n_objs
                origin_y2 = options.spacing;
            elseif isempty(options.spacing)
                origin_y2 = zeros(n_objs,1);
            else
                error('Unrecognized spacing option')
            end

            hold(ax,'on')
            n_times = size(obj.data,1);
            s_time = struct;
            for j = 1:n_objs
                safe_name = epworks.utils.getSafeVariableName(obj.names{j});
                for i = 1:n_times
                    if obj.has_data(i,j)
                        data_to_plot = obj.data{i,j};
                        t02 = obj.t0(i,j);
                        fs2 = obj.fs(j);
                        [x,s_time] = epworks.utils.plot_helper.getXData(...
                            data_to_plot,t02,fs2,...
                            options.time_units,options.x_multi,s_time,safe_name);

                        y = data_to_plot + origin_y2(j);
                        %TODO: Add on color support
                        plot(x,y,options.line_options{:})
                    end
                end
            end
            hold(ax,'off')
            if options.reverse_y 
                ax.YDir = "reverse";
            end

            x_lim = ax.XLim;
            xlim(ax,'tight')

            h_label = struct;
            for i = 1:n_objs
                y_val = origin_y2(i);
                h_temp = text(x_lim(1), y_val, obj.names{i}, ...
                    'VerticalAlignment', 'bottom', ...
                    'HorizontalAlignment', 'left');
                safe_name = epworks.utils.getSafeVariableName(obj.names{i});
                h_label.(safe_name) = h_temp;
            end
            s.h_label = h_label;
            s.s_time = s_time;

            if nargout
                varargout{1} = s;
            end
        end
    end
end

function [merged_datetimes,source_indices] = mergeByTime(arrays, tolerance)
%
%   Inputs
%   ------
%   arrays: cell array of sorted datetime or numeric arrays
%   tolerance: duration or numeric scalar specifying the matching window
%


n_arrays = numel(arrays);
idx = ones(1, n_arrays); % current index for each array

%TODO: Could preallocate and grow
merged_datetimes = datetime.empty; % initialize result
source_indices = [];
row = 0;

while true

    %Collect the next available value from each array
    %---------------------------------------------------------------
    current_datetimes = cell(1, n_arrays);
    for i = 1:n_arrays
        if idx(i) <= numel(arrays{i})
            current_datetimes{i} = arrays{i}(idx(i));
        else
            current_datetimes{i} = []; % exhausted
        end
    end

    % If all arrays are exhausted, we're done
    if all(cellfun(@isempty, current_datetimes))
        break
    end

    % Get the smallest available time point
    available = cellfun(@(x) isempty(x), current_datetimes);
    currentTimes = [current_datetimes{~available}];
    [min_time, ~] = min(currentTimes);

    % Create a row for this match
    row = row + 1;
    new_row_values = NaT(1, n_arrays);
    new_row_indices = zeros(1,n_arrays);
    for i = 1:n_arrays
        t = current_datetimes{i};
        if ~isempty(t) && abs(t - min_time) <= tolerance
            new_row_values(i) = t;
            new_row_indices(i) = idx(i);
            idx(i) = idx(i) + 1; % advance index if matched
        end
    end

    merged_datetimes(row, :) = new_row_values;
    source_indices(row,:) = new_row_indices;
end

end
