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
    end

    properties
        
        p %Parsed information epworks.parse.main

        info
        traces
        groups
        sets
        tests
        studies
        eeg_waveforms
        triggered_waveforms
        freerun_waveforms

        notes

        %Not yet exposed - these are parsed
        % - patient
        %
        % - cursors - I found one file where the IDs were not unique
    end
    
    methods
        function obj = main(study_path_or_iom_path)
            
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
            obj.triggered_waveforms = [temp_objs{:}];

            %Freerun Waveform creation
            %--------------------------------------------------------------
            p_obj = obj.s.freerun_waveform;
            temp_objs = cell(1,length(p_obj));
            for i = 1:length(p_obj)
                temp_objs{i} = epworks.objects.freerun_waveform(obj.p,p_obj(i),logger);
            end
            obj.freerun_waveforms = [temp_objs{:}];

            %ID to object translation
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

            %After linking processing
            %--------------------------------------------------------------
            %Note, I'm currently assuming only 1 test ...
            %ASSUMPTION
            obj.groups.processPostLinking(obj.tests(1));
            
            obj.traces.processPostLinking();

            %This needs to be done after linking since the linking
            %trades the ID for the created object
            for i = 1:length(obj.eeg_waveforms)
                w = obj.eeg_waveforms(i);
                %Moving the trace data to the parent data for easier access
                w.data = w.trace.data;
            end

            for i = 1:length(obj.triggered_waveforms)
                w = obj.triggered_waveforms(i);
                w.data = w.trace.data;
            end

            for i = 1:length(obj.freerun_waveforms)
                w = obj.freerun_waveforms(i);
                w.data = w.trace.data;
            end

            %Some additional info population
            %
            %   Note, if we rearrange things we should update this as
            %   the tables show index order.
            obj.info = epworks.main.table_info(obj);

            obj.notes = epworks.objects.notes(obj.p,obj.studies);

        end
    end
    
end

