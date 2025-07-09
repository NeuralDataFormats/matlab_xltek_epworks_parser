classdef half_montage_channel < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.iom.test.data.settings.eeg.applied_montage_key_tree.half_montage_channel

    properties (Hidden)
        id_props = {}
    end

    properties
        coefficients
        name
        read_only
    end

    methods (Static)
        function objs = initialize(a,r)
            %
            %   objs = epworks.p.test.data.settings.cursor_calc.initialize(s,r)

            n_children = length(a);
            objs = cell(1,n_children);
            for i = 1:n_children
                s2 = a{i};
                obj = epworks.p.iom.test.data.settings.eeg.applied_montage_key_tree.half_montage_channel(s2,r);
                objs{i} = obj;
            end
            objs = [objs{:}];
        end
    end
    methods
    function obj = half_montage_channel(s,r)
            r.logObject(obj);
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
                    case 'Coefficients'
                        obj.coefficients = value;
                    case 'Name'
                        obj.name = value;
                    case 'Readonly'    
                        obj.read_only = value;
                    otherwise
                        safe_name = epworks.utils.getSafeVariableName(cur_name);
                        obj.unhandled_props.(safe_name) = value;
                end
            end

            r.logUnhandledProps(obj);
            
        end
    end
end

% function h__getID(bytes,name)
%     I = strfind(bytes,uint8(name));
%     out = bytes()
% end
% function h__getBytes(name,n_bytes)
% 
% end

% -1 : no data?
%       - seen for age and birthdate for a file, which was accurate
%         
%  0 : length 4, interpretation seems to vary
%       - logical
%       - single
%       - etc.
%  TODO: finish - see raw_object
%  1 : double? - definitely double, not sure if anything else as
%       well
%  2 : string
%  3 : 
%       - id, 16 bytes
%       - times (type 3 format)
%  4 : complex object types?
%  5 : objects
%       - things that hold more things
%  6 : GUIDs and HistoryTraces ....
