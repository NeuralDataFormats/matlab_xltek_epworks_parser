classdef freerun_waveform < epworks.objects.result_object
    %
    %   Class:
    %   epworks.objects.freerun_waveform
    %
    %   See Also
    %   --------
    %   epworks.main
    %   epworks.objects.trace
    %   epworks.objects.eeg_waveform
    %   ewworks.p.iom.freerun_waveform

    properties (Hidden)
        id_props = {'parent','trace'}
    end

    properties
        name
        group_name
        lff_cutoff
        hff_cutoff
        notch_cutoff
        color
        parent
        trace
        trace_id
        data epworks.objects.signal

        o_chan
        i_chan
        n_snippets
    end

    methods
        function obj = freerun_waveform(p_main,p,logger)
            obj = obj@epworks.objects.result_object(p,logger);
            obj.name = p.data.trace_obj.name;
            obj.lff_cutoff = p.data.lff_cutoff;
            obj.hff_cutoff = p.data.hff_cutoff;
            obj.notch_cutoff = p.data.notch_cutoff;
            obj.color = p.data.color;

            obj.parent = p.parent.id;
            obj.trace = p.data.trace_obj.id;
            %This we will not override
            obj.trace_id = obj.trace;

            wtg = p_main.getWaveformTraceGroupFromTraceID(obj.trace);
            if ~isempty(wtg)
                obj.data = epworks.objects.signal(wtg,p.data.trace_obj.name);
            end
        end
        function obj = getByName(objs,name,options)
            %
            %   obj = getByName(objs,name,options)
            %
            %   Inputs
            %   ------
            %   name :
            %       Name to match
            %
            %   Optional Inputs
            %   ---------------
            %   group_name :
            %       If specified also filters on the group name

            arguments
                objs
                name
                options.group_name = '';
            end
            names = {objs.name};
            mask = strcmpi(names,name);
            if ~isempty(options.group_name)
                group_names = {objs.group_name};
                mask = mask & strcmpi(group_names,options.group_name);
            end
            I = find(mask);
            if isempty(I)
                error('Unable to find requested channel: %s',name)
            elseif length(I) > 2
                %This may happen if the group name is not specified
                error('More than 1 match for channel: %s',name);
            else
                obj = objs(I);
            end
        end
    end
    methods (Hidden)
        function processPostLinking(objs)
            for i = 1:length(objs)
                obj = objs(i);
                obj.group_name = obj.trace.group_name;
                obj.o_chan = obj.trace.o_chan;
                obj.i_chan = obj.trace.i_chan;
                if ~isempty(obj.data)
                    obj.n_snippets = obj.data.n_snippets;
                end
            end
        end
        function data = debugWaveformStruct(obj)
            w = [];
            for i = 1:length(obj)
                w = [w obj(i).data.p.waveforms];
            end
            data = vertcat(w.first_600);
        end
    end
end