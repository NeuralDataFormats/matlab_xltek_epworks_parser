classdef admin < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.patient.data.info.admin

    properties
        s
        billing_id
        billing_id_label
        category_label
        chart_no_label
        id
        id_label
        ref_phys_label
        telephone
        telephone_label
        ward_label
    end

    methods
        function obj = admin(s,r)
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
                    case 'BillingID'
                    case 'BillingIDLabel'
                    case 'CategoryLabel'
                    case 'ChartNoLabel'
                    case 'ID'
                        obj.id = value;
                        r.logID(obj,obj.id);
                    case 'IDLabel'
                    case 'RefPhysLabel'
                    case 'Telephone'
                    case 'TelephoneLabel'
                    case 'WardLabel'

                    otherwise
                        keyboard
                end
            end
            
        end
    end
end