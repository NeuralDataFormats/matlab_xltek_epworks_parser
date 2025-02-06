classdef channel < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.iom.test.data.settings.eeg.applied_montage_key_tree.channel

    properties (Hidden)
        id_props = {'group_id','i_channel_id','i_input_id','i_site_id',...
            'i_type_id','o_channel_id','o_type_id'}
    end

    properties
        chan_index
        calibration
        chan_proc_type
        chan_type
        color
        from_name
        gain
        group_id
        hff_cutoff
        i_channel_id
        i_input_id
        i_site_id
        i_type_id
        lff_cutoff
        notch_cutoff
        o_channel_id
        o_type_id
        positive_up
        sampling_freq
        set
        to_name
    end

    methods (Static)
        function objs = initialize(a,r)
            %
            %   objs = epworks.p.test.data.settings.cursor_calc.initialize(s,r)

            n_children = length(a);
            objs = cell(1,n_children);
            for i = 1:n_children
                s2 = a{i};
                obj = epworks.p.iom.test.data.settings.eeg.applied_montage_key_tree.channel(s2,r);
                objs{i} = obj;
            end
            objs = [objs{:}];
        end
    end
    methods
    function obj = channel(s,r)
            r.logObject(obj);
            p = s.props;
            %Note, the object is chan_index and then the channel
            %itself. Rather than nesting we just grab the index then 
            %the channel
            obj.chan_index = p.ChanIndex;
            p = p.Channel.props;
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
                    case 'Calibration'
                        obj.calibration = value;
                    case 'ChanProcType'
                        obj.chan_proc_type = value;
                    case 'ChanType'    
                        obj.chan_type = value;
                    case 'Color'       
                        obj.color = epworks.utils.getColor(value);
                    case 'From_Name'   
                        obj.from_name = value;
                    case 'Gain' 
                        obj.gain = value;
                    case 'GroupId'   
                        obj.group_id = value;
                    case 'HffCutoff'  
                        obj.hff_cutoff = value;
                    case 'IChannelId' 
                        obj.i_channel_id = value;
                    case 'IInputId'   
                        obj.i_input_id = value;
                    case 'ISiteId'  
                        obj.i_site_id = value;
                    case 'ITypeId'    
                        obj.i_type_id = value;
                    case 'LffCutoff'   
                        obj.lff_cutoff = value;
                    case 'NotchCutoff' 
                        obj.notch_cutoff = value;
                    case 'OChannelId'  
                        obj.o_channel_id = value;
                    case 'OTypeId'    
                        obj.o_type_id = value;
                    case 'PositiveUp' 
                        obj.positive_up = value;
                    case 'SamplingFreq'
                        obj.sampling_freq = value;
                    case 'Set'        
                        obj.set = value;
                    case 'To_Name'     
                        obj.to_name = value;
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end

function h__getID(bytes,name)
    I = strfind(bytes,uint8(name));
    out = bytes()
end
function h__getBytes(name,n_bytes)

end

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
