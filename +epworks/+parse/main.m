classdef main < handle
    %
    %   Class:
    %   epworks.parse.main
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
        file_manager
        
        iom

        rec_files
    end

    methods
        function obj = main(study_name_or_path)

            %A study consists of multiple files. The file manager
            %takes care of knowing where those files are
            obj.file_manager = epworks.file_manager(study_name_or_path);

            obj.iom = epworks.parse.iom_parser(obj.file_manager.iom_file_path);
            
            %Rec file 
            %--------------------------------------------------------------
            %
            %   Note, the rec files contain the timestamp in human
            %   readable form, followed by machine readable ...
            %
            %   01,08,2025_12'53'01.01DB61F628E85AEA
            %
            %   -> convert 2nd half from hex to decimal then
            %      use type3 time
            %   temp = typecast(uint64(hex2dec('01DB61F628E85AEA')),'uint8');
            %   time = epworks.utils.processType3time(temp);
            %
            %   ??? Where is UTC offset stored?
            %       - getting UTC
            %       - program is showing local, how?
            %           - is it my local, or Pitt local?

            s = obj.iom.s2;

            keyboard

            all_rec_files = [obj.file_manager.rec_file_paths{:}];
            
            n_rec_files = length(all_rec_files);
            
            rec_files_cell = cell(1,n_rec_files);
            
            for iRec = 1:n_rec_files
                rec_files_cell{iRec} = epworks.parse.rec_parser(all_rec_files{iRec});
            end
            
            obj.rec_files = [rec_files_cell{:}];
            %--------------------------------------------------------------
            clf
            hold on
            for i = 1:length(obj.rec_files)
                plot(obj.rec_files(i).all_data)
            end
            hold off


            keyboard

        end
    end
end