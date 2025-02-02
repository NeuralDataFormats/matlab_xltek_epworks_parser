classdef o_chans < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.test.data.settings.cursor_calc

    properties
        s
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

            n_children = length(s.child_indices);
            objs = cell(1,n_children);
            for i = 1:n_children
                index = s.child_indices(i);
                r.processed(index) = true;
                s2 = r.getStruct(index);
                obj = epworks.p.test.data.settings.o_chans(s2,r);
                objs{i} = obj;
            end
            objs = [objs{:}];
        end
    end

    methods
        function obj = o_chans(s,r)
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

                    case 'Color'
                    case 'FilteringStyle'
                    case 'From'
                    case 'GroupDef'
                    case 'HffCutoff'
                    case 'ID'
                        obj.id = s2.raw_data;
                        r.logID(obj,obj.id);
                    case 'IsChannelEnabled'
                    case 'IsChannelTrigger'
                    case 'IsRejectionOnStimSaturation'
                    case 'LeftDisplayGain'
                    case 'LffCutoff'
                    case 'MaacsTraceId'
                    case 'MaxUserVariation'
                    case 'Name'
                        obj.name = s2.data_value;
                    case 'NotchCutoff'
                    case 'PreviewMode'
                    case 'PreviewSettings'
                    case 'ResponseChime'
                    case 'RightDisplayGain'
                    case 'Timebase'
                    case 'To'

                    otherwise
                        keyboard
                end
            end
            
        end
    end
end