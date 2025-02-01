classdef elements
    %
    %   Class:
    %   epworks.p.test.data.settings.element_layouts.elements

    properties
        s

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

                    case 'EegWaveformView'
                        obj.eeg_waveform_view = epworks.p.test.data.settings.element_layouts.elements.eeg_waveform_view(s2,r);
                    case 'GroupDirView'
                        obj.group_dir_view = epworks.p.test.data.settings.element_layouts.elements.group_dir_view(s2,r);
                    case 'HistoryView'
                        obj.history_view = epworks.p.test.data.settings.element_layouts.elements.history_view(s2,r);
                    case 'NoteLogView'
                        obj.note_log_view = epworks.p.test.data.settings.element_layouts.elements.note_log_view(s2,r);
                    case 'StimCtrlView'
                        obj.stim_ctrl_view = epworks.p.test.data.settings.element_layouts.elements.stim_ctrl_view(s2,r);
                    case 'TPDensitySpectralEegView'
                        obj.tp_density_spectral_eeg_view = epworks.p.test.data.settings.element_layouts.elements.tp_density_spectral_eeg_view(s2,r);
                    case 'TestDirView'
                        obj.test_dir_view = epworks.p.test.data.settings.element_layouts.elements.test_dir_view(s2,r);
                    case 'WaveformView'
                        obj.waveform_view = epworks.p.test.data.settings.element_layouts.elements.waveform_view(s2,r);
                    case 'WaveformView 1'
                        obj.waveform_view1 = epworks.p.test.data.settings.element_layouts.elements.waveform_view(s2,r);
                    case 'WaveformView 2'
                        obj.waveform_view2 = epworks.p.test.data.settings.element_layouts.elements.waveform_view(s2,r);
                    case 'WaveformView 3'
                        obj.waveform_view3 = epworks.p.test.data.settings.element_layouts.elements.waveform_view(s2,r);
                    case 'WaveformView 4'
                        obj.waveform_view4 = epworks.p.test.data.settings.element_layouts.elements.waveform_view(s2,r);
                    case 'WaveformView 5'
                        obj.waveform_view5 = epworks.p.test.data.settings.element_layouts.elements.waveform_view(s2,r);
                    case 'WaveformView 6'
                        obj.waveform_view6 = epworks.p.test.data.settings.element_layouts.elements.waveform_view(s2,r);
                    case 'WaveformView 7'
                        obj.waveform_view7 = epworks.p.test.data.settings.element_layouts.elements.waveform_view(s2,r);
                    case 'WaveformView 8'
                        obj.waveform_view8 = epworks.p.test.data.settings.element_layouts.elements.waveform_view(s2,r);
                    case 'WaveformView 9'
                        obj.waveform_view9 = epworks.p.test.data.settings.element_layouts.elements.waveform_view(s2,r);

                    otherwise
                        keyboard
                end
            end
            
        end
    end
end