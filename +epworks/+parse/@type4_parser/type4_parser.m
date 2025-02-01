classdef type4_parser < handle
    %
    %   Class:
    %   epworks.parse.type4_parser

    properties
        raw_obj_info
        t
        indices
        objects
        names_observed
    end

    methods
        function obj = type4_parser(raw_obj_info)
            %
            %   obj = epworks.parse.type4_parser(raw_obj_info)
            %
            %   Inputs
            %   ------
            %   raw_obj_info : epworks.raw_object_array

            obj.raw_obj_info = raw_obj_info;
            [obj.t,obj.indices] = raw_obj_info.getTable('type',4);

            temp = unique(obj.t.name);
            obj.names_observed = temp(:);

            n_rows = height(obj.t);
            objs = cell(1,n_rows);
            for i = 1:n_rows
                row = obj.t(i,:);
                s = table2struct(row);
                switch obj.t.name{i}
                    case 'ChanNames'
                        objs{i} = epworks.parse.type4_chan_names(s);
                    case 'Channels'
                        objs{i} = epworks.parse.type4_channels(s);
                    case 'Children'
                        objs{i} = epworks.parse.type4_children(s);
                    case 'HalfMontageChannels'
                        objs{i} = epworks.parse.type4_half_montage_channels(s);
                    case 'InputChannels'
                        objs{i} = epworks.parse.type4_input_channels(s);
                    otherwise
                        error('Unhandled type4 data type: %s',t.name{i});
                end
            end
            obj.objects = objs;
        end
        function out = getObjectsOfType(obj,type)
            mask = strcmp(obj.t.name,type);
            temp = obj.objects(mask);
            if isempty(temp)
                out = [];
            else
                out = [temp{:}];
            end
        end
    end
end