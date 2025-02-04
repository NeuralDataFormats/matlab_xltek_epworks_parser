classdef elements < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.test.data.settings.element_layouts.elements

    properties
        eeg_waveform_view
        group_dir_view
        history_view
        note_log_view
        stim_ctrl_view
        tp_density_spectral_eeg_view
        test_dir_view
        waveform_view
        waveform_view1
        waveform_view2
        waveform_view3
        waveform_view4
        waveform_view5
        waveform_view6
        waveform_view7
        waveform_view8
        waveform_view9
    end

    methods
        function obj = elements(s,r)
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'EegWaveformView'
                        obj.eeg_waveform_view = epworks.p.iom.test.data.settings.element_layouts.elements.eeg_waveform_view(value,r);
                    case 'GroupDirView'
                        obj.group_dir_view = epworks.p.iom.test.data.settings.element_layouts.elements.group_dir_view(value,r);
                    case 'HistoryView'
                        obj.history_view = epworks.p.iom.test.data.settings.element_layouts.elements.history_view(value,r);
                    case 'NoteLogView'
                        obj.note_log_view = epworks.p.iom.test.data.settings.element_layouts.elements.note_log_view(value,r);
                    case 'StimCtrlView'
                        obj.stim_ctrl_view = epworks.p.iom.test.data.settings.element_layouts.elements.stim_ctrl_view(value,r);
                    case 'TPDensitySpectralEegView'
                        obj.tp_density_spectral_eeg_view = epworks.p.iom.test.data.settings.element_layouts.elements.tp_density_spectral_eeg_view(value,r);
                    case 'TestDirView'
                        obj.test_dir_view = epworks.p.iom.test.data.settings.element_layouts.elements.test_dir_view(value,r);
                    case 'WaveformView'
                        obj.waveform_view = epworks.p.iom.test.data.settings.element_layouts.elements.waveform_view(value,r);
                    case 'WaveformView_1'
                        obj.waveform_view1 = epworks.p.iom.test.data.settings.element_layouts.elements.waveform_view(value,r);
                    case 'WaveformView_2'
                        obj.waveform_view2 = epworks.p.iom.test.data.settings.element_layouts.elements.waveform_view(value,r);
                    case 'WaveformView_3'
                        obj.waveform_view3 = epworks.p.iom.test.data.settings.element_layouts.elements.waveform_view(value,r);
                    case 'WaveformView_4'
                        obj.waveform_view4 = epworks.p.iom.test.data.settings.element_layouts.elements.waveform_view(value,r);
                    case 'WaveformView_5'
                        obj.waveform_view5 = epworks.p.iom.test.data.settings.element_layouts.elements.waveform_view(value,r);
                    case 'WaveformView_6'
                        obj.waveform_view6 = epworks.p.iom.test.data.settings.element_layouts.elements.waveform_view(value,r);
                    case 'WaveformView_7'
                        obj.waveform_view7 = epworks.p.iom.test.data.settings.element_layouts.elements.waveform_view(value,r);
                    case 'WaveformView_8'
                        obj.waveform_view8 = epworks.p.iom.test.data.settings.element_layouts.elements.waveform_view(value,r);
                    case 'WaveformView_9'
                        obj.waveform_view9 = epworks.p.iom.test.data.settings.element_layouts.elements.waveform_view(value,r);
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end