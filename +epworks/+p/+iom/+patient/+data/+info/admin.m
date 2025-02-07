classdef admin < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.patient.data.info.admin

    properties
        s
        billing_id
        billing_id_label
        category
        category_label
        chart_no
        chart_no_label
        id
        id_label
        ref_phys
        ref_phys_label
        telephone
        telephone_label
        ward
        ward_label
    end

    methods
        function obj = admin(s,r)
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'BillingID'
                        obj.billing_id = value;
                    case 'BillingIDLabel'
                        obj.billing_id_label = value;
                    case 'Category'
                        obj.category = value;
                    case 'CategoryLabel'
                        obj.category_label = value;
                    case 'ChartNo'
                        obj.chart_no = value;
                    case 'ChartNoLabel'
                        obj.chart_no_label = value;
                    case 'ID'
                        obj.id = value;
                        r.logID(obj,obj.id);
                    case 'IDLabel'
                        obj.id_label = value;
                    case 'RefPhys'
                        obj.ref_phys = value;
                    case 'RefPhysLabel'
                        obj.ref_phys_label = value;
                    case 'Telephone'
                        obj.telephone = value;
                    case 'TelephoneLabel'
                        obj.telephone_label = value;
                    case 'Ward'
                        obj.ward = value;
                    case 'WardLabel'
                        obj.ward_label = value;

                    otherwise
                        keyboard
                end
            end
            
        end
    end
end