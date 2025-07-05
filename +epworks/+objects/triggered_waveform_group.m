classdef triggered_waveform_group < handle
    %
    %   Class:
    %   epworks.objects.triggered_waveform_group
    %
    %   Grouping is by trace
    %
    %   All triggered waveforms from a specific trace are in this object

    properties
        id %[1x16] uint8
        %   This links to the waveform data

        trace_id %[1x16] uint8
        name
        group_name
        t table
        trig_objs epworks.objects.triggered_waveform
    end

    methods
        function obj = triggered_waveform_group(trig_objs)

            %table_properties
            %stim_intensity

            obj.id = trig_objs(1).id;
            obj.trace_id = trig_objs(1).trace.id;
            obj.name = trig_objs(1).name;
            obj.group_name = trig_objs(1).set.parent.name;
            obj.trig_objs = trig_objs;

            %Population of info
            %-----------------------------------------------------------
            t1 = trig_objs;
            stim_intensity = [t1.stim_intensity]';
            trigger_delay = [t1.trigger_delay]';
            is_captured = [t1.is_captured]';
            is_for_review = [t1.is_for_review]';
            is_from_history = [t1.is_from_history]';
            is_grabbed = [t1.is_grabbed]';
            is_rejected = [t1.is_rejected_data]';
            fs = [t1.fs]';
            n_samples = [t1.n_samples]';
            set_number = [t1.set_number]';
            n_children = [t1.n_children]';

            obj.t = table(stim_intensity,trigger_delay,is_captured,...
                is_for_review,is_from_history,is_grabbed,is_rejected,...
                fs,n_samples,set_number,n_children);

            %Sorting by set number
            %--------------------------------------------------------------
            [~,I] = sort(set_number);

            idx = (1:height(obj.t))';
            t2 = table(idx);

            obj.t = [t2 obj.t(I,:)];

            obj.trig_objs = obj.trig_objs(I);

        end
        function objs2 = getByGroupName(objs,group_name)
            group_names = {objs.group_name};
            objs2 = objs(strcmpi(group_names,group_name));
        end
    end
end