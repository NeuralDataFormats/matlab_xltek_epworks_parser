classdef data < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.iom.trace.data
    %
    %   See Also
    %   --------
    %   epworks.p.trace.children

    properties (Hidden)
        id_props = {'active_waveform_obj_id','test_obj_id','group_obj_id','o_chan_id'}
    end

    properties
        s
        %----------------

        name
        create_time
        active_waveform_obj_id
        test_obj_id
        group_obj_id
        o_chan_id
        origin_x
        origin_y
        last_recorded_set_number

        %Some enumeration
        state
    end

    methods
        function obj = data(s,r)

            p = s.props;
            fn = fieldnames(p);

            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'ActiveWaveformObjId'
                        obj.active_waveform_obj_id = value;
                    case 'CreateTime'
                        obj.create_time = epworks.utils.processType3time(value);
                    case 'GroupObjId'
                        obj.group_obj_id = value;
                    case 'Name'
                        obj.name = value;
                    case 'OChanId'
                        obj.o_chan_id = value;
                    case 'OriginX'
                        %u32?
                        obj.origin_x = value;
                    case 'OriginY'
                        obj.origin_y = value;
                    case 'State'
                        obj.state = value;
                    case 'TestObjId'
                        obj.test_obj_id = value;
                    case 'LastRecordedSetNumber'
                        obj.last_recorded_set_number = value;
                    otherwise
                        keyboard
                end
            end
        end
    end
end
