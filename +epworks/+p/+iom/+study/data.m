classdef data < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.iom.study.data
    %
    %   See Also
    %   --------
    %   epworks.p.iom.study

    properties
        acquisition_instrument
        acquisition_time_zone

        %hours
        tz_offset %hours

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

        %TODO: is object
        performed_procedures
        product_version_high
        product_version_low

        %TODO: is object
        remotes
        request_update_initialization
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
                        %Guessing that the first bit is 300 minutes diff
                        %
                        % JAH: 6/24/2025 - bug fix, time zone fixed

                        %First 4 bytes are for the standard time
                        %
                        %   

                        obj.acquisition_time_zone = char(value(5:2:end));
                        %This is no longer used and is changed in the
                        %parent
                        temp = -1*double(typecast(value(1:4),'uint32'))/60;
                        obj.tz_offset = hours(temp);
                        %r.time_offset;
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
                        %this is a string
                        %e.g., '20220614:2138Z'
                        obj.end_time = value;
                    case 'FileName'
                        obj.file_name = value;
                    case 'IOMUIVersionHigh'
                        obj.iom_ui_version_high = value;
                    case 'IOMUIVersionLow'
                        obj.iom_ui_version_low = value;
                    case 'LocalInitializationComplete'
                        obj.local_initialization_complete = value;
                        r.logUnknownID('study_data_LocalInitializationComplete',value);
                    case 'ModificationTime'
                        obj.modification_time = epworks.utils.processType1time(value);
                    case 'PerformedProcedures'
                        %TODO: This is an object
                        obj.performed_procedures = value;
                    case 'ProductVersionHigh'
                        obj.product_version_high = value;
                    case 'ProductVersionLow'
                        obj.product_version_low = value;
                    case 'Remotes'
                        %TODO: This is an object
                        obj.remotes = value;
                    case 'RequestUpdateInitialization'
                        obj.request_update_initialization = value;
                        r.logUnknownID('study_data_RequestUpdateInitialization',value);
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end