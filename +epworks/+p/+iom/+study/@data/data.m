classdef data < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.iom.study.data

    properties

        todo = 'Still need to finish this class'

    end

    methods
        function obj = data(s,r)
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