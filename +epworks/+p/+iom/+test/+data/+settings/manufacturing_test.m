classdef manufacturing_test < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.test.data.settings.manufacturing_test

    properties
        active_channel
        active_electrode
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
                    case 'ActiveChannel'
                        obj.active_channel = value;
                    case 'ActiveElectrode'
                        obj.active_electrode = value;
                    case 'AllowedCrossTalkRatio'
                        obj.allowed_crosstalk_ratio = value;
                    case 'AllowedDCOffset'
                        obj.allowed_dc_offset = value;
                    case 'AllowedDeviationPercent'
                        obj.allowed_deviation_percent = value;
                    case 'AllowedNoiseLevel'
                        obj.allowed_noise_level = value;
                    case 'CyclingPeriod'
                        obj.cycling_period = value;
                    case 'IsCrossTalkTest'
                        obj.is_crosstalk_test = value;
                    case 'IsManufacturingTest'
                        obj.is_manufacturing_test = value;
                    case 'MinCrossTalkRatio'
                        obj.min_crosstalk_ratio = value;
                    case 'ReferenceSignalFrequency'
                        obj.reference_siganl_frequency = value;
                    case 'ReferenceSignalP2P'
                        obj.reference_signal_p2p = value;
                    otherwise
                        safe_name = epworks.utils.getSafeVariableName(cur_name);
                        obj.unhandled_props.(safe_name) = value;
                end
            end

            r.logUnhandledProps(obj);
            
        end
    end
end