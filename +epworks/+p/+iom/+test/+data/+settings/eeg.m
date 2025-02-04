classdef eeg < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.test.data.settings.eeg
    %
    %   Parent: epworks.p.test.settings
    %
    %   Children:
    %       - epworks.p.test.data.settings.eeg.applied_montage_key_tree

    properties
        alpha_max
        alpha_min
        applied_montage
        applied_montage_key_tree
        beta_max
        beta_min
        delay
        delta_max
        delta_min
        duration
        epoch
        reference
        spectral_edge
        theta_max
        theta_min
        true_differential
    end

    methods
        function obj = eeg(s,r)
            r.logObject(obj);
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
                    case 'BetaMin'
                        obj.beta_min = value;
                    case 'Delay'
                        obj.delay = value;
                    case 'DeltaMax'
                        obj.delta_max = value;
                    case 'DeltaMin'
                        obj.delta_min = value;
                    case 'Duration'
                        obj.delta_max = value;
                    case 'Epoch'
                        obj.epoch = value;
                    case 'Reference'
                        obj.reference = value;
                    case 'SpectralEdge'
                        obj.spectral_edge = value;
                    case 'ThetaMax'
                        obj.theta_max = value;
                    case 'ThetaMin'
                        obj.theta_min = value;
                    case 'TrueDifferential'
                        obj.true_differential = value;
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end