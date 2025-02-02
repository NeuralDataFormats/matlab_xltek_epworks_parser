classdef eeg < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.test.data.settings.eeg

    properties
        s

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
            obj.s = s;
            n_children = length(s.child_indices);
            for i = 1:n_children
                index = s.child_indices(i);
                r.processed(index) = true;
                s2 = r.getStruct(index);

                switch s2.name
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
                    case 'AlphaMin'
                    case 'AppliedMontage'
                    case 'AppliedMontageKeyTree'
                        obj.applied_montage_key_tree = epworks.p.test.data.settings.eeg.applied_montage_key_tree(s2,r);
                    case 'BetaMax'
                    case 'BetaMin'
                    case 'Delay'
                    case 'DeltaMax'
                    case 'DeltaMin'
                    case 'Duration'
                    case 'Epoch'
                    case 'Reference'
                    case 'SpectralEdge'
                    case 'ThetaMax'
                    case 'ThetaMin'
                    case 'TrueDifferential'

                    otherwise
                        keyboard
                end
            end
            
        end
    end
end