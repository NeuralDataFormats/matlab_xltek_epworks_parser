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
    %   patient
    %     study
    %       test
    %         group
    %           trace
    %             eeg_waveform
    %             triggered_waveform
    %             freerun_waveform
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

    properties (Hidden)
        s %This is a structure that holds all of the top level parsed
        %objects.

        triggered_waveforms_unsorted
        %sets_unsorted
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
            end
            
            if nargin == 0
                study_path_or_iom_path = '';
            end

            obj.p = epworks.parse.main(study_path_or_iom_path);
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
            temp_objs = cell(1,length(p_obj));
            for i = 1:length(p_obj)
                temp_objs{i} = epworks.objects.eeg_waveform(obj.p,p_obj(i),logger);
            end
            obj.eeg_waveforms = [temp_objs{:}];

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
            n_sets = length(p_obj);
            temp_objs = cell(1,n_sets);
            for i = 1:n_sets
                temp_objs{i} = epworks.objects.set(obj.p,p_obj(i),logger);
            end
            obj.sets = [temp_objs{:}];

            set_numbers = [obj.sets.set_number];
            [~,I] = sort(set_numbers);
            obj.sets = obj.sets(I);

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
            temp_objs = cell(1,length(p_obj));
            for i = 1:length(p_obj)
                temp_objs{i} = epworks.objects.triggered_waveform(obj.p,p_obj(i),logger);
            end
            obj.triggered_waveforms_unsorted = [temp_objs{:}];

            %Freerun Waveform creation
            %--------------------------------------------------------------
            p_obj = obj.s.freerun_waveform;
            temp_objs = cell(1,length(p_obj));
            for i = 1:length(p_obj)
                temp_objs{i} = epworks.objects.freerun_waveform(obj.p,p_obj(i),logger);
            end
            obj.freerun_waveforms = [temp_objs{:}];

            %No match with the waveform IDs
            % free_ids = vertcat(obj.freerun_waveforms.id);
            % [mask3,loc3] = ismember(free_ids,obj.p.merged_waveform_ids,'rows');
            % [mask4,loc4] = ismember(free_ids,obj.p.waveform_ids,'rows');

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
            obj.traces.processPostLinking();

            obj.sets.processPostLinking();

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

            tw__set_number = [tw.set_number];
            tw__group_name = {tw.group_name};

            for i = 1:length(obj.sets)
                mask = obj.sets(i).set_number == tw__set_number & ...
                    strcmp(obj.sets(i).group_name,tw__group_name);
                if any(mask)
                    obj.sets(i).triggered_waveforms = tw(mask);
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
            %   narrowing by trace. Above we narrowed by set.
            
            tw_trace_ids = vertcat(obj.triggered_waveforms_unsorted.trace_id);
            [~,ia,ic] = unique(tw_trace_ids,'rows');
            n_unique = length(ia);
            tw_groups_cell = cell(n_unique,1);
            for i = 1:length(ia)
                tw_groups_cell{i} = epworks.objects.triggered_waveform_group(...
                    obj.triggered_waveforms_unsorted(i == ic));

                temp = tw_groups_cell{i};
                temp.group_name = temp.group_name;
            end

            obj.triggered_waveforms = [tw_groups_cell{:}];

            %Linking of data to the traces
            %--------------------------------------------------------------
            %
            %   At this point we have data in:
            %   - triggered_waveforms
            %   - freerun_waveforms
            %   - eeg_waveforms

            tw_trace_ids = vertcat(obj.triggered_waveforms.trace_id);
            eeg_trace_ids = vertcat(obj.eeg_waveforms.trace_id);
            fr_trace_ids = vertcat(obj.freerun_waveforms.trace_id);
            trace_ids = vertcat(obj.traces.id);
            for i = 1:size(trace_ids,1)
                cur_trace_id = trace_ids(i,:);
                mask = ismember(tw_trace_ids,cur_trace_id,'rows');
                if any(mask)
                    obj.traces(i).triggered_waveforms = obj.triggered_waveforms(mask);
                end

                mask = ismember(fr_trace_ids,cur_trace_id,'rows');
                if any(mask)
                    obj.traces(i).freerun_waveforms = obj.freerun_waveforms(mask);
                end

                mask = ismember(eeg_trace_ids,cur_trace_id,'rows');
                if any(mask)
                    obj.traces(i).eeg_waveforms = obj.eeg_waveforms(mask);
                end
            end



            %Need to align by:
            %1) Set #
            %2) Group ID





            %After linking processing
            %--------------------------------------------------------------
            %Note, I'm currently assuming only 1 test ...
            %ASSUMPTION
            


            %Some additional info population
            %
            %   Note, if we rearrange things we should update this as
            %   the tables show index order.

            %TODO: Move this back into this parent class, too hidden
            %obj.info = epworks.main.table_info(obj);


            %Info
            %---------------------------------------------------------

            %Group Info
            %----------------------------------------------------------
            groups = obj.groups;
            n_groups = length(groups);
            %TODO: Move this as method to group class
            index = (1:n_groups)';
            name = string({groups.name}');
            is_eeg_group = [groups.is_eeg_group]';
            state = [groups.state]';
            signal_type = [groups.signal_type]';
            sweeps_per_avg = [groups.sweeps_per_avg]';
            trigger_delay = [groups.trigger_delay]';
            n_sets = zeros(n_groups,1);
            n_traces = zeros(n_groups,1);
            for i = 1:n_groups
                n_sets(i) = length(groups(i).sets);
                n_traces(i) = length(groups(i).traces);
            end

            obj.group_info = table(index,name,n_sets,n_traces,is_eeg_group,state,signal_type,sweeps_per_avg,trigger_delay);

            % % obj.triggered_info = h__getWaveformInfo(obj.triggered_waveforms);
            % % obj.freerun_info = h__getWaveformInfo(obj.freerun_waveforms);
            % % obj.eeg_info = h__getWaveformInfo(obj.eeg_waveforms);

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

