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

            n_children = length(s.child_indices);
            objs = cell(1,n_children);
            for i = 1:n_children
                index = s.child_indices(i);
                r.processed(index) = true;
                s2 = r.getStruct(index);
                obj = epworks.p.test.data.settings.i_chans(s2,r);
                objs{i} = obj;
            end
            objs = [objs{:}];
        end
    end

    methods
        function obj = i_chans(s,r)
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

                    case 'ActiveElectrode'
                    case 'AudioVolume'
                    case 'EventThreshold'
                    case 'HardwareLFF'
                    case 'ID'
                        obj.id = s2.raw_data;

                    case 'IsSquelch'
                    case 'LogicalChan'
                    case 'MontageChanId'
                    case 'OldLogChan'
                    case 'Range'
                    case 'RefElectrode'
                    case 'Resolution'
                    case 'SamplingFreq'
                    case 'SquelchThreshold'
                    case 'ThresholdDelay'

                    otherwise
                        keyboard
                end
            end
            
        end
    end
end