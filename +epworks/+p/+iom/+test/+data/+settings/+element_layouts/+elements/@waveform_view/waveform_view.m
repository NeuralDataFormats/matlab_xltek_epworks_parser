classdef waveform_view
    %
    %   Class:
    %   epworks.p.test.data.settings.element_layouts.elements.waveform_view

    properties
        s
        reg_tag
        min_position
        position
        groups0
        traces0
        traces1
        traces2
        traces3
        traces4
        traces5
        traces6
        traces7
        traces8
        traces9
        traces10
        cursor_view
        num_divisions
    end

    methods
        function obj = waveform_view(s,r)
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
                    case 'FriendlyDescription'
                    case 'FriendlyName'
                    case 'ViewType'
                    case 'MinPosition'
                        obj.min_position = epworks.p.iom.test.data.settings.element_layouts.elements.view_min_position(value,r);
                    case 'Position'
                        obj.position = epworks.p.iom.test.data.settings.element_layouts.elements.view_position(value,r);
                    case 'SuppressVisibility'
                    case 'WindowTitlePrefix'
                    case 'ActiveSetColor'
                    case 'BackgroundColor'
                    case 'BaselineColor'
                    case 'CursorColor'
                    case 'CursorRangeColor'
                    case 'GridColor'
                    case 'GroupSplitting'
                    case 'Groups_Count'
                    case 'Groups_0_'
                        obj.groups0 = epworks.p.iom.test.data.settings.element_layouts.elements.groups(value,r);
                    case 'HideCursorLabels'
                    case 'LabelColor'
                    case 'LockedOnLive'
                    case 'NumDivisions'
                        obj.num_divisions = epworks.p.iom.test.data.settings.element_layouts.elements.num_divisions(value,r); 
                    case 'NumWaveSmooth'
                    case 'NumWavesInOverlay'
                    case 'NumWavesInReplace'
                    case 'OnlyShowSelectedWaveLabels'
                    case 'RemovedTraces_Count'
                    case 'SetSpacing'
                    case 'ShowCursors'
                    case 'ShowTraceSetLabels'
                    case 'ShowWaveLabels'
                    case 'SplitGain'
                    case 'TraceSpacing'
                    case 'Traces_0_'
                        obj.traces0 = epworks.p.iom.test.data.settings.element_layouts.elements.traces(value,r);
                    case 'Traces_1_'
                        obj.traces1 = epworks.p.iom.test.data.settings.element_layouts.elements.traces(value,r);
                    case 'Traces_2_'
                        obj.traces2 = epworks.p.iom.test.data.settings.element_layouts.elements.traces(value,r);
                    case 'Traces_3_'
                        obj.traces3 = epworks.p.iom.test.data.settings.element_layouts.elements.traces(value,r);
                    case 'Traces_4_'
                        obj.traces4 = epworks.p.iom.test.data.settings.element_layouts.elements.traces(value,r);
                    case 'Traces_5_'
                        obj.traces5 = epworks.p.iom.test.data.settings.element_layouts.elements.traces(value,r);
                    case 'Traces_6_'
                        obj.traces6 = epworks.p.iom.test.data.settings.element_layouts.elements.traces(value,r);
                    case 'Traces_7_'
                        obj.traces7 = epworks.p.iom.test.data.settings.element_layouts.elements.traces(value,r);
                    case 'Traces_8_'
                        obj.traces8 = epworks.p.iom.test.data.settings.element_layouts.elements.traces(value,r);
                    case 'Traces_9_'
                        obj.traces9 = epworks.p.iom.test.data.settings.element_layouts.elements.traces(value,r);
                    case 'Traces_10_'
                        obj.traces10 = epworks.p.iom.test.data.settings.element_layouts.elements.traces(value,r);

                    case 'Traces_Count'
                    case 'WaveXSapcing'
                    case 'WaveYSpacing'
                    case 'WindowName'
                    case 'CursorViewAbsRelRatio'
                    case 'CursorView'
                        obj.cursor_view = epworks.p.iom.test.data.settings.element_layouts.elements.cursor_view(value,r);
                    case 'ViewWidthInDivisions'
                    case 'ViewZoomIndex'
                    case 'ViewZoomSelect'
                    case 'WindowPlacement'

                    otherwise
                        keyboard
                end
            end

        end
    end
end