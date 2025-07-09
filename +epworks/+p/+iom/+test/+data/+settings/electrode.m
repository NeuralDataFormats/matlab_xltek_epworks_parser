classdef electrode < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.iom.test.data.settings.electrode

    properties
        eeg_site_guid
        id
        location
        phys_electrode
        phys_name
    end

    methods (Static)
        function objs = initialize(s,r)
            %
            %   objs = epworks.p.test.data.settings.cursor_calc.initialize(s,r)

            a = s.array;
            n_children = length(a);
            objs = cell(1,n_children);
            for i = 1:n_children
                s2 = a{i};
                obj = epworks.p.iom.test.data.settings.electrode(s2,r);
                objs{i} = obj;
            end
            objs = [objs{:}];
        end
    end

    methods
        function obj = electrode(s,r)
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'EEGSiteGUID'
                        obj.eeg_site_guid = value;
                        %Is this the owner?
                        %r.logID(obj,obj.eeg_site_guid);
                    case 'ID'
                        obj.id = value;
                        r.logID(obj,obj.id);
                    case 'Location'
                        obj.location = value;
                    case 'PhysElectrode'
                        obj.phys_electrode = value;
                    case 'PhysName'
                        obj.phys_name = value;
                    otherwise
                        safe_name = epworks.utils.getSafeVariableName(cur_name);
                        obj.unhandled_props.(safe_name) = value;
                end
            end

            r.logUnhandledProps(obj);
            
        end
    end
end