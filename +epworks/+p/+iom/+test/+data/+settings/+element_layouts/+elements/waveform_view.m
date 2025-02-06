classdef waveform_view < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.test.data.settings.element_layouts.elements.waveform_view

    properties
        guid
        friendly_description
        friendly_name
        view_type
        min_position
        position
        suppress_visibility
        window_title_prefix
        active_set_color
        background_color
        baseline_color
        cursor_color
        cursor_range_color
        grid_color
        group_splitting
        groups_count
        groups0
        hide_cursor_labels
        label_color
        locked_on_live
        num_divisions
        num_wave_smooth
        num_waves_in_overlay
        num_waves_in_replace
        only_show_selected_waved_labels
        removed_traces_count
        set_spacing
        show_cursors
        show_trace_set_labels
        show_wave_labels
        split_gain
        trace_spacing
        traces_count
        wave_x_spacing
        wave_y_spacing
        window_name
        cursor_view_abs_rel_ratio
        cursor_view
        view_width_in_divisions
        view_zoom_index
        view_zoom_select
        window_placement

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
    end

    methods
        function obj = waveform_view(s,r)
            obj.guid = s.guid;
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'FriendlyDescription'
                        obj.friendly_description = value;
                    case 'FriendlyName'
                        obj.friendly_name = value;
                    case 'ViewType'
                        obj.view_type = value;
                    case 'MinPosition'
                        obj.min_position = epworks.p.iom.test.data.settings.element_layouts.elements.view_min_position(value,r);
                    case 'Position'
                        obj.position = epworks.p.iom.test.data.settings.element_layouts.elements.view_position(value,r);
                    case 'SuppressVisibility'
                        obj.suppress_visibility = value;
                    case 'WindowTitlePrefix'
                        obj.window_title_prefix = value;
                    case 'ActiveSetColor'
                        obj.active_set_color = epworks.utils.getColor(value);
                    case 'BackgroundColor'
                        obj.background_color = epworks.utils.getColor(value);
                    case 'BaselineColor'
                        obj.baseline_color = epworks.utils.getColor(value);
                    case 'CursorColor'
                        obj.cursor_color = epworks.utils.getColor(value);
                    case 'CursorRangeColor'
                        obj.cursor_range_color = epworks.utils.getColor(value);
                    case 'GridColor'
                        obj.grid_color = epworks.utils.getColor(value);
                    case 'GroupSplitting'
                        obj.group_splitting = value;
                    case 'Groups_Count'
                        obj.groups_count = value;
                    case 'Groups_0_'
                        obj.groups0 = epworks.p.iom.test.data.settings.element_layouts.elements.groups(value,r);
                    case 'HideCursorLabels'
                        obj.hide_cursor_labels = value;
                    case 'LabelColor'
                        obj.label_color = value;
                    case 'LockedOnLive'
                        obj.locked_on_live = value;
                    case 'NumDivisions'
                        obj.num_divisions = epworks.p.iom.test.data.settings.element_layouts.elements.num_divisions(value,r); 
                    case 'NumWaveSmooth'
                        obj.num_wave_smooth = value;
                    case 'NumWavesInOverlay'
                        obj.num_waves_in_overlay = value;
                    case 'NumWavesInReplace'
                        obj.num_waves_in_replace = value;
                    case 'OnlyShowSelectedWaveLabels'
                        obj.only_show_selected_waved_labels = value;
                    case 'RemovedTraces_Count'
                        obj.removed_traces_count = value;
                    case 'SetSpacing'
                        obj.set_spacing = value;
                    case 'ShowCursors'
                        obj.show_cursors = value;
                    case 'ShowTraceSetLabels'
                        obj.show_trace_set_labels = value;
                    case 'ShowWaveLabels'
                        obj.show_wave_labels = value;
                    case 'SplitGain'
                        obj.split_gain = value;
                    case 'TraceSpacing'
                        obj.trace_spacing = value;
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
                        obj.traces_count = value;
                    case 'WaveXSapcing'
                        obj.wave_x_spacing = value;
                    case 'WaveYSpacing'
                        obj.wave_y_spacing = value;
                    case 'WindowName'
                        obj.window_name = value;
                    case 'CursorViewAbsRelRatio'
                        obj.cursor_view_abs_rel_ratio = value;
                    case 'CursorView'
                        obj.cursor_view = epworks.p.iom.test.data.settings.element_layouts.elements.cursor_view(value,r);
                    case 'ViewWidthInDivisions'
                        obj.view_width_in_divisions = value;
                    case 'ViewZoomIndex'
                        obj.view_zoom_index = value;
                    case 'ViewZoomSelect'
                        obj.view_zoom_select = value;
                    case 'WindowPlacement'
                        obj.window_placement = value;
                    otherwise
                        keyboard
                end
            end

        end
    end
end