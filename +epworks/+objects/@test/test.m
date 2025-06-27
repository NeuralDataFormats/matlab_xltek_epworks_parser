classdef test < epworks.objects.result_object
    %
    %   Class:
    %   epworks.objects.group
    %
    %   See Also
    %   --------
    %   epworks.main
    %   epworks.objects.trace

    properties (Hidden)
        %id_props = {'parent','groups'}
        id_props = {'groups'}
    end

    properties
        creation_time
        state
        stimbox_connected
        test_set_obj_count
        
        %This may change ...
        raw_settings
        settings

        %   points to study, NYI
        %parent
        groups
    end

    methods
        function obj = test(p_main,p,logger)
            %
            %   Inputs
            %   ------
            %   p : epworks.p.iom.test

            obj = obj@epworks.objects.result_object(p,logger);
            obj.creation_time = p.data.creation_time;
            obj.state = p.data.state;
            obj.stimbox_connected = p.data.stimbox_connected;
            obj.test_set_obj_count = p.data.test_set_obj_count;

            obj.raw_settings = p.data.settings;
            obj.settings = epworks.objects.test.settings(p_main,p.data.settings,logger);

            %obj.parent = p.parent.id;
            obj.groups = {p.groups.id};
        end
    end
end