classdef data < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.iom.study.data

    properties
        acquisition_instrument
        acquisition_time_zone
        comm_channel_handle
        creation_time
        creator
        duration
        eeg_no_label
        end_time
        file_name
        iom_ui_version_high
        iom_ui_version_low
        local_initialization_complete
        modification_time
        performed_procedures
        product_version_high
        product_version_low
    end

    methods
        function obj = data(s,r)
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'AcquisitionInstrument'
                        obj.acquisition_instrument = value;
                    case 'AcquisitionTimeZone'
                        obj.acquisition_time_zone = value;
                    case 'CommChannelHandle'
                        obj.comm_channel_handle = value;
                    case 'CreationTime'
                        obj.creation_time = epworks.utils.processType1time(value);
                    case 'Creator'
                        obj.creator = value;
                    case 'Duration'
                        obj.duration = value;
                    case 'EegNoLabel'
                        obj.eeg_no_label = value;
                    case 'EndTime'
                        obj.end_time = value;
                    case 'FileName'
                        obj.file_name = value;
                    case 'IOMUIVersionHigh'
                        obj.iom_ui_version_high = value;
                    case 'IOMUIVersionLow'
                        obj.iom_ui_version_low = value;
                    case 'LocalInitializationComplete'
                        obj.local_initialization_complete = value;
                    case 'ModificationTime'
                        obj.modification_time = value;
                    case 'PerformedProcedures'
                        obj.performed_procedures = value;
                    case 'ProductVersionHigh'
                        obj.product_version_high = value;
                    case 'ProductVersionLow'
                        obj.product_version_low = value;
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end