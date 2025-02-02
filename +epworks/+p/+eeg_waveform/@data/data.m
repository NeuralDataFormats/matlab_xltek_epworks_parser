classdef data < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.eeg_waveform.data

    properties (Hidden)
        id_props = {'set_obj','trace_obj'}
    end

    properties
        s

        audio_volume
        color
        hff_cutoff
        is_alarmed_wave
        left_display_gain
        lff_cutoff
        notch_cutoff
        range
        resolution
        right_display_gain
        samp_freq
        sequence_number
        set_obj
        timebase
        timestamp
        trace_obj
        trigger_delay
        visible
    end

    methods
        function obj = data(s,r)
            obj.s = s;
            n_children = length(s.child_indices);
            names = cell(1,n_children);
            objs = cell(1,n_children);
            for i = 1:n_children
                index = s.child_indices(i);
                r.processed(index) = true;
                s2 = r.getStruct(index);
                names{i} = s2.name;
                switch s2.name
                    case 'AudioVolume'
                        obj.audio_volume = double(typecast(s2.raw_data,'uint32'));
                    case 'Color'
                        obj.color = double(s2.raw_data);
                    case 'HffCutoff'
                        obj.hff_cutoff = typecast(s2.raw_data,'double');
                    case 'IsAlarmedWave'
                        obj.is_alarmed_wave = double(typecast(s2.raw_data,'uint32'));
                    case 'LeftDisplayGain'
                        obj.left_display_gain = typecast(s2.raw_data,'double');
                    case 'LffCutoff'
                        obj.lff_cutoff = typecast(s2.raw_data,'double');
                    case 'NotchCutoff'
                        obj.notch_cutoff = typecast(s2.raw_data,'double');
                    case 'Range'
                        %?? Not 2 elements? not single?
                        %double looks good ...
                        obj.range = typecast(s2.raw_data,'double');
                    case 'Resolution'
                        obj.resolution = double(typecast(s2.raw_data,'int32'));
                        if s2.type ~= 0
                            keyboard
                        end
                    case 'RightDisplayGain'
                        obj.resolution = double(typecast(s2.raw_data,'uint32'));
                    case 'SampFreq'
                        obj.samp_freq = typecast(s2.raw_data,'double');
                    case 'SequenceNumber'
                        obj.sequence_number = double(typecast(s2.raw_data,'uint32'));
                    case 'SetObjId'
                        obj.set_obj = s2.raw_data;
                    case 'Timebase'
                        obj.timebase = typecast(s2.raw_data,'double');
                    case 'Timestamp'
                        obj.timestamp = epworks.utils.processType3time(s2.raw_data);
                    case 'TraceObjId'
                        obj.trace_obj = s2.raw_data;
                    case 'TriggerDelay'
                        obj.trigger_delay = typecast(s2.raw_data,'double');
                    case 'Visible'
                        obj.visible = double(typecast(s2.raw_data,'uint32'));
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end