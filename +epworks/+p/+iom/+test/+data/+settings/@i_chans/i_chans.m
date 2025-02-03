classdef i_chans < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.test.data.settings.cursor_calc

    properties
        s
        active_electrode
        audio_volume
        event_threshold
        hardware_lff
        id
        is_squelch
        logical_chan
        montage_chan_id
        old_log_chan
        range
        ref_electrode
        resolution
        sampling_freq
        squelch_threshold
        threshold_delay
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
                obj = epworks.p.iom.test.data.settings.i_chans(s2,r);
                objs{i} = obj;
            end
            objs = [objs{:}];
        end
    end

    methods
        function obj = i_chans(s,r)
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

                    case 'ActiveElectrode'
                        obj.active_electrode = value;
                    case 'AudioVolume'
                        obj.audio_volume = value;
                    case 'EventThreshold'
                        obj.event_threshold = value;
                    case 'HardwareLFF'
                        obj.hardware_lff = value;
                    case 'ID'
                        obj.id = value;
                        r.logID(obj,value);
                    case 'IsSquelch'
                        obj.is_squelch = value;
                    case 'LogicalChan'
                        obj.logical_chan = value;
                    case 'MontageChanId'
                        obj.montage_chan_id = value;
                    case 'OldLogChan'
                        obj.old_log_chan = value;
                    case 'Range'
                        obj.range = value;
                    case 'RefElectrode'
                        obj.ref_electrode = value;
                    case 'Resolution'
                        obj.resolution = value;
                    case 'SamplingFreq'
                        obj.sampling_freq = value;
                    case 'SquelchThreshold'
                        obj.squelch_threshold = value;
                    case 'ThresholdDelay'
                        obj.threshold_delay = value;
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end