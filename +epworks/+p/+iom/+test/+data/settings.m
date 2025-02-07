classdef settings < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.test.settings

    properties (Hidden)
        id_props = {'active_layout'}
    end

    properties
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
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'ActiveLayout'
                        obj.active_layout = value;
                    case 'AppTestSettings'
                        obj.app_test_settings = epworks.p.iom.test.data.settings.app_test_settings(value,r);
                    case 'BoardRevision'
                        obj.board_revision = value;
                    case 'ConfigData'
                        obj.config_data = value;
                    case 'CursorCalc'
                        obj.cursor_calc = epworks.p.iom.test.data.settings.cursor_calc.initialize(value,r);
                    case 'CursorDef'
                        obj.cursor_def = epworks.p.iom.test.data.settings.cursor_def.initialize(value,r);
                    case 'DefaultTemplate'
                        obj.default_template = value;
                    case 'EEG'
                        obj.eeg = epworks.p.iom.test.data.settings.eeg(value,r);
                    case 'Electrodes'
                        obj.electrodes = epworks.p.iom.test.data.settings.electrode.initialize(value,r);
                    case 'ElementLayouts'
                        obj.electrodes = epworks.p.iom.test.data.settings.element_layouts.initialize(value,r);
                    case 'FileName'
                        obj.file_name = value;
                    case 'ForceFixChanMap'
                        obj.force_fix_chan_map = value;
                    case 'GroupDef'
                        obj.group_def = epworks.p.iom.test.data.settings.group_def.initialize(value,r);
                    case 'HBType'
                        obj.hb_type = value;
                    case 'HardwareConfig'
                        obj.hardware_config = value;
                    case 'HistorySets'
                        obj.history_sets = epworks.p.iom.test.data.settings.history_sets.initialize(value,r);
                    case 'IChans'
                        obj.i_chans = epworks.p.iom.test.data.settings.i_chans.initialize(value,r);
                    case 'ID'
                        obj.id = value;
                        r.logID(obj,value);
                    case 'IsEMGTest'
                        obj.is_emg_test = value;
                    case 'ManufacturingTest'
                        obj.manufacturing_test = epworks.p.iom.test.data.settings.manufacturing_test(value,r);
                    case 'Name'
                        obj.name = value;
                    case 'OChans'
                        obj.o_chans = epworks.p.iom.test.data.settings.o_chans.initialize(value,r);
                    case 'Stims'
                        obj.stims = epworks.p.iom.test.data.settings.stims.initialize(value,r);
                    case 'TestTips'
                        obj.test_tips = value;
                    case 'Timelines'
                        obj.timelines = epworks.p.iom.test.data.settings.timelines.initialize(value,r);
                    case 'TrendSets'
                        obj.trendsets = value;
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end