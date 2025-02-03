classdef coefficients < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.test.data.settings.eeg
    %
    %   Parent: epworks.p.test.settings
    %
    %   Children:
    %       - epworks.p.test.data.settings.eeg.applied_montage_key_tree

    properties

    end

    methods
        function obj = coefficients(s,r)
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    %{
                    case 'AudioVolume'
                        obj.audio_volume = double(typecast(s2.raw_data,'uint32'));
                    case 'Color'
                        obj.color = double(s2.raw_data);
                    case 'HffCutoff'
                        obj.hff_cutoff = typecast(s2.raw_data,'double');
                    case 'IsAlarmedWave'
                        obj.is_alarmed_wave = double(typecast(s2.raw_data,'uint32'));
                    %}

                    case 'AlphaMax'
                        obj.alpha_max = value;
                    case 'AlphaMin'
                        obj.alpha_min = value;
                    case 'AppliedMontage'
                        obj.applied_montage = value;
                    case 'AppliedMontageKeyTree'
                        obj.applied_montage_key_tree = epworks.p.iom.test.data.settings.eeg.applied_montage_key_tree(value,r);
                    case 'BetaMax'
                        obj.beta_max = value;
                    
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end