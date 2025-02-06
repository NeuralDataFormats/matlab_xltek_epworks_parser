classdef manufacturing_test < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.test.data.settings.manufacturing_test

    properties
        allowed_crosstalk_ratio
        allowed_dc_offset
        allowed_deviation_percent
        allowed_noise_level
        cycling_period
        is_crosstalk_test
        is_manufacturing_test
        min_crosstalk_ratio
        reference_siganl_frequency
        reference_signal_p2p
    end

    methods
        function obj = manufacturing_test(s,r)
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
                    case 'AllowedCrossTalkRatio'
                    case 'AllowedDCOffset'
                    case 'AllowedDeviationPercent'
                    case 'AllowedNoiseLevel'
                    case 'CyclingPeriod'
                    case 'IsCrossTalkTest'
                    case 'IsManufacturingTest'
                    case 'MinCrossTalkRatio'
                    case 'ReferenceSignalFrequency'
                    case 'ReferenceSignalP2P'
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end