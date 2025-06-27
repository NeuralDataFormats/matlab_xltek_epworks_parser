classdef table_info < handle
    %
    %   Class:
    %   epworks.main.table_info

    properties
        group
        eeg_waveforms
        freerun_waveforms
        triggered_waveforms
    end

    methods
        function obj = table_info(main_obj)

            groups = main_obj.groups;
            n_groups = length(groups);
            %TODO: Move this as method to group class
            index = (1:n_groups)';
            name = string({groups.name}');
            is_eeg_group = [groups.is_eeg_group]';
            state = [groups.state]';
            signal_type = [groups.signal_type]';
            sweeps_per_avg = [groups.sweeps_per_avg]';
            trigger_delay = [groups.trigger_delay]';
            n_sets = zeros(n_groups,1);
            n_traces = zeros(n_groups,1);
            for i = 1:n_groups
                n_sets(i) = length(groups(i).sets);
                n_traces(i) = length(groups(i).traces);
            end

            obj.group = table(index,name,n_sets,n_traces,is_eeg_group,state,signal_type,sweeps_per_avg,trigger_delay);

            obj.triggered_waveforms = h__getWaveformInfo(main_obj.triggered_waveforms);
            obj.freerun_waveforms = h__getWaveformInfo(main_obj.freerun_waveforms);
            obj.eeg_waveforms = h__getWaveformInfo(main_obj.eeg_waveforms);

        end
    end
end

function info = h__getWaveformInfo(s)
    if isempty(s)
        info = table([], [], [], [], 'VariableNames', {'index', 'name', 't0','n_data'});
        return
    end

    index = (1:length(s))';
    name = string({s.name}');
    t0 = NaT(length(name),1);
    n_data = zeros(length(name),1);
    for i = 1:length(name)
        if ~isempty(s(i).data)
            t0(i) = s(i).data.t0(1);
            n_data(i) = length(s(i).data.data);
        end
    end

    info = table(index,name,t0,n_data);
end