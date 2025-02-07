classdef main < epworks.RNEL.handle_light
    %
    %   Class:
    %   epworks.main
    %
    %   This is the new main class for accessing data.
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
    properties
        p
        s
        traces
        groups
        tests
        eeg_waveforms
        triggered_waveforms
        freerun_waveforms

        %Not yet exposed - these are parsed

        %patien
        %study
    end
    
    properties

    end
    
    properties
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
            

            p_obj = obj.s.trace;
            temp_objs = cell(1,length(p_obj));
            for i = 1:length(p_obj)
                temp_objs{i} = epworks.objects.trace(obj.p,p_obj(i),logger);
            end
            obj.traces = [temp_objs{:}];

            p_obj = obj.s.eeg_waveform;
            temp_objs = cell(1,length(p_obj));
            for i = 1:length(p_obj)
                temp_objs{i} = epworks.objects.eeg_waveform(obj.p,p_obj(i),logger);
            end
            obj.eeg_waveforms = [temp_objs{:}];

            p_obj = obj.s.group;
            temp_objs = cell(1,length(p_obj));
            for i = 1:length(p_obj)
                temp_objs{i} = epworks.objects.group(obj.p,p_obj(i),logger);
            end
            obj.groups = [temp_objs{:}];

            p_obj = obj.s.test;
            temp_objs = cell(1,length(p_obj));
            for i = 1:length(p_obj)
                temp_objs{i} = epworks.objects.test(obj.p,p_obj(i),logger);
            end
            obj.tests = [temp_objs{:}];
            
            p_obj = obj.s.triggered_waveform;
            temp_objs = cell(1,length(p_obj));
            for i = 1:length(p_obj)
                temp_objs{i} = epworks.objects.triggered_waveform(obj.p,p_obj(i),logger);
            end
            obj.triggered_waveforms = [temp_objs{:}];

            p_obj = obj.s.freerun_waveform;
            temp_objs = cell(1,length(p_obj));
            for i = 1:length(p_obj)
                temp_objs{i} = epworks.objects.freerun_waveform(obj.p,p_obj(i),logger);
            end
            obj.freerun_waveforms = [temp_objs{:}];
            
            logger.doObjectLinking();

            %This needs to be done after linking since the linking
            %trades the ID for the created object
            for i = 1:length(obj.eeg_waveforms)
                w = obj.eeg_waveforms(i);
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

