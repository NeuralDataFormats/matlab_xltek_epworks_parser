classdef channels < handle
    %
    %   Class:
    %   epworks.p.test.data.settings.applied_montage_key_tree.channels

    properties
        bytes
        n_channels
        chans
    end

    methods
        function obj = channels(bytes)
            b = bytes;
            obj.bytes = bytes;
            obj.n_channels = double(typecast(b(1:4),'int32'));
        
            start_I = 5;
            chans = cell(1,obj.n_channels);
            n_bytes_all = zeros(1,obj.n_channels);
            all_bytes = zeros(obj.n_channels,823);
            for i = 1:obj.n_channels
                n_bytes = double(typecast(b(start_I+1:start_I+4),'int32'));
                n_bytes_all(i) = n_bytes;
                I1 = start_I;
                I2 = start_I+n_bytes-1;
                b2 = b(I1:I2);
                all_bytes(i,1:length(b2)) = b2;
                start_I = start_I + n_bytes;
                chans{i} = epworks.p.test.data.settings.eeg.applied_montage_key_tree.channel(b2);
            end

            obj.chans = [chans{:}];

            %Repeat of structure every 823 or 822 bytes
            %   ChanIndex
            %
            %   823 => 55 3

        end
    end
end