classdef spt_parser < handle
    %
    %   Class:
    %   epworks.parse.spt_parser
    %
    %   Maybe something spectral?
    %
    %   Not sure how to parse the binary data?

    properties
        b16_1
        t1
        b16_2
    end

    methods
        function obj = spt_parser(file_path,logger)
            if isempty(file_path)
                return
            end
            r = epworks.sl.io.fileRead(file_path,'*uint8');
            % 53431
            % 56091
            % 58751

            %Example times to look for times in this file
            %
            %type 3: 16-Oct-2021 12:27:02
            %43    93   236    29    64   199   215     1
            %type 1: 22-Oct-2021 13:05:00
            %114    28   199   113   113   185   229    64

            obj.b16_1 = r(1:16);
            obj.t1 = epworks.utils.processType3time(r(21:28));
            obj.b16_2 = r(29:44);
            
            %97:100 - 2660 - spacing between each
            %
            %   this seems to be repeated

            remaining_data = r(97:end);
            n_bytes_per = double(typecast(remaining_data(1:4),'uint32'));

            % imagesc(reshape(remaining_data,n_bytes_per,727));

            n_entries = length(remaining_data)/n_bytes_per;
            data = reshape(remaining_data,n_bytes_per,n_entries);

            %1:4 - n_bytes_total (or next)
            %5:20 - 16 bytes - ID?
            %21:28 - time1
            time1 = NaT(n_entries,1);
            time2 = NaT(n_entries,1);
            time3 = NaT(n_entries,3);
            for i = 1:n_entries
                time1(i) = epworks.utils.processType3time(data(21:28,i)');
                time2(i) = epworks.utils.processType3time(data(89:96,i)');
                time3(i) = epworks.utils.processType3time(data(97:104,i)');
                temp_data = data(165:784,i)';
                temp_data = data(165:end,i)';
                wtf = typecast(temp_data,'single');
                plot(wtf)
                title(sprintf('%d',i));
                pause
            end



            %122
            %190
            %198
            %2782
            
            % % remaining_data = r(21:28);
            % % remaining_data(1:5) = 0;
            %First 20 bytes, unknown
            %1:16
            %t1 = 

            %2660


            
        end
    end
end