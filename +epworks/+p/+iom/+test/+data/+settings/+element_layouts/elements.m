classdef elements < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.test.data.settings.element_layouts.elements
    %
    %   See Also
    %   --------
    %   epworks.p.test.data.settings.element_layouts.elements.waveform_view

    properties
        csa_spectral_eeg_view
        dsa_spectral_eeg_view
        eeg_waveform_view
        group_dir_view
        history_view
        note_log_view
        raw_sweep_view
        stim_ctrl_view
        tp_density_spectral_eeg_view
        test_dir_view
        trend_view

        %This is an array ...
        waveform_views

    end

    methods
        function obj = elements(s,r)
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);

            temp = regexp(fn,'^WaveformView_\d','once');
            n_views = sum(~cellfun('isempty',temp))+1;
            views = cell(1,n_views);

            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'CSASpectralEegView'
                        obj.csa_spectral_eeg_view = epworks.p.iom.test.data.settings.element_layouts.elements.csa_spectral_eeg_view(value,r);
                    case 'DSASpectralEegView'
                        obj.eeg_waveform_view = epworks.p.iom.test.data.settings.element_layouts.elements.dsa_spectral_eeg_view(value,r);
                    case 'EegWaveformView'
                        obj.eeg_waveform_view = epworks.p.iom.test.data.settings.element_layouts.elements.eeg_waveform_view(value,r);
                    case 'GroupDirView'
                        obj.group_dir_view = epworks.p.iom.test.data.settings.element_layouts.elements.group_dir_view(value,r);
                    case 'HistoryView'
                        obj.history_view = epworks.p.iom.test.data.settings.element_layouts.elements.history_view(value,r);
                    case 'NoteLogView'
                        obj.note_log_view = epworks.p.iom.test.data.settings.element_layouts.elements.note_log_view(value,r);
                    case 'RawSweepView'
                        obj.raw_sweep_view = epworks.p.iom.test.data.settings.element_layouts.elements.raw_sweep_view(value,r);
                    case 'StimCtrlView'
                        obj.stim_ctrl_view = epworks.p.iom.test.data.settings.element_layouts.elements.stim_ctrl_view(value,r);
                    case 'TestDirView'
                        obj.test_dir_view = epworks.p.iom.test.data.settings.element_layouts.elements.test_dir_view(value,r);
                    case 'TPDensitySpectralEegView'
                        obj.tp_density_spectral_eeg_view = epworks.p.iom.test.data.settings.element_layouts.elements.tp_density_spectral_eeg_view(value,r);
                    case 'TrendView'
                        obj.trend_view = epworks.p.iom.test.data.settings.element_layouts.elements.trend_view(value,r);
                    otherwise
                        cur_name = string(cur_name);
                        if startsWith(cur_name,'WaveformView')
                            temp = regexp(cur_name,'\d+','once','match');
                            if isempty(temp) || ismissing(temp)
                                %0 doesn't have a number
                                index = 1;
                            else
                                %Note, they start at 0
                                index = str2double(temp) + 1;
                            end
                            view = epworks.p.iom.test.data.settings.element_layouts.elements.waveform_view(value,r);
                            views{index} = view;
                        else
                            safe_name = epworks.utils.getSafeVariableName(cur_name);
                            obj.unhandled_props.(safe_name) = value;
                        end
                        
                end
            end
            obj.waveform_views = [views{:}];
            r.logUnhandledProps(obj);
            
        end
    end
end