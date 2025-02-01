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
            obj.s = s;
            n_children = length(s.child_indices);
            for i = 1:n_children
                index = s.child_indices(i);
                r.processed(index) = true;
                s2 = r.getStruct(index);
                I = find(s2.name == '}',1,'last');
                name_use = s2.name(I+1:end);
                reg_tag = s2.name(2:I);
                obj.reg_tag = reg_tag;

                switch name_use
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
                        obj.min_position = epworks.p.test.data.settings.element_layouts.elements.view_min_position(s2,r);
                    case 'Position'
                        obj.position = epworks.p.test.data.settings.element_layouts.elements.view_position(s2,r);
                    case 'SuppressVisibility'
                    case 'WindowTitlePrefix'
                    case 'ActiveSetColor'
                    case 'BackgroundColor'
                    case 'BaselineColor'
                    case 'CursorColor'
                    case 'CursorRangeColor'
                    case 'GridColor'
                    case 'GroupSplitting'
                    case 'Groups!Count'
                    case 'Groups[0]'
                        obj.groups0 = epworks.p.test.data.settings.element_layouts.elements.groups(s2,r);
                    case 'HideCursorLabels'
                    case 'LabelColor'
                    case 'LockedOnLive'
                    case 'NumDivisions'
                        obj.num_divisions = epworks.p.test.data.settings.element_layouts.elements.num_divisions(s2,r); 
                    case 'NumWaveSmooth'
                    case 'NumWavesInOverlay'
                    case 'NumWavesInReplace'
                    case 'OnlyShowSelectedWaveLabels'
                    case 'RemovedTraces!Count'
                    case 'SetSpacing'
                    case 'ShowCursors'
                    case 'ShowTraceSetLabels'
                    case 'ShowWaveLabels'
                    case 'SplitGain'
                    case 'TraceSpacing'
                    case 'Traces[0]'
                        obj.traces0 = epworks.p.test.data.settings.element_layouts.elements.traces(s2,r);
                    case 'Traces[1]'
                        obj.traces1 = epworks.p.test.data.settings.element_layouts.elements.traces(s2,r);
                    case 'Traces[2]'
                        obj.traces2 = epworks.p.test.data.settings.element_layouts.elements.traces(s2,r);
                    case 'Traces[3]'
                        obj.traces3 = epworks.p.test.data.settings.element_layouts.elements.traces(s2,r);
                    case 'Traces[4]'
                        obj.traces4 = epworks.p.test.data.settings.element_layouts.elements.traces(s2,r);
                    case 'Traces[5]'
                        obj.traces5 = epworks.p.test.data.settings.element_layouts.elements.traces(s2,r);
                    case 'Traces[6]'
                        obj.traces6 = epworks.p.test.data.settings.element_layouts.elements.traces(s2,r);
                    case 'Traces[7]'
                        obj.traces7 = epworks.p.test.data.settings.element_layouts.elements.traces(s2,r);
                    case 'Traces[8]'
                        obj.traces8 = epworks.p.test.data.settings.element_layouts.elements.traces(s2,r);
                    case 'Traces[9]'
                        obj.traces9 = epworks.p.test.data.settings.element_layouts.elements.traces(s2,r);
                    case 'Traces[10]'
                        obj.traces10 = epworks.p.test.data.settings.element_layouts.elements.traces(s2,r);

                    case 'Traces!Count'
                    case 'WaveXSapcing'
                    case 'WaveYSpacing'
                    case 'WindowName'
                    case 'CursorViewAbsRelRatio'
                    case 'CursorView'
                        obj.cursor_view = epworks.p.test.data.settings.element_layouts.elements.cursor_view(s2,r);
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