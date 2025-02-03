classdef tp_density_spectral_eeg_view
    %
    %   Class:
    %   epworks.p.test.data.settings.element_layouts.elements.waveform_view

    properties
        s
        reg_tag
min_position
position
    end

    methods
        function obj = tp_density_spectral_eeg_view(s,r)
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

                    case 'FriendlyName'
                    case 'ViewType'
                        %see 2x
                    case 'MinPosition'
                        obj.min_position = epworks.p.iom.test.data.settings.element_layouts.elements.view_min_position(value,r);
                    case 'Position'
                        obj.position = epworks.p.iom.test.data.settings.element_layouts.elements.view_position(value,r);
                    case 'SuppressVisibility'
                    case 'WindowTitlePrefix'
                    case 'AutoScalePowerMax'
                    case 'BackgroundColor'
                    case 'CenterEpochGraph'
                    case 'DisplayVoltage'
                    case 'DurationPerScreen'
                    case 'ForegroundColor'
                    case 'FrequencyMax'
                    case 'GraphColor'
                    case 'GridHeight'
                    case 'GridWidth'
                    case 'PowerMax'

                    otherwise
                        keyboard
                end
            end
            
        end
    end
end