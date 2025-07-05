classdef merged_waveform < handle
    %
    %   Class:
    %   epworks.p.rec.merged_waveform
    %
    %   See Also
    %   --------
    %   epworks.p.rec.waveform

    properties
        waveforms
        data
        first_id
        fs
        t0
        tend
        trace_id
        ochan_id
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
            obj.waveforms = waveforms;
            obj.data = [waveforms.data];
            obj.first_id = waveforms(1).id;
            obj.fs = waveforms(1).fs;
            obj.t0 = waveforms(1).timestamp;
            n_samps_m1 = length(obj.data)-1;
            obj.tend = obj.t0 + seconds(n_samps_m1/obj.fs);
            obj.trace_id = obj.waveforms(1).trace_id;
            obj.ochan_id = obj.waveforms(1).ochan_id;
        end
    end
end