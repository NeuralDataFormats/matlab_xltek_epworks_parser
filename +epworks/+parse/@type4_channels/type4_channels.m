classdef type4_channels
    %
    %   Class:
    %   epworks.parse.type4_channels

    properties
        name
        full_name
        raw_data
        n_props
    end

    methods
        function obj = type4_channels(s)
            %
            %   obj = epworks.parse.type4_channels
            obj.name = s.name;
            obj.full_name = s.full_name;
            obj.raw_data = s.raw_data;
            obj.n_props = s.n_props;

            if isequal(obj.raw_data,uint8([0 0 0 0]))
                return
            end


            %Known Channels
            %-------------------------------------------------
            %EPTest.Data.Settings.EEG.AppliedMontageKeyTree.Channels
            %
            %   


            %d = obj.raw_data
            %   - start: 35244
            %   -  stop: 45147

            keyboard
            %ChanIndex
            %Channel
            %Calibration
            %ChanProcType
            %EEG
            %ChanType
            %EEG
            %Color
            %From_Name
            %Gain
            %   - gain value
            %GroupId
            %HffCutoff
            %IChannelId

            %Format

            %12 - n_channels
            %0  0  0 5
            %55 3  0 0
            %2  0  0 0
            %5  33 0 0 <= pointer to jump to next thing
            %0  2  0 0
            %0  2 15 0 <- 15 0 - #characters - nope
            %0  0 67 104


            %strfind(d,(uint8('ChanIndex')))
        end
    end
end