classdef signal < handle
    %
    %   Class:
    %   epworks.objects.signal
    %
    %   This isn't actually an object in the parse tree. It is created
    %   by the trace and the data come from the .REC files.
    %
    %   See Also
    %   --------
    %   epworks.objects.trace

    properties
        name
        p
        
        
        t0 %Start times of each dataset

        data %cell array, raw data
        
        n_snippets

        fs
    end

    methods
        function obj = signal(p_trace_waveform_group,name)
            %
            %   s = epworks.objects.signal(p_trace_waveform_group,name)
            %
            %   Inputs
            %   ------
            %   p_trace_waveform_group : epworks.p.rec.waveform_trace_group
            %
            %
            %   See Also
            %   ---------
            %   epworks.p.rec.waveform_trace_group
            %
            %   
            
            obj.name = name;
            obj.p = p_trace_waveform_group;
            
            mw = obj.p.merged_waveforms;

            fs_all = [mw.fs];
            if ~all(fs_all == fs_all(1))
                error('assumption violated')
            end

            obj.t0 = [mw.t0];
            obj.data = {mw.data};
            obj.n_snippets = length(obj.data);
            obj.fs = fs_all(1);
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