classdef trace < epworks.objects.result_object
    %
    %   Class:
    %   epworks.objects.trace
    %
    %   See Also
    %   --------
    %   epworks.main
    %   epworks.p.iom.trace.data

    properties (Hidden)
        id_props = {'parent'}
    end

    properties
        name
        parent
        group_name
        state

        %Note, these don't apply for EEG groups. You need to use the
        %montage layout info instead.
        origin_x
        origin_y

        eeg_waveforms
        triggered_waveforms
        freerun_waveforms

        o_chan
        i_chan
    end

    methods
        function obj = trace(p_main,p,logger)
            %
            %   Inputs
            %   ------
            %   p_main : epworks.parse.main
            
            obj = obj@epworks.objects.result_object(p,logger);
            obj.p = p;
            obj.name = p.name;
            obj.state = p.data.state;
            obj.origin_x = p.data.origin_x;
            obj.origin_y = p.data.origin_y;

            obj.parent = p.parent.id;

            obj.o_chan = p.data.o_chan;
            if ~isempty(obj.o_chan)
                obj.i_chan = p.data.o_chan.to;
            end
        end
        function processPostLinking(objs,test)
            %
            %   - populate parent name
            


            for i = 1:length(objs)
                obj = objs(i);
                obj.group_name = obj.parent.name;
            end
        end
    end
end