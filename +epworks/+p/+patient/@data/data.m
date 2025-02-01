classdef data  < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.eeg_waveform.data

    properties
        s

        connections
        designated_reviewer_label
        info
        insurance
        is_new
        schema
        social_insurance
    end

    methods
        function obj = data(s,r)
            obj.s = s;
            n_children = length(s.child_indices);
            for i = 1:n_children
                index = s.child_indices(i);
                r.processed(index) = true;
                s2 = r.getStruct(index);

                switch s2.name
                    %{
                    case 'AudioVolume'
                        obj.audio_volume = double(typecast(s2.raw_data,'uint32'));
                    case 'Color'
                        obj.color = double(s2.raw_data);
                    case 'HffCutoff'
                        obj.hff_cutoff = typecast(s2.raw_data,'double');
                    case 'IsAlarmedWave'
                        obj.is_alarmed_wave = double(typecast(s2.raw_data,'uint32'));
                    %}

                    case 'Connections'
                        obj.connections = epworks.p.patient.data.connections(s2,r);
                        r.logObject(obj.connections,index);
                    case 'DesignatedReviewerLabel'
                    case 'Info'
                        obj.info = epworks.p.patient.data.info(s2,r);
                        r.logObject(obj.info,index);
                    case 'Insurance'
                    case 'IsNew'
                    case 'Schema'
                    case 'Social Insurance'
                   
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end