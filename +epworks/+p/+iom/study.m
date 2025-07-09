classdef study < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.study
    %
    %   See Also
    %   --------
    %   epworks.p.iom.patient
    %   epworks.p.iom.test
    %   epworks.p.iom.study.children
    %   epworks.p.iom.study.data
    %
    %   Hierarchy
    %   ----------
    %   - patient
    %       - study
    %           - test

    properties (Hidden)
        id_props = {'parent'}
    end

    properties
        children
        tests

        data

        id

        %u32
        is_root

        %type: id
        parent

        schema

        %string
        type
    end

    methods
        function obj = study(s,r)
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'Children'
                        obj.children = value;
                    case 'Data'
                        obj.data = epworks.p.iom.study.data(value,r);

                        %Fixing of time zone
                        %---------------------------------------------------
                        %
                        %   UNKNOWN: Is there a better way of doing this?
                        %
                        %   Set timezone for the created time then grab
                        %   offset. This approach takes into account
                        %   daylight savings.
                        I = find(obj.data.acquisition_time_zone == char(0),1);
                        
                        input_timezone = obj.data.acquisition_time_zone(1:I-1);

                        % Map to IANA name
                        switch input_timezone
                            case 'Eastern Standard Time'
                                matlab_timezone = 'America/New_York';
                            case 'Central Standard Time'
                                matlab_timezone = 'America/Chicago';
                            otherwise
                                % add more mappings as needed
                                error('Unknown or unsupported time zone name.');
                        end

                        obj.data.creation_time.TimeZone = matlab_timezone;
                        obj.data.tz_offset = tzoffset(obj.data.creation_time);

                    case 'Id'
                        obj.id = value;
                        r.logID(obj,value);
                    case 'IsRoot'
                        obj.is_root = value;
                    case 'Parent'
                        obj.parent = value;
                    case 'Schema'
                        obj.schema = value;
                    case 'Type'
                        obj.type = value;
                    otherwise
                        safe_name = epworks.utils.getSafeVariableName(cur_name);
                        obj.unhandled_props.(safe_name) = value;
                end
            end

            r.logUnhandledProps(obj);
        end
        function childrenToProps(obj,logger)
            class_names = cellfun(@epworks.utils.getShortClassName,obj.children,'un',0);

            mask = class_names == "test";
            obj.tests = [obj.children{mask}];
        end
    end
end