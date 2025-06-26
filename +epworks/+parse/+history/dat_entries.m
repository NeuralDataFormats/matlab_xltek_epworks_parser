classdef dat_entries < handle
    %
    %   Class:
    %   epworks.parse.history.dat_entries
    %
    %   Who populates this?
    %
    %   
    
    %   Seems to be linked to triggered_waveform and possibly other
    %   collected signals (haven't checked)

    properties
       trace_id    %
       n          
       
       %NOTE: Apparently these are not always populated, 'n' can be 0
       IDs        %[n x 2], uint64
       u32        %[n x 1] I'm not sure what these represent yet

       %Are these the real start times for the top objects?
       timestamps %[n x 1] Values are in Matlab time format.
       
       trace
    end
    
    methods

    end
    
end

