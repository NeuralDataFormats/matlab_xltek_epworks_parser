classdef applied_montage_key_tree < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.test.data.settings.eeg.applied_montage_key_tree
    %
    %   See Also
    %   --------
    %   epworks.p.test.data.settings.eeg
    %
    %   Parent: epworks.p.test.data.settings.eeg

    properties
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
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'Bin0'
                        obj.bin0 = epworks.p.iom.test.data.settings.eeg.applied_montage_key_tree.bin(value,r);
                    case 'Bin1'
                        obj.bin1 = epworks.p.iom.test.data.settings.eeg.applied_montage_key_tree.bin(value,r);
                    case 'Bin2'
                        obj.bin2 = epworks.p.iom.test.data.settings.eeg.applied_montage_key_tree.bin(value,r);
                    case 'Bin3'
                        obj.bin3 = epworks.p.iom.test.data.settings.eeg.applied_montage_key_tree.bin(value,r);
                    case 'Bin4'
                        obj.bin4 = epworks.p.iom.test.data.settings.eeg.applied_montage_key_tree.bin(value,r);
                    case 'Bin5'
                        obj.bin5 = epworks.p.iom.test.data.settings.eeg.applied_montage_key_tree.bin(value,r);
                    case 'ChanNames'
                        %Complex data type, first example was null
                        obj.chan_names = value;
                    case 'Channels'
                        obj.channels = epworks.p.iom.test.data.settings.eeg.applied_montage_key_tree.channel.initialize(value,r);
                    case 'FileName'
                        obj.file_name = value;
                    case 'HalfMontageChannels'
                        %Same format as channels?
                        obj.half_montage_channels = epworks.p.iom.test.data.settings.eeg.applied_montage_key_tree.half_montage_channel.initialize(value,r);
                    case 'InputChannels'
                        obj.half_montage_channels = epworks.p.iom.test.data.settings.eeg.applied_montage_key_tree.input_channel.initialize(value,r);
                    case 'MontageName'
                        obj.montage_name = value;
                    case 'MontageType'
                        obj.montage_type = value;
                    case 'Name'
                        obj.name = value;
                    case 'Schema'
                        obj.schema = value;
                    case 'SpecDecimation'
                        obj.spec_decimation = value;
                    case 'SpecNumBins'
                        obj.spec_num_bins = value;   
                    case 'SpecResolution'
                        obj.spec_resolution = value;   
                    case 'SpecType'
                        obj.spec_type = value;  
                    case 'Type'
                        obj.type = value;
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end