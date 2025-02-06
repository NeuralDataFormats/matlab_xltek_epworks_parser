classdef signal < handle
    %
    %   Class:
    %   epworks.objects.signal
    %
    %   See Also
    %   --------
    %   epworks.objects.trace

    properties
        name
        p
        t0
        data
        n_snippets
        fs
    end

    methods
        function obj = signal(p_rec,name)
            obj.name = name;
            obj.p = p_rec;

            w = p_rec.merged_waveforms;

            obj.t0 = [w.t0];
            obj.data = {w.data};
            obj.n_snippets = length(obj.data);
            obj.fs = p_rec.fs;
        end
        function plot(obj,varargin)

            in.color = [];
            in = epworks.sl.in.processVarargin(in,varargin);
                
            hold_state = ishold(gca);

            hold on;
            for i = 1:obj.n_snippets
                y = obj.data{i};
                t = obj.getTime(i);
                plot(t,y)
            end
            if ~hold_state
                hold off;
            end
            
        end
        function time = getTime(obj,index)
            time = obj.p.merged_waveforms(index).time;
        end
    end
end