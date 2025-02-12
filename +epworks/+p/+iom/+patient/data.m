classdef data  < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.iom.patient.data

    properties
        anesthesiologist
        case_id
        connections
        designated_reviewer_label
        diagnosis
        end_time
        %TODO: object
        end_time_exp
        facility
        info
        instrumentation_used
        insurance
        is_new
        is_remote
        is_review
        notes
        other_staff
        patient_room_time_in
        patient_room_time_out
        schema
        social_insurance
        start_time
        start_time_exp
        surgeon
        surgical
        tech
        %object
        time_in_exp
        %object
        time_out_exp
    end

    methods
        function obj = data(s,r)
            r.logObject(obj);
            p = s.props;
            fn = fieldnames(p);
            for i = 1:length(fn)
                cur_name = fn{i};
                value = p.(cur_name);
                switch cur_name
                    case 'Anesthesiologist'
                        obj.anesthesiologist = value;
                    case 'CaseID'
                        obj.case_id = value;
                    case 'Connections'
                        obj.connections = epworks.p.iom.patient.data.connections(value,r);
                    case 'DesignatedReviewerLabel'
                        obj.designated_reviewer_label = value;
                    case 'Diagnosis'
                        obj.diagnosis = value;
                    case 'EndTime'
                        obj.end_time = epworks.utils.processType1time(value);
                    case 'EndTimeExp'
                        %todod object
                        obj.end_time_exp = value;
                    case 'Facility'
                        obj.facility = value;
                    case 'Info'
                        obj.info = epworks.p.iom.patient.data.info(value,r);
                    case 'Instrumentation_Used'
                        obj.instrumentation_used = value;
                    case 'Insurance'
                        obj.insurance = value;
                    case 'IsNew'
                        obj.is_new = value;
                    case 'IsRemote'
                        obj.is_remote = value;
                    case 'IsReview'
                        obj.is_review = value;
                    case 'Notes'
                        obj.notes = value;
                    case 'Other_Staff'
                        obj.other_staff = value;
                    case 'Patient_Room_Time_In'
                        obj.patient_room_time_in = epworks.utils.processType1time(value);
                    case 'Patient_Room_Time_Out'
                        obj.patient_room_time_out = epworks.utils.processType1time(value);
                    case 'Schema'
                        obj.schema = value;
                    case 'Social_Insurance'
                        obj.social_insurance = value;
                    case 'StartTime'
                        obj.start_time = epworks.utils.processType1time(value);
                    case 'StartTimeExp'
                        obj.start_time_exp = value;
                    case 'Surgeon'
                        obj.surgeon = value;
                    case 'Surgical'
                        obj.surgical = value;
                    case 'Tech'
                        obj.tech = value;
                    case 'TimeInExp'
                        %TODO object
                        obj.time_in_exp = value;
                    case 'TimeOutExp'
                        obj.time_out_exp = value;
                    otherwise
                        keyboard
                end
            end
            
        end
    end
end