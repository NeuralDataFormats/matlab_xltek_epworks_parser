classdef waveform < handle
    %
    %   Class:
    %   p.rec.waveform

    properties
        timestamp
        id
        data
    end

    methods
        function obj = waveform(data,default_length)
            %
            %   p.rec.waveform

            %1:4 - # of bytes to read at a time
            %5:20 - id
            %21:28 - timestamp
            %29:41 - empty
            %42 - value of 64 - is this a # of columns/rows thing?
            %45 - starts counting up, 1 through n
            %       - why start counting before a meaningful number
            %        at byte 46?
            %46:48 - value of [202 154 59]
            %
            %   old code did the following words:
            %29:32 - uint32
            %33:36 - uint32
            %37:40 - uint32
            %41:44 - uint8
            %45:48 - uint32
            %49:52 - uint32
            %43:56 - uint32
            %57:60 - single, stim amp
            %
            %   first of anythign in this sample is 889
            %   - is this because there are just 0s for some amount
            %   of data?

            obj.timestamp = epworks.utils.processType3time(data(21:28));
            obj.data = typecast(data(889:end),'single');
        end
    end
end