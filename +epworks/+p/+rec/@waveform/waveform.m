classdef waveform < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.rec.waveform
    %
    %   See Also
    %   --------
    %   epworks.parse.rec_parser

    properties
        first_100
        timestamp
        id
        data
        fs
        stim_amp
        %This is Jim trying to figure out some non-zero bytes
        b89
        b97
        b105
        b113
        b129
        b145
        b153
    end

    properties (Dependent)
        t_1
        t_end
    end

    methods
        function value = get.t_1(obj)
            value = obj.timestamp;
        end
        function value = get.t_end(obj)
            value = obj.timestamp + seconds((length(obj.data)-1)*1/obj.fs);
        end
    end

    methods
        function obj = waveform(i,data,default_length,trace,ochan,fs,tz_offset)
            obj.fs = fs;

            bytes = data';

            %Format
            %------
            %1:4 - # of bytes to read at a time
            %5:20 - id
            %21:28 - timestamp
            %
            %29:41 - empty
            %42 - value of 64 - is this a # of columns/rows thing?
            %45 - starts counting up, 1 through n
            %       - why start counting before a meaningful number
            %        at byte 46? What happens if we overflowed
            %
            %   for eeg_waveforms
            %46:48 - value of [202 154 59]
            %
            %   45:48 => 1E9+1
            %
            %   old code did the following words:
            %29:32 - uint32
            %33:36 - uint32
            %37:40 - uint32
            %       1 0 0 0 - triggered waveforms (TW)
            %41:44 - uint8
            %       0 8 0 0 - TW
            %45:48 - uint32
            %       58 0 0 0 - TW
            %49:52 - uint32
            %43:56 - uint32
            %57:60 - single, stim amp
            %
            %   first of anythign in this sample is 889
            %   - is this because there are just 0s for some amount
            %   of data?



            n_bytes_read = double(typecast(bytes(1:4),'int32'));
            if n_bytes_read ~= default_length
                error('Assumption violated')
            end
            obj.id = bytes(5:20);
            obj.timestamp = epworks.utils.processType3time(bytes(21:28));
            obj.timestamp = obj.timestamp + tz_offset;


            obj.stim_amp = double(typecast(bytes(57:60),'single'));

            obj.first_100 = bytes(1:250);

            obj.b89 = bytes(89:96);
            obj.b97 = typecast(bytes(97:104),'double');
            obj.b105 = typecast(bytes(105:112),'double');
            obj.b113 = typecast(bytes(113:120),'double');


            obj.b129 = bytes(129:144);
            obj.b145 = typecast(bytes(145:152),'double');
            obj.b153 = typecast(bytes(153:160),'double');

            %Skipping a 3rd block of non-zero bytes

            %TW:
            %Showing 

            %892 - first non-zero sample
            %
            %   ? How do we determine this from the data?
            obj.data = double(typecast(bytes(889:end),'single'));
            %obj.data = data(89:end);

            %{
                d1 = data(121:end);
                d2 = data(889:end);
                    %10 - yes

            12:57:44 to 13:18:23 - 1109 seconds
            ~19.46 seconds
    
            4 seconds, 2400

            %2400 samples
            d2 = double(typecast(bytes(889:end),'single'));


            d3 = double(typecast(bytes(89:end),'double'));
            d4 = double(typecast(bytes(89:end),'int16'));
            d5 = bytes(889:end);
            %}
        end
    end
end