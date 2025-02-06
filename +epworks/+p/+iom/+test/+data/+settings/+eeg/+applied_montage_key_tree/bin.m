classdef bin < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.test.data.settings.eeg.applied_montage_key_tree.bin

    properties
        color
        high_freq
        low_freq
    end

    methods
        function obj = bin(s,r)
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'Color'
                        obj.color = epworks.utils.getColor(value);
                    case 'HighFreq'
                        obj.high_freq = value;
                    case 'LowFreq'
                        obj.low_freq = value;
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end