classdef main < handle
    %
    %   Class:
    %   epworks.parse.main
    %
    %   This is the top level object for parsing.
    %
    %   See Also
    %   --------
    %   epworks.main
    %
    %   Main parser
    %
    %   Moving things out of main, 
    %
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
        file_manager epworks.file_manager
        
        iom

        %Not sure how this is useful ...
        %
        %Still need to match IDs 
        history

        rec_files

        notes
    end

    methods
        function obj = main(study_name_or_path)

            %A study consists of multiple files. The file manager
            %takes care of knowing where those files are
            obj.file_manager = epworks.file_manager(study_name_or_path);

            obj.iom = epworks.parse.iom_parser(obj.file_manager.iom_file_path);

            obj.history = epworks.parse.history_dat_parser(...
                obj.file_manager.history_dat_path,obj.iom.logger);

            %Rec file 
            %--------------------------------------------------------------

            all_rec_files = [obj.file_manager.rec_file_paths{:}];
            
            n_rec_files = length(all_rec_files);
            
            rec_files_cell = cell(1,n_rec_files);
            
            for iRec = 1:n_rec_files
                rec_files_cell{iRec} = epworks.parse.rec_parser(all_rec_files{iRec},obj.iom.logger);
            end
            
            obj.rec_files = [rec_files_cell{:}]; 

            obj.notes = epworks.parse.notes_parser(...
                obj.file_manager.notes_file_path);
        end
    end
end