classdef settings
    %
    %   Class:
    %   epworks.p.test.settings

    properties
        s
        active_layout
        app_test_settings
        board_revision
        config_data
        cursor_calc
        cursor_def
        default_template
        eeg
        electrodes
        element_layouts
        file_name
        force_fix_chan_map
        group_def
        hb_type
        hardware_config
        history_sets
        i_chans
        id
        is_emg_test
        manufacturing_test
        name
        o_chans
        stims
        test_tips
        timelines
        trendsets
    end

    methods
        function obj = settings(s,r)
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

                    case 'ActiveLayout'

                    case 'AppTestSettings'
                        obj.app_test_settings = epworks.p.test.data.settings.app_test_settings(s2,r);
                    case 'BoardRevision'

                    case 'ConfigData'

                    case 'CursorCalc'
                        obj.cursor_calc = epworks.p.test.data.settings.cursor_calc.initialize(s2,r);
                    case 'CursorDef'
                        obj.cursor_def = epworks.p.test.data.settings.cursor_def.initialize(s2,r);
                    case 'DefaultTemplate'

                    case 'EEG'
                        obj.eeg = epworks.p.test.data.settings.eeg(s2,r);
                    case 'Electrodes'
                        obj.electrodes = epworks.p.test.data.settings.electrode.initialize(s2,r);
                    case 'ElementLayouts'
                        obj.electrodes = epworks.p.test.data.settings.element_layouts.initialize(s2,r);
                    case 'FileName'

                    case 'ForceFixChanMap'

                    case 'GroupDef'
                        obj.group_def = epworks.p.test.data.settings.group_def.initialize(s2,r);
                    case 'HBType'

                    case 'HardwareConfig'

                    case 'HistorySets'
                        obj.history_sets = epworks.p.test.data.settings.history_sets.initialize(s2,r);
                    case 'IChans'
                        obj.i_chans = epworks.p.test.data.settings.i_chans.initialize(s2,r);

                    case 'ID'

                    case 'IsEMGTest'

                    case 'ManufacturingTest'

                    case 'Name'

                    case 'OChans'
                        obj.o_chans = epworks.p.test.data.settings.o_chans.initialize(s2,r);

                    case 'Stims'
                        obj.stims = epworks.p.test.data.settings.stims.initialize(s2,r);

                    case 'TestTips'

                    case 'Timelines'

                    case 'TrendSets'

                    otherwise
                        keyboard
                end
            end
            
        end
    end
end