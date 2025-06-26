classdef data < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.iom.trace.data
    %
    %   See Also
    %   --------
    %   epworks.p.trace.children

    properties (Hidden)
        id_props = {'active_waveform_obj','test_obj','group_obj','o_chan'}
    end

    properties
        name
        create_time
        %create_time_part2
        active_waveform_obj
        test_obj
        group_obj
        max_num_historical_trigs
        o_chan
        origin_x = NaN
        origin_y = NaN
        private_request
        last_recorded_set_number
        random_guid
        raw_sweeps_mode
        rejection_originator
        %Some enumeration
        state
        st_live_num_accepted
        st_live_timestamp
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
                    case 'ActiveWaveformObjId'
                        obj.active_waveform_obj = value;
                    case 'CreateTime'
                        obj.create_time = epworks.utils.processType3time(value(1:8));
                        if length(value) > 8
                            obj.create_time_part2 = double(typecast(value(9:16),'int32'));
                        end
                    case 'GroupObjId'
                        obj.group_obj = value;
                    case 'MaxNumHistoricalTriggs'
                        obj.max_num_historical_trigs = value;
                    case 'Name'
                        obj.name = value;
                    case 'OChanId'
                        obj.o_chan = value;
                    case 'OriginX'
                        %u32?
                        obj.origin_x = value;
                    case 'OriginY'
                        obj.origin_y = value;
                    case 'PrivateRequest'
                        obj.private_request = value;
                    case 'RandomGUID'
                        %Do we link this to anything?
                        obj.random_guid = value;
                    case 'RawSweepsMode'
                        obj.raw_sweeps_mode = value;
                    case 'RejectionOriginator'
                        obj.rejection_originator = value;
                    case 'State'
                        obj.state = value;
                    case 'STLiveNumAccepted'
                        obj.st_live_num_accepted = value;
                    case 'STLiveTimestamp'
                        obj.st_live_timestamp = value;
                    case 'TestObjId'
                        obj.test_obj = value;
                    case 'LastRecordedSetNumber'
                        obj.last_recorded_set_number = value;
                    otherwise
                        keyboard
                end
            end
        end
    end
end
