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
        active_waveform_obj
        test_obj
        group_obj
        o_chan
        origin_x
        origin_y
        last_recorded_set_number

        %Some enumeration
        state
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
                        obj.create_time = epworks.utils.processType3time(value);
                    case 'GroupObjId'
                        obj.group_obj = value;
                    case 'Name'
                        obj.name = value;
                    case 'OChanId'
                        obj.o_chan = value;
                    case 'OriginX'
                        %u32?
                        obj.origin_x = value;
                    case 'OriginY'
                        obj.origin_y = value;
                    case 'State'
                        obj.state = value;
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
