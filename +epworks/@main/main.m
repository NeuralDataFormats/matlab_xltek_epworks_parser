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

    %   Questions
    %   ---------
    %   1) Lots of unknowns with the rec parser (in particular fs, see
    %   file)
    %   2) Where is the local offset time stored?

    properties
        
        p %Parsed information epworks.parse.main

        s %This is a structure that holds all of the top level parsed
        %objects.

        traces
        groups
        group_info
        sets
        tests
        studies
        eeg_waveforms
        eeg_waveforms_info
        
        triggered_waveforms
        triggered_info

        freerun_waveforms
        freerun_info

        notes

        %Not yet exposed - these are parsed

        %patien
        %study
    end
    
    methods
        function obj = main(study_name_or_path)
            
            if nargin == 0
                study_name_or_path = '';
            end

            obj.p = epworks.parse.main(study_name_or_path);
            obj.s = obj.p.iom.s2;
            
            %I don't like where this object lives but I think
            %is is fine to use ...
            logger = epworks.parse.iom.logger();
            %TODO: Get from other logger
            logger.first_past_object_count = 1e5;
            logger.initializeObjectHolder();


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

            %TODO: Move this as method to group class
            index = (1:n_groups)';
            name = string({obj.groups.name}');
            is_eeg_group = [obj.groups.is_eeg_group]';
            state = [obj.groups.state]';
            signal_type = [obj.groups.signal_type]';
            sweeps_per_avg = [obj.groups.sweeps_per_avg]';
            trigger_delay = [obj.groups.trigger_delay]';
            n_sets = zeros(n_groups,1);
            n_traces = zeros(n_groups,1);
            for i = 1:n_groups
                n_sets(i) = length(obj.groups(i).sets);
                n_traces(i) = length(obj.groups(i).traces);
            end

            obj.group_info = table(index,name,n_sets,n_traces,is_eeg_group,state,signal_type,sweeps_per_avg,trigger_delay);

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
            logger.doObjectLinking();

            %After linking processing
            %--------------------------------------------------------------
            %Note, I'm currently assuming only 1 test ...
            %ASSUMPTION
            obj.groups.processPostLinking(obj.tests(1));
            
            obj.traces.processPostLinking();


            %Getting info ....

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

            s = obj.triggered_waveforms;    

            keyboard


            obj.notes = epworks.objects.notes(obj.p,obj.studies);


            %Old code at this point ...
            %--------------------------------------------------------------
            
            
            
            %tst files
            %---------------------------------------------------------------
            %This looks redundant with the iom file ...
% % % %             tst_file_paths = file_manager.tst_file_paths;
% % % %             n_tst = length(tst_file_paths);
% % % %             
% % % %             tst_all = cell(1,n_tst);
% % % %             for iTST = 1:n_tst
% % % %                 tst_all{iTST} = epworks.tst_parser(tst_file_paths{iTST});
% % % %             end
% % % %             
% % % %             tst = [tst_all{:}];
% % % %             a = [tst.all_objects_out];
% % % %             
% % % %             all_full_names = [a.full_name]';
% % % %             u_full = unique(all_full_names);
%             keyboard
        end
    end
    
end

