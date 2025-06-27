classdef merged_waveform < handle
    %
    %   Class:
    %   epworks.p.rec.merged_waveform
    %
    %   See Also
    %   --------
    %   epworks.p.rec.waveform

    properties
        data
        first_id
        fs
        t0
    end

    properties (Dependent)
        time
    end

    methods
        function value = get.time(obj)
            n_samps_m1 = length(obj.data)-1;
            value = obj.t0 + seconds((0:n_samps_m1)/obj.fs);
        end
    end

    methods
        function obj = merged_waveform(waveforms)
            obj.data = [waveforms.data];
            obj.first_id = waveforms(1).id;
            obj.fs = waveforms(1).fs;
            obj.t0 = waveforms(1).timestamp;
        end
    end
end