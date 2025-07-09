classdef o_chans < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.iom.test.data.settings.cursor_calc

    properties (Hidden)
        id_props = {'from','group_def','maacs_trace_id','to'}
    end 

    properties
        color
        filtering_style
        from
        group_def
        hff_cutoff
        id
        is_channel_enabled
        is_channel_trigger
        is_rejection_on_stim_saturation
        left_display_gain
        lff_cutoff
        maacs_trace_id
        max_user_variation
        name
        notch_cutoff
        preview_mode
        preview_settings
        response_chime
        right_display_gain
        timebase
        to
    end

    methods (Static)
        function objs = initialize(s,r)
            %
            %   objs = epworks.p.test.data.settings.cursor_calc.initialize(s,r)

            a = s.array;
            n_children = length(a);
            objs = cell(1,n_children);
            for i = 1:n_children
                s2 = a{i};
                obj = epworks.p.iom.test.data.settings.o_chans(s2,r);
                objs{i} = obj;
            end
            objs = [objs{:}];
        end
    end

    methods
        function obj = o_chans(s,r)
            r.logObject(obj);
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

                    case 'Color'
                        obj.color = epworks.utils.getColor(value);
                    case 'FilteringStyle'
                        obj.filtering_style = value;
                    case 'From'
                        obj.from = value;
                    case 'GroupDef'
                        obj.group_def = value;
                    case 'HffCutoff'
                        obj.hff_cutoff = value;
                    case 'ID'
                        obj.id = value;
                        r.logID(obj,value);
                    case 'IsChannelEnabled'
                        obj.is_channel_enabled = value;
                    case 'IsChannelTrigger'
                        obj.is_channel_trigger = value;
                    case 'IsRejectionOnStimSaturation'
                        obj.is_rejection_on_stim_saturation = value;
                    case 'LeftDisplayGain'
                        obj.left_display_gain = value;
                    case 'LffCutoff'
                        obj.lff_cutoff = value;
                    case 'MaacsTraceId'
                        obj.maacs_trace_id = value;
                    case 'MaxUserVariation'
                        obj.max_user_variation = value;
                    case 'Name'
                        obj.name = value;
                    case 'NotchCutoff'
                        obj.notch_cutoff = value;
                    case 'PreviewMode'
                        obj.preview_mode = value;
                    case 'PreviewSettings'
                        obj.preview_settings = value;
                    case 'ResponseChime'
                        obj.response_chime = value;
                    case 'RightDisplayGain'
                        obj.right_display_gain = value;
                    case 'Timebase'
                        obj.timebase = value;
                    case 'To'
                        obj.to = value;
                    otherwise
                        safe_name = epworks.utils.getSafeVariableName(cur_name);
                        obj.unhandled_props.(safe_name) = value;
                end
            end

            r.logUnhandledProps(obj);
            
        end
    end
end