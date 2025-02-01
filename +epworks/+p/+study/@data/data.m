classdef data
    %
    %   Class:
    %   epworks.p.eeg_waveform.data

    properties
        s

        % set_number
        % group_obj_id
        % is_active
        % num_accepted
    end

    methods
        function obj = data(s,r)
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

                    case 'AcquisitionInstrument'
                    case 'AcquisitionTimeZone'
                    case 'CommChannelHandle'
                    case 'CreationTime'
                    case 'Creator'
                    case 'Duration'
                    case 'EegNoLabel'
                    case 'EndTime'
                    case 'FileName'
                    case 'IOMUIVersionHigh'
                    case 'IOMUIVersionLow'
                    case 'LocalInitializationComplete'
                    case 'ModificationTime'
                    case 'PerformedProcedures'
                    case 'ProductVersionHigh'
                    case 'ProductVersionLow'

                    otherwise
                        keyboard
                end
            end
            
        end
    end
end