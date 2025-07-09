classdef plot_helper
    %
    %   Class:
    %   epworks.utils.plot_helper

    properties

    end

    methods (Static)
        function [x,s] = getXData(data,t0,fs,x_option,x_multi,s,chan_name)
            %
            %   Inputs
            %   ------
            %   data
            %   t0
            %   fs
            %   x_option
            %       - samples (zero)
            %       - samples_extend
            %       - datetime (preserve)
            %       - duration (preserve)
            %       - duration_zero
            %       - duration_extend
            %       - numeric (zero)
            %       - numeric_extend
            %   x_multi
            %       - zero
            %       - preserve
            %       - extend
            %
            %   s : struct
            %   chan_name : this should be safe
            %
            %   Outputs
            %   -------
            %   x
            %   s : struct
            %       .(chan_name) - value is last element of the time array
            %   

            %string {mustBeMember(options.time_units, ["samples","datetime", "duration", "numeric"])} = "datetime"

            n_m_1 = length(data)-1;
            x = t0 + seconds((0:n_m_1)/fs);
            switch x_option
                case "samples"
                    x = 1:length(data);
                    switch x_multi
                        case "zero"
                            %do nothing
                        case "preserve"
                            if isfield(s,chan_name)
                                error('Not yet implemented')
                            end
                        case "extend"
                            if isfield(s,chan_name)
                                x = x + s.(chan_name).last_x;
                            end
                        otherwise
                            error('Not yet implemented')
                    end
                case "datetime"
                    %done
                case "duration"
                    %Without this the labeling was not great
                    x = x - x(1);
                    if x(end) < seconds(1)
                        x = milliseconds(milliseconds(x));
                    end
                case "numeric"
                    x = seconds(x - x(1));
            end

            if isfield(s,chan_name)
                %t0 is already defined
                s.(chan_name).last_x = x(end);
            else
                s2 = struct;
                s2.last_x = x(end);
                s2.t0 = t0;
                s.(chan_name) = s2;
            end

        end
    end
end