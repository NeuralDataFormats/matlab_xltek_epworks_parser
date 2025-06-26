classdef notes < handle
    %
    %   TODO: Use epworks.objects.result_object instead (low priority)
    %
    %   Class:
    %   epworks.objects.notes
    %
    %   See Also
    %   --------
    %   epworks.p.notes.entry
    %   epworks.main

    properties
        data
    end

    methods
        function obj = notes(p,studies)
            %
            %   Inputs
            %   ------
            %   p :
            %   studies :
            %       

            entries = p.notes.entries;

            %Links are not processed
            %   - types and categories are currently messy and
            %   should be changed
            title = {entries.title}';
            
            %Note these times need to be shifted as they appear to be UTC
            %and not local
            created = [entries.created_time]';

            %UNKNOWN: Will there ever be more than one study?
            created = created + studies(1).tz_offset;

            comment = {entries.comment}';
            category = {entries.category}';
            type = {entries.type}';

            obj.data = table(created,title,comment,category,type);

        end
    end
end