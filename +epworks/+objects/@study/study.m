classdef study < epworks.objects.result_object
    %
    %   Class:
    %   epworks.objects.study
    %
    %   See Also
    %   --------
    %   epworks.main
    %   epworks.p.iom.study
    %   epworks.p.iom.study.data

    properties (Hidden)
        %id_props = {'parent','traces'}
        id_props = {}
    end

    properties

        creation_time

        tz_offset %offset relative to UTC

        acquisition_time_zone
    end

    methods
        function obj = study(p_main,p,logger)
            obj = obj@epworks.objects.result_object(p,logger);

            obj.creation_time = p.data.creation_time;
            obj.tz_offset = p.data.tz_offset;
            temp = p.data.acquisition_time_zone;
            temp(temp < 0) = [];
            obj.acquisition_time_zone = temp;
        end
    end
end