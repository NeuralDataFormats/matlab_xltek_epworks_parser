classdef main < handle
    %
    %   Class:
    %   epworks.parse.main
    %
    %   This is the top level object for parsing. Note this is quite raw
    %   compared to epworks.main which wraps this a bit nicer.
    %
    %   Things not parsed
    %   -----------------
    %   - Trenading.dat (in main folder)
    %   - *.TST files in the sub-folders of history (1 per sub-folder?)
    %   - *.SPT files in the sub-folders of history (1 per sub-folder?)
    %
    %   See Also
    %   --------
    %   epworks.main
    %   epworks.file_manager
    %   epworks.parse.rec_parser
    %
    %   
    %   Files
    %   -----
    %   iom - config files
    %       History folder
    %           01,08,2025_12'53'01.01DB61F628E85AEA
    %
    %

    properties
        file_manager epworks.parse.file_manager
        
        iom

        %Not sure how this is useful ...
        %
        %Still need to match IDs 
        history

        %TODO: Eventually may be nice to show rec files in their
        %original folder, right now we merge at the start so we would 
        %need to track which folder each one comes from
        %rec_files_by_folder

        rec_files

        all_waveforms
        waveform_ids
        
        null_id_present = false
        %These two are aligned.
        %
        %   This first one comes from the REC files
        unique_trace_ids_from_waveforms

        %TODO: Document this ...
        waveform_trace_groups

        orphaned_rec_files = false
        
        orphaned_indices %These are the indices of the .REC files with no 
        % trace object. You can index into .rec_files based on these
        % indices.

        rec_file_info

        tst_data

        notes

        logger

        unhandled_iom_props
    end

    methods
        function obj = main(study_path_or_iom_path,show_rec_progress)
            %
            %   Inputs
            %   ------
            %   
            %
            %   See Also
            %   --------
            %   epworks.main

            %A study consists of multiple files. The file manager
            %takes care of knowing where those files are
            obj.file_manager = epworks.parse.file_manager(study_path_or_iom_path);

            obj.iom = epworks.parse.iom_parser(obj.file_manager.iom_file_path);

            obj.history = epworks.parse.history_dat_parser(...
                obj.file_manager.history_dat_path,obj.iom.logger);

            %TST files
            %--------------------------------------------------------------
            %
            %   This seems to be a copy of the settings but for each
            %   specific history folder.
            %
            %   Eventually it would be good to compare these to the IOM. It
            %   is possible that it would be better to use this instead.
            %

            tst_paths = obj.file_manager.tst_file_paths;
            n_tst = length(tst_paths);
            tst_data = cell(1,n_tst);
            for i = 1:length(tst_data)
                tst_data{i} = epworks.parse.tst_parser(tst_paths{i});
            end
            obj.tst_data = [tst_data{:}];


            %SPT files
            %--------------------------------------------------------------
            % % spt_paths = [obj.file_manager.spt_file_paths{:}];
            % % n_spt_files = length(spt_paths);
            % % spt_data = cell(1,n_spt_files);
            % % for i = 1:length(tst_data)
            % %     spt_data{i} = epworks.parse.spt_parser(spt_paths{i},obj.iom.logger);
            % % end
            % % keyboard


            %Rec file 
            %--------------------------------------------------------------
            all_rec_files = [obj.file_manager.rec_file_paths{:}];

            n_rec_files = length(all_rec_files);
            
            rec_files_cell = cell(1,n_rec_files);
            
            tz_offset = obj.iom.s2.study(1).data.tz_offset;
            for iRec = 1:n_rec_files
                if show_rec_progress
                    fprintf('%d/%d\n',iRec,n_rec_files);
                end
                temp = epworks.parse.rec_parser(...
                    all_rec_files{iRec},obj.iom.logger,tz_offset,iRec,...
                    obj.iom.bytes);
                if temp.is_trace_orphan
                    obj.orphaned_rec_files = true;
                end
                rec_files_cell{iRec} = temp;
            end
            
            obj.rec_files = [rec_files_cell{:}]; 

            obj.all_waveforms = [obj.rec_files.waveforms];
            obj.waveform_ids = vertcat(obj.all_waveforms.id);

            %Grouping of waveforms by trace
            %--------------------------------------------------------
            all_trace_ids = vertcat(obj.all_waveforms.trace_id);
            [unique_trace_ids,ia,ic] = unique(all_trace_ids,"rows");
            obj.unique_trace_ids_from_waveforms = unique_trace_ids;
            %This is the null ID we added for missing traces
            %
            %   If true, remove the first row
            if all(unique_trace_ids(1,:) == 0)
                start_I = 2;
                obj.null_id_present = true;
                obj.unique_trace_ids_from_waveforms = ...
                    obj.unique_trace_ids_from_waveforms(2:end,:);
            else
                start_I = 1;
                obj.null_id_present = false;
            end
            n_unique = length(ia);
            trace_groups = cell(1,n_unique);
            for i = start_I:n_unique
                w_for_trace = obj.all_waveforms(ic == i);
                %This merges the waveforms
                trace_groups{i} = epworks.p.rec.waveform_trace_group(w_for_trace);
            end

            obj.waveform_trace_groups = [trace_groups{:}];

            %Log orphaned rec files prop
            %------------------------------------------------------------
            if obj.orphaned_rec_files
                obj.orphaned_indices = find([obj.rec_files.is_trace_orphan]);
            end

            name = string({obj.rec_files.name}');
            time = ([obj.rec_files.file_timestamp])';
            n_rec = length(obj.rec_files);
            n_entries = zeros(n_rec,1);
            for i = 1:n_rec
                n_entries(i) = length(obj.rec_files(i).waveforms);
            end

            obj.rec_file_info = table(name,time,n_entries);

            %Notes parsing
            %----------------------------------------------------------
            obj.notes = epworks.parse.notes_parser(...
                obj.file_manager.notes_file_path);

            obj.logger = obj.iom.logger;

            %Unhandled props
            %------------------------------------------------
            obj.unhandled_iom_props = obj.logger.unhandled_props;
        end
        function wtg = getWaveformTraceGroupFromTraceID(obj,trace_id)
            mask = ismember(obj.unique_trace_ids_from_waveforms,trace_id,'rows');
            wtg = obj.waveform_trace_groups(mask);

        end
    end
end