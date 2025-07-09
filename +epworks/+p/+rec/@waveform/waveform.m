classdef waveform < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.rec.waveform
    %
    %   See Also
    %   --------
    %   epworks.parse.rec_parser
    %
    %   Format
    %   ------
    %   - see notes in code

    properties
        file_id
        loop_id
        trace_id
        ochan_id
        all_bytes
        first_888
        timestamp
        id
        data
        fs = NaN
        
        %This is Jim trying to figure out some non-zero bytes
        %89:96
        timestamp2 %Note, for TW this doesn't make sense. Perhaps it
        %means something different for TW entries?
        t2_bytes

        b29
        b33
        b37
        b41
        b45
        b49

        %53:56
        n_cursors
        
        %57:60 - for some reason this doesn't always have a good value
        stim_amp

        b65

        
        b89


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
        function obj = waveform(i,data,default_length,trace,ochan,fs,tz_offset,file_i)
            %
            %
            %   Inputs
            %   ------
            %   i : 
            %       Loop ID from the parent
            %
            %   See Also
            %   --------
            %   epworks.parse.rec_parser

            obj.file_id = file_i;
            obj.loop_id = i;
            if ~isempty(trace)
                obj.trace_id = trace.id;
            else
                obj.trace_id = zeros(1,16,'uint8');
            end

            if ~isempty(ochan)
                obj.ochan_id = ochan.id;
            else
                obj.ochan_id = zeros(1,16,'uint8');
            end
            
            obj.fs = fs;

            bytes = data';

            obj.all_bytes = bytes;

            %Format
            %------
            %1:4 - # of bytes to read at a time
            %5:20 - id
            %
            %   When I tried to log this it matched something - this
            %   matches the triggered_waveform objects, but only in 
            %   some cases.
            %
            %21:28 - timestamp
            %
            %29:32 - uint32
            %
            %33:36 - uint32
            %
            %37:40 - uint32
            %       0 0 0 0 - this occurs for EEG Waveforms
            %       
            %       1 0 0 0 - triggered waveforms (TW)
            %           - note, this is not exclusive to TW
            %
            %       ****** With only a few exceptions, this indicates if 
            %       there is anything that comes after byte 48
            %
            %41:44 - uint8 - is this something with bit resolution?
            %              - is this a decimation factor on the clock?
            %              - note, no row has a zero here
            %
            %       0 8 0 0   - 2048
            %       0 16 0 0  - 4096
            %       0 64 0 0  - 16384
            %       0 128 0 0 - 32768
            %
            %       0 8 0 0
            %       0 8 1 0
            %       0 16 0 0 
            %
            %45:48 - uint32 
            %       - This seems to be some sort of counter
            %       - The rate of counting depends on 41:44
            %       - 
            %       - this is set_number for TW
            %       - starts at 1E9 for EEG waveforms
            %       - diff is only 2 for EEG Raw
            %       
            %   
            %49:52 - uint32 - always 0
            %       
            %53:56 - uint32
            %           - unclear why each value occurs
            %           - ??? What is this for 37
            %           - non-zero only occurs if 37 is 1
            %           - zero row occurs for both 0 and 1 for 37
            %           - I wonder if this is # of peaks?
            %
            %       0 0 0 0 
            %       1 0 0 0
            %       2 0 0 0
            %       3 0 0 0
            %
            %57:60 - single, stim amp **** KNOWN *****
            %
            %61:64 - always 0
            %
            %65:68
            %       0 0 0 0 - most common
            %       1 0 0 0 - occasional
            %
            %69:72: 
            %       0   0   0   0   - no more info until data
            %       255 255 255 255 - when more info present
            %
            %73:88 = always 0
            %
            %   It is unclear how to know if we should expect values here
            %   or not, and if so, how many to expect.
            %
            %   In some cases the format seems to be:
            %       - 16 bytes (unknown format)
            %       - 8 byte double
            %       - 8 byte double
            %       - repeats
            %
            %
            % 89:104 not a double, a 16 byte value? two 8 byte values?
            %       I could not find any ID info, but I am not sure I
            %       looked that hard (e.g., try and find this string in the
            %       iom raw byte data)
            %
            %       **** In one case 89:96 is a timestamp (not sure if that
            %       is for eeg or what)
            %
            %       In the below examples I think n indicates how many
            %       impossibly large double values were observed. Thus 
            %       a low n indicates it is probably a double (with some
            %       sort of conditional as to whether or not to use the
            %       value),
            %
            % 105:112, n=13 (likely a double)
            % 113:120, n=36 (likely a double)
            % 121:128, n=2  (likely a double)
            % 129:136, n=16210
            % 137:144, n=9080
            % 145:152, n=4  (likely a double, matching 105?)
            % 153:160, n=5  (likely a double ....
            % 161:168, n=1  ...
            % 169:176, n=3131
            % 177:184, n=2388
            % 185:192, n=25
            % 193:200, n=24
            % 201:208, n=2
            %
            %   first of anything in this sample is 889
            %   - is this because there are just 0s for some amount
            %   of data?



            n_bytes_read = double(typecast(bytes(1:4),'int32'));
            if n_bytes_read ~= default_length
                error('Assumption violated')
            end
            obj.id = bytes(5:20);
            obj.timestamp = epworks.utils.processType3time(bytes(21:28));
            obj.timestamp = obj.timestamp + tz_offset;

            obj.b29 = bytes(29:32);
            obj.b33 = bytes(33:36);
            obj.b37 = double(typecast(bytes(37:40),'uint32'));
            obj.b41 = double(typecast(bytes(41:44),'uint32'));
            obj.b45 = double(typecast(bytes(45:48),'uint32'));
            obj.b49 = bytes(49:52);
            obj.n_cursors = bytes(53:56);
            obj.stim_amp = double(typecast(bytes(57:60),'single'));
            %61:64 - always 0
            obj.b65 = typecast(bytes(65:68),'uint32');


            

            obj.first_888 = bytes(1:888);

            %obj.b89 = bytes(89:96);
            obj.timestamp2 = epworks.utils.processType3time(bytes(89:96));
            obj.t2_bytes = bytes(89:96);

            %obj.b89 = bytes(89:104);

            %obj.b_unknown = bytes(97:160);

            obj.b105 = typecast(bytes(105:112),'double');
            obj.b113 = typecast(bytes(113:120),'double');

            %Shoot, is this is timestamp?
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
        function merged_waveforms = getMerged(objs)

            %UNKNOWN: Can we tell types
            %
            %   I think at this point we could if we passed in the IOM
            %   parsing which happens before this.
            %
            %   Although I'm not sure how to get the parent object for
            %   each waveform. I guess that is in trace and ochan
            %   properties.
            %
            %
            %TODO: We could probably omit this for triggered waveforms
            %
            %   This IS needed for eeg_waveforms
            %
            %   Note, this is an attempt to stich multiple waveforms
            %   together into one waveform based on the gap in time between
            %   the end of one set of data and the start of the next

            n_waveforms = length(objs);
            all_fs = [objs.fs];
            if ~all(all_fs == all_fs(1))
                error('assumption violated')
            end

            fs = all_fs(1);

            CUTOFF_RATIO = 1;
            dt = 1/fs;
            is_start = false(1,n_waveforms);
            is_start(1) = true;
            is_stop = false(1,n_waveforms);
            is_stop(end) = true;
            for i = 1:(n_waveforms-1)
                %current waveform
                w1 = objs(i);
                t1 = w1.t_end;

                %next waveform
                w2 = objs(i+1);
                t2 = w2.t_1;

                %How much time is between the first sample in the next
                %waveform AND the last sample in the current waveform?
                %
                %How close is it to dt (time between samples)

                delta_time = abs(seconds(t2-t1) - dt);
                %JAH TODO: Why is this not <= 
                if delta_time/dt < CUTOFF_RATIO
                    %continue
                else
                    is_stop(i) = true;
                    is_start(i+1) = true;
                end
            end

            I1 = find(is_start);
            I2 = find(is_stop);
            n_merged = length(I1);
            merged_all = cell(1,n_merged);
            for i = 1:n_merged
                waves_use = objs(I1(i):I2(i));
          
                %merged_ids = vertcat(waves_use.id);
                %row_same = all(merged_ids == merged_ids(1,:), 2);  % logical vector

                %if ~all(row_same)
                %    error('Unexpected result, code needs to be fixed ...')
                %end
                merged_all{i} = epworks.p.rec.merged_waveform(waves_use);
            end

            merged_waveforms = [merged_all{:}];
        end
    end
end