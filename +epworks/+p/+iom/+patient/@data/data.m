classdef data  < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.iom.patient.data

    properties
        s

        connections
        designated_reviewer_label
        info
        insurance
        is_new
        schema
        social_insurance
    end

    methods
        function obj = data(s,r)
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

                    case 'Connections'
                        obj.connections = epworks.p.iom.patient.data.connections(value,r);
                    case 'DesignatedReviewerLabel'
                        obj.designated_reviewer_label = value;
                    case 'Info'
                        obj.info = epworks.p.iom.patient.data.info(value,r);
                    case 'Insurance'
                        obj.insurance = value;
                    case 'IsNew'
                        obj.is_new = value;
                    case 'Schema'
                        obj.schema = value;
                    case 'Social_Insurance'
                        obj.social_insurance = value;
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end