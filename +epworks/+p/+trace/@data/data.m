classdef data < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.trace.data
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
            obj.s = s;
            n_children = length(s.child_indices);
            %names = cell(1,n_children);
            %objs = cell(1,n_children);
            for i = 1:n_children
                index = s.child_indices(i);
                r.processed(index) = true;
                s2 = r.getStruct(index);
                %names{i} = s2.name;
                switch s2.name
                    case 'ActiveWaveformObjId'
                        obj.active_waveform_obj_id = s2.raw_data;
                    case 'CreateTime'
                        obj.create_time = epworks.utils.processType3time(s2.raw_data);
                    case 'GroupObjId'
                        obj.group_obj_id = s2.raw_data;
                        %objs{i} = epworks.p.trace.data.group_obj_id(s2,r);
                    case 'Name'
                        obj.name = s2.data_value;
                    case 'OChanId'
                        obj.o_chan_id = s2.raw_data;
                    case 'OriginX'
                        %u32?
                        obj.origin_x = s2.raw_data;
                    case 'OriginY'
                        obj.origin_y = s2.raw_data;
                    case 'State'
                        obj.state = s2.raw_data;
                    case 'TestObjId'
                        obj.test_obj_id = s2.raw_data;
                    case 'LastRecordedSetNumber'
                        obj.last_recorded_set_number = s2.raw_data;
                    otherwise
                        keyboard
                end
            end
        end
    end
end
