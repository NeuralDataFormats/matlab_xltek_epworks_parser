classdef personal  < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.patient.data.info.personal

    properties
        s

        %TODO
    end

    methods
        function obj = personal(s,r)
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'Age'
                    case 'AgeLabel'
                    case 'BirthDate'
                    case 'BirthDateLabel'
                    case 'Gender'
                    case 'GenderLabel'
                    case 'Height'
                    case 'HeightFeet'
                    case 'HeightInches'
                    case 'HeightMetric'
                    case 'Weight'
                    case 'WeightMetric'
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end