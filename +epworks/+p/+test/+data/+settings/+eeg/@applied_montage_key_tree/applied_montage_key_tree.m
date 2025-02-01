classdef applied_montage_key_tree
    %
    %   Class:
    %   epworks.p.test.data.settings.eeg.applied_montage_key_tree

    properties
        s

        bin0
        bin1
        bin2
        bin3
        bin4
        bin5
        chan_names
        channels
        file_name
        half_montage_channels
        input_channels
        montage_name
        montage_type
        name
        schema
        spec_decimation
        spec_num_bins
        spec_resolution
        spec_type
        type
    end

    methods
        function obj = applied_montage_key_tree(s,r)
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

                    case 'Bin0'
                        obj.bin0 = epworks.p.test.data.settings.eeg.applied_montage_key_tree.bin(s2,r);
                    case 'Bin1'
                        obj.bin1 = epworks.p.test.data.settings.eeg.applied_montage_key_tree.bin(s2,r);
                    case 'Bin2'
                        obj.bin2 = epworks.p.test.data.settings.eeg.applied_montage_key_tree.bin(s2,r);
                    case 'Bin3'
                        obj.bin3 = epworks.p.test.data.settings.eeg.applied_montage_key_tree.bin(s2,r);
                    case 'Bin4'
                        obj.bin4 = epworks.p.test.data.settings.eeg.applied_montage_key_tree.bin(s2,r);
                    case 'Bin5'
                        obj.bin5 = epworks.p.test.data.settings.eeg.applied_montage_key_tree.bin(s2,r);
                    case 'ChanNames'
                    case 'Channels'
                    case 'FileName'
                    case 'HalfMontageChannels'
                    case 'InputChannels'
                    case 'MontageName'
                    case 'MontageType'
                    case 'Name'
                    case 'Schema'
                    case 'SpecDecimation'
                    case 'SpecNumBins'
                    case 'SpecResolution'
                    case 'SpecType'
                    case 'Type'

                    otherwise
                        keyboard
                end
            end
            
        end
    end
end