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
    %   TODO: Move this into p
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
        orphaned_rec_files = false
        orphaned_indices
        rec_file_info

        tst_data

        notes

        logger
    end

    methods
        function obj = main(study_path_or_iom_path)
            %
            %   Inputs
            %   ------
            %   

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
                temp = epworks.parse.rec_parser(...
                    all_rec_files{iRec},obj.iom.logger,tz_offset);
                if temp.is_trace_orphan
                    obj.orphaned_rec_files = true;
                end
                rec_files_cell{iRec} = temp;
            end
            
            obj.rec_files = [rec_files_cell{:}]; 

            if obj.orphaned_rec_files
                obj.orphaned_indices = find([obj.rec_files.is_trace_orphan]);
            end

            name = string({obj.rec_files.name}');
            time = ([obj.rec_files.file_timestamp])';
            n_rec = length(obj.rec_files);
            n_entries = zeros(n_rec,1);
            n_merged = zeros(n_rec,1);
            for i = 1:n_rec
                n_entries(i) = length(obj.rec_files(i).waveforms);
                n_merged(i) = length(obj.rec_files(i).merged_waveforms);
            end

            obj.rec_file_info = table(name,time,n_entries,n_merged);

            %Notes parsing
            %----------------------------------------------------------
            obj.notes = epworks.parse.notes_parser(...
                obj.file_manager.notes_file_path);

            obj.logger = obj.iom.logger;

            %Things not parsed
        end
    end
end