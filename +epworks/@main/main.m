classdef main < epworks.RNEL.handle_light
    %
    %   Class:
    %   epworks.main
    %
    %   This is the new main class for accessing data.
    
    properties
        p
        s
        traces
        eeg_waveforms
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
            

            p_eeg = obj.s.trace;
            temp_objs = cell(1,length(p_eeg));
            for i = 1:length(p_eeg)
                temp_objs{i} = epworks.objects.trace(obj.p,p_eeg(i),logger);
            end

            obj.traces = [temp_objs{:}];

            p_eeg = obj.s.eeg_waveform;
            temp_objs = cell(1,length(p_eeg));
            for i = 1:length(p_eeg)
                temp_objs{i} = epworks.objects.eeg_waveform(obj.p,p_eeg(i),logger);
            end
            
            obj.eeg_waveforms = [temp_objs{:}];
            
            logger.doObjectLinking();

            for i = 1:length(obj.eeg_waveforms)
                w = obj.eeg_waveforms(i);
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

