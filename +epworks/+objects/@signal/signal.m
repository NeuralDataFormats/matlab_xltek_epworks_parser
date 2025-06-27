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
        function obj = signal(p_rec,name)
            obj.name = name;
            obj.p = p_rec;
            
            n_rec_files = length(p_rec);
            mw = cell(1,n_rec_files);
            fs_all = zeros(1,n_rec_files);
            for i = 1:n_rec_files
                mw{i} = p_rec{i}.merged_waveforms;
                fs_all(i) = p_rec{i}.fs;
            end

            if ~all(fs_all == fs_all(1))
                error('Assumption violated')
            end

            w = [mw{:}];

            %w = p_rec.merged_waveforms;

            obj.t0 = [w.t0];
            obj.data = {w.data};
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