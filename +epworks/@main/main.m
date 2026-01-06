classdef main < epworks.RNEL.handle_light
    %
    %   Class:
    %   epworks.main
    %
    %   This is the new main class for accessing data.
    %
    %   Additional information that has been parsed but that is not
    %   wrapped nicely can be found in the .p property
    %
    %   Hierarchy
    %   ---------
    %   patient - NYI
    %     study
    %       test
    %         group
    %           trace
    %             eeg_waveform
    %             triggered_waveform
    %             freerun_waveform
    %
    %   See Also
    %   --------
    %   epworks.objects.triggered_waveform_group
    %
    %
    %
    %   Settings
    %   --------
    %   test.data.settings
    %       .o_chans
    %       .i_chans
    %       .group_def
    %       .electrodes
    %       .cursor_calc
    %       .cursor_def
    %       .timelines       
    %
    %   group_def
    %       .timeline
    %       .trigger_source
    %
    %   ochan
    %       .group_def
    %       .to (i_chans)
    %
    %   ichan
    %       .active_electrode
    %       .ref_electrode
    %
    %
    %   Improvements
    %   ------------
    %   1) Some waveforms do not have a trace object. Create an orphaned
    %   waveforms section until we know what these are and how to better
    %   handle them.
    %   2) We could do some first passes at speed. Right now the focus has
    %   largely been on getting something that works.
    %
    %
    %   Unhandled and Unknowns
    %   ----------------------
    %   1. Lots of small unknowns. Tried to start using "UNKNOWN" to
    %   indicate this.
    %   2. The TST files seem to be redundant with the IOM file. They 
    %   may actually be the settings at the time of the data creation.
    %   This may be more accurate but for now sorting this out is low
    %   priority.
    %   3. I started to parse the SPT files but they didn't look
    %   interesting (could be wrong).
    %   4. Trending.DAT is not processed.
    %   5. Some REC files do not have traces. Not sure what to do with
    %   those files. The parser class indicates if this happened and 
    %   which REC files this applies to.
    %   6. There are some redundant IDs with cursor_calc and cursor_def.
    %   It is not clear why the ID is showing more than once.
    %
    %
    %   See Also
    %   --------
    %   epworks.parse.main

    properties
        s %This is a structure that holds all of the top level parsed
        %objects.

        triggered_waveforms_unsorted
        %sets_unsorted
        note0 = "above are 'Hidden' variables that generally shouldn't be used"
    end

    properties
        
        p epworks.parse.main
        %(P)arsed information 
        %
        %   This is closer to the raw form of the data

        traces epworks.objects.trace
        %These are signal definitions
        %
        %   Note, I believe the name is not unique. It is only
        %   unique with the group. Multiple groups may have traces
        %   with the same name.
        
        groups epworks.objects.group
        %Groups are collections of channels.

        sets epworks.objects.set
        tests epworks.objects.test
        studies epworks.objects.study

        note1 = 'following waveforms are organized alphabetically'
        note2 = 'go in through the "groups" objects to get better layout support'
        eeg_waveforms epworks.objects.eeg_waveform
        %

        triggered_waveforms

        freerun_waveforms

        notes

        group_info
        eeg_info
        freerun_info
        triggered_info

        %Not yet exposed - these are parsed
        % - patient
        %
        % - cursors - I found one file where the IDs were not unique
    end
    
    methods
        function obj = main(study_path_or_iom_path,options)

            arguments
                study_path_or_iom_path
                options.sort_by_display = true;
                options.show_rec_progress = false;
            end
            
            if nargin == 0
                study_path_or_iom_path = '';
            end

            obj.p = epworks.parse.main(study_path_or_iom_path,...
                options.show_rec_progress);
            obj.s = obj.p.iom.s2;
            
            %I don't like where this object lives but I think
            %is is fine to use ...
            logger = epworks.parse.iom.logger();
            %TODO: Get from other logger
            logger.first_past_object_count = 1e5;
            logger.initializeObjectHolder();

            %History processing
            %-----------------------------------------------------------
            % % % % keyboard
            % % % % %Not finding anything in the history, why?
            % % % % n_entries = obj.p.history.n_entries;
            % % % % history_objs = cell(1,n_entries);
            % % % % for i = 1:n_entries
            % % % %     entry = obj.p.history.entries(i);
            % % % %     %Returns nothing
            % % % %     %history_objs{i} = logger.getObjectByID(entry.trace_id);
            % % % %     n_objects = entry.n;
            % % % %     id_objs = cell(1,n_objects);
            % % % %     for j = 1:n_objects
            % % % %         id_objs{j} = logger.getObjectByID(entry.IDs(j,:));
            % % % %         if ~isempty(id_objs{j})
            % % % %             keyboard
            % % % %         end
            % % % %     end
            % % % %     history_objs{i} = id_objs;
            % % % % end

            %Trace creation
            %--------------------------------------------------------------
            p_obj = obj.s.trace;
            temp_objs = cell(1,length(p_obj));
            for i = 1:length(p_obj)
                temp_objs{i} = epworks.objects.trace(obj.p,p_obj(i),logger);
            end
            obj.traces = [temp_objs{:}];

            %EEG Waveform creation
            %--------------------------------------------------------------
            p_obj = obj.s.eeg_waveform;
            if ~isempty(p_obj)
                temp_objs = cell(1,length(p_obj));
                for i = 1:length(p_obj)
                    temp_objs{i} = epworks.objects.eeg_waveform(obj.p,p_obj(i),logger);
                end
                obj.eeg_waveforms = [temp_objs{:}];
            end

            %Group creation
            %--------------------------------------------------------------
            p_obj = obj.s.group;
            n_groups = length(p_obj);
            temp_objs = cell(1,n_groups);
            for i = 1:n_groups
                temp_objs{i} = epworks.objects.group(obj.p,p_obj(i),logger);
            end
            obj.groups = [temp_objs{:}];

            %Set creation
            %--------------------------------------------------------------
            p_obj = obj.s.set;
            if ~isempty(p_obj)
                n_sets = length(p_obj);
                temp_objs = cell(1,n_sets);
                for i = 1:n_sets
                    temp_objs{i} = epworks.objects.set(obj.p,p_obj(i),logger);
                end
                obj.sets = [temp_objs{:}];
    
                set_numbers = [obj.sets.set_number];
                [~,I] = sort(set_numbers);
                obj.sets = obj.sets(I);
            end

            %Test creation
            %--------------------------------------------------------------
            p_obj = obj.s.test;
            temp_objs = cell(1,length(p_obj));
            for i = 1:length(p_obj)
                temp_objs{i} = epworks.objects.test(obj.p,p_obj(i),logger);
            end
            obj.tests = [temp_objs{:}];

            %Study creation
            %--------------------------------------------------------------
            p_obj = obj.s.study;
            temp_objs = cell(1,length(p_obj));
            for i = 1:length(p_obj)
                temp_objs{i} = epworks.objects.study(obj.p,p_obj(i),logger);
            end
            obj.studies = [temp_objs{:}];

            %Triggered Waveform creation
            %--------------------------------------------------------------
            p_obj = obj.s.triggered_waveform;
            if ~isempty(p_obj)
                temp_objs = cell(1,length(p_obj));
                for i = 1:length(p_obj)
                    temp_objs{i} = epworks.objects.triggered_waveform(obj.p,p_obj(i),logger);
                end
                obj.triggered_waveforms_unsorted = [temp_objs{:}];
            end

            %Freerun Waveform creation
            %--------------------------------------------------------------
            p_obj = obj.s.freerun_waveform;
            if ~isempty(p_obj)
                temp_objs = cell(1,length(p_obj));
                for i = 1:length(p_obj)
                    temp_objs{i} = epworks.objects.freerun_waveform(obj.p,p_obj(i),logger);
                end
                obj.freerun_waveforms = [temp_objs{:}];
            end

            %--------------------------------------------------------------
            %--------------------------------------------------------------
            %                   ID to object translation
            %--------------------------------------------------------------
            %  
            %   We want properties to point to "clean" objects, not the 
            %   parsed objects which are a bit more messy/raw. So on
            %   creation we populate IDs, instead of objects (as the 
            %   only objects we may have at the time are parsed), and
            %   then we go back after everything has been created 
            %   and replace the IDs with the more clean/finalized
            %   objects.
            %
            %   That's what we're doing here.
            logger.doObjectLinking();
            %--------------------------------------------------------------
            %--------------------------------------------------------------
            %--------------------------------------------------------------


            %epworks.objects.group
            obj.groups.processPostLinking(obj.tests(1),options);
            
            %epworks.objects.trace
            obj.traces.processPostLinking(obj.tests(1));

            obj.sets.processPostLinking();

            if ~isempty(obj.freerun_waveforms)
                obj.freerun_waveforms.processPostLinking();
            end

            if ~isempty(obj.eeg_waveforms)
                obj.eeg_waveforms.processPostLinking();
            end

            %Adding group name for triggered waveforms
            %--------------------------------------------------------------
            for i = 1:length(obj.triggered_waveforms_unsorted)
                obj.triggered_waveforms_unsorted(i).group_name = ...
                    obj.triggered_waveforms_unsorted(i).set.group_name;
            end

            %Place Triggered Waveforms in their correct set
            %--------------------------------------------------------------
            %   
            %   Note, this needs to be AFTER set post linking
            %
            %   epworks.objects.triggered_waveform
            %   epworks.objects.freerun_waveform
            %   epworks.objects.eeg_waveform

            %   TW: set, epworks.objects.triggered_waveform

            tw = obj.triggered_waveforms_unsorted;
            if ~isempty(tw)
                tw__set_number = [tw.set_number];
                tw__group_name = {tw.group_name};
    
                for i = 1:length(obj.sets)
                    mask = obj.sets(i).set_number == tw__set_number & ...
                        strcmp(obj.sets(i).group_name,tw__group_name);
                    if any(mask)
                        temp = tw(mask);
                        origin_y = [temp.origin_y];
                        [~,I] = sort(origin_y);
                        obj.sets(i).triggered_waveforms = temp(I);
                    end
                end
            end

            %Create set info for each group
            %--------------------------------
            %Ugh, look away ....
            obj.groups.processPostLinking2();

            %Slim down the triggered waveforms, grouping by trace
            %--------------------------------------------------------------
            %
            %   .triggered_waveforms_unsorted contains all TW for all sets
            %   and all groups. Often though I think you want to first
            %   narrow in on a specific set or trace. This helps with
            %   narrowing by trace. Above we narrowed by set (i.e.
            %   accessible in <this>.sets(<index>).triggered_waveforms

            if ~isempty(obj.triggered_waveforms_unsorted)
                tw_trace_ids = vertcat(obj.triggered_waveforms_unsorted.trace_id);
                [unique_tw_trace_ids,ia,ic] = unique(tw_trace_ids,'rows');

                n_unique = length(ia);
                tw_groups_cell = cell(n_unique,1);
                for i = 1:length(ia)

                    %Some debugging
                    %----------------------------------
                    mask = ismember(obj.p.unique_trace_ids_from_waveforms,unique_tw_trace_ids(i,:),'rows');
                    if any(mask)
                        obj.p.used_trace_ids(mask) = obj.p.used_trace_ids(mask) + 4;
                        %Also set in
                        %-----------
                        %epworks.objects.freerun_waveform   
                        %epworks.objects.eeg_waveform
                    end

                    %Creation of the group object
                    %-------------------------------------
                    tw_groups_cell{i} = epworks.objects.triggered_waveform_group(...
                        obj.triggered_waveforms_unsorted(i == ic));
    
                    temp = tw_groups_cell{i};
                    temp.group_name = temp.group_name;
                end
    
                obj.triggered_waveforms = [tw_groups_cell{:}];
            end

            %Linking of data to the traces
            %--------------------------------------------------------------
            %
            %   At this point we have data in:
            %   - triggered_waveforms
            %   - freerun_waveforms
            %   - eeg_waveforms

            if ~isempty(obj.triggered_waveforms)
                tw_trace_ids = vertcat(obj.triggered_waveforms.trace_id);
            end

            if ~isempty(obj.eeg_waveforms)
                eeg_trace_ids = vertcat(obj.eeg_waveforms.trace_id);
            end

            if ~isempty(obj.freerun_waveforms)
                fr_trace_ids = vertcat(obj.freerun_waveforms.trace_id);
            end
            
            trace_ids = vertcat(obj.traces.id);
            for i = 1:size(trace_ids,1)
                cur_trace_id = trace_ids(i,:);

                if ~isempty(obj.triggered_waveforms)
                    mask = ismember(tw_trace_ids,cur_trace_id,'rows');
                    if any(mask)
                        obj.traces(i).triggered_waveforms = obj.triggered_waveforms(mask);
                    end
                end

                if ~isempty(obj.freerun_waveforms)
                    mask = ismember(fr_trace_ids,cur_trace_id,'rows');
                    if any(mask)
                        if sum(mask) > 1
                            error('Assumption violated, see snippet_group code')
                        end
                        obj.traces(i).freerun_waveforms = obj.freerun_waveforms(mask);
                    end
                end

                if ~isempty(obj.eeg_waveforms)
                    mask = ismember(eeg_trace_ids,cur_trace_id,'rows');
                    if any(mask)
                        if sum(mask) > 1
                            error('Assumption violated, see snippet_group code')
                        end
                        obj.traces(i).eeg_waveforms = obj.eeg_waveforms(mask);
                    end
                end
            end

            %Group Info
            %----------------------------------------------------------
            groups = obj.groups;
            n_groups = length(groups);
            %TODO: Move this as method to group class
            index = (1:n_groups)';
            name = string({groups.name}');
            is_eeg = [groups.is_eeg_group]';
            state = [groups.state]';
            signal_type = [groups.signal_type]';
            sweeps_per_avg = [groups.sweeps_per_avg]';
            trigger_delay = [groups.trigger_delay]';
            n_sets = zeros(n_groups,1);
            n_traces = zeros(n_groups,1);
            has_free = zeros(n_groups,1);
            has_trig = zeros(n_groups,1);
            for i = 1:n_groups
                group = groups(i);
                n_sets(i) = length(group.sets);
                n_traces(i) = length(group.traces);
                traces = group.traces;
                for j = 1:length(traces)
                    trace = traces(j);
                    if ~isempty(trace.freerun_waveforms)
                        has_free(i) = has_free(i) + 1;
                    end
                    if ~isempty(trace.triggered_waveforms)
                        has_trig(i) = has_trig(i)+1;
                    end
                end
            end

            obj.group_info = table(index,name,n_sets,n_traces,...
                is_eeg,has_free,has_trig,state,signal_type,...
                sweeps_per_avg,trigger_delay);

            %TW Info
            %--------------------------------------------------------------
            %
            %   - name
            %   - group_name
            %   - n_sets
            %   

            if ~isempty(obj.triggered_waveforms)
                index = (1:length(obj.triggered_waveforms))';
                name = {obj.triggered_waveforms.name}';
                group_name = {obj.triggered_waveforms.group_name}';
                n_sets = [obj.triggered_waveforms.n_sets]';
    
                temp = table(index,name,group_name,n_sets);
    
                [temp2,I] = sortrows(temp,["group_name","name"]);
                obj.triggered_waveforms = obj.triggered_waveforms(I);
                obj.triggered_info = temp2;
                obj.triggered_info.index = (1:height(temp2))';
            end

            %Freerun Info
            %--------------------------------------------------------------
            %
            %   - name
            %   - group_name
            %   - n_snippets
            %

            if ~isempty(obj.freerun_waveforms)
                index = (1:length(obj.freerun_waveforms))';
                name = {obj.freerun_waveforms.name}';
                group_name = {obj.freerun_waveforms.group_name}';
                n_snippets = [obj.freerun_waveforms.n_snippets]';
    
                temp = table(index,name,group_name,n_snippets);
    
                [temp2,I] = sortrows(temp,["group_name","name"]);
                obj.freerun_waveforms = obj.freerun_waveforms(I);
                obj.freerun_info = temp2;
                obj.freerun_info.index = (1:height(temp2))';
            end


            %EEG Waveform Info
            %--------------------------------------------------------------
            %
            %   - name
            %   - group_name
            %   - n_snippets
            %

            index = (1:length(obj.eeg_waveforms))';
            name = {obj.eeg_waveforms.name}';
            group_name = {obj.eeg_waveforms.group_name}';
            n_snippets = [obj.eeg_waveforms.n_snippets]';

            temp = table(index,name,group_name,n_snippets);

            [temp2,I] = sortrows(temp,["group_name","name"]);
            obj.eeg_waveforms = obj.eeg_waveforms(I);
            obj.eeg_info = temp2;
            obj.eeg_info.index = (1:height(temp2))';


            %--------------------------------------------------------------

            obj.notes = epworks.objects.notes(obj.p,obj.studies);

        end
        function g = getGroup(obj,group_name)
            %
            %   g = getGroup(obj,group_name)
            %   
            
            %TODO: Support insensitive
            I = find(strcmpi(obj.group_info.name,group_name));
            if isempty(I)
                error('Group not found: requested: %s',group_name)
            end
            if length(I) > 1
                error('Multiple matches for group found: requested: %s',group_name)
            end
            g = obj.groups(I);
        end
    end
    
end

function info = h__getWaveformInfo(s)
    if isempty(s)
        info = table([], [], [], [], 'VariableNames', {'index', 'name', 't0','n_data'});
        return
    end

    index = (1:length(s))';
    name = string({s.name}');
    t0 = NaT(length(name),1);
    n_data = zeros(length(name),1);
    for i = 1:length(name)
        if ~isempty(s(i).data)
            t0(i) = s(i).data.t0(1);
            n_data(i) = length(s(i).data.data);
        end
    end

    info = table(index,name,t0,n_data);
end

