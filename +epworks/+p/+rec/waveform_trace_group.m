classdef waveform_trace_group < handle
    %
    %   Class:
    %   epworks.p.rec.waveform_trace_group

    properties
        trace_id
        waveforms
        merged_waveforms
        n_unique_file_ids
    end

    methods
        function obj = waveform_trace_group(w)
            %
            %   Inputs
            %   ------
            %   w : epworks.p.rec.waveform

            obj.trace_id = w(1).trace_id;
            obj.waveforms = w;
            obj.merged_waveforms = w.getMerged();

            file_ids = [w.file_id];
            obj.n_unique_file_ids = length(unique(file_ids));

        end
    end
end