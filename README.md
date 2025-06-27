# XLTek EPWorks Parser #

This code attempts to parse data collected using XLTek's EPWorks software. It is implemented using MATLAB. The parsing is done without any official documentation or specifications given to me by the company and as such any parsing should be checked against known results using their software. 

## Documentation ##

This documentation is old but may still be helpful ...

- [Questions](documentation/questions.md)
- [What's Missing](documentation/whats_missing.md)

## Usage ##

1. Make sure the epworks package is on the Matlab path. The subfolders should not be added to the path.

The main entry call is *epworks.main*.

The simplest usage case is to call:

```
    f = epworks.main;
```

You can also specify the path to the study folder, or to the IOM file in the study folder.

The `p` property contains all of the raw parsed data. The other properties are meant to make things a bit cleaner for calling.

Unfortunately usage is not well documented. It really helps if you understand how to identify class type in MATLAB, if you understand MATLAB packages, and if you know how to use the methods.

Here's an example with a loaded file:

```
f = epworks.main(study_root);

eeg = f.eeg_waveforms;

class(eeg) %'epworks.objects.eeg_waveform'

methods(eeg) %Lists the methods

%Retrieve 2nd snippet from first EEG object
%
%	Note, this may not be the top plot. Need to look at the montage
%	to determine which channel is top most.
s = eeg(1).getData(2);

plot(s.time,s.data)

%Let's do some filtering
%
%	Note, I haven't added the filter parameters as options. You are
%	welcome to get the raw data and filter it yourself. Currently
%	you have to change the properties to change the paramaters

eeg(1).hff_cutoff = -1; %Disable removal of high frequencies
eeg(1).notch_cutoff = 60; %ensure notch is present
eeg(1).lff_cutoff = 0.1; % Remove frequency content below 0.1 Hz

s = eeg(1).getData(2,'filter',true);


```

## Data ##

Raw data are stored in the REC files. As far as I can tell the data are not linked with continuous collection. I go back afterwards and try and stitch things together (if there are not gaps, in time, between one set of data and the next set of data). Each channel can have multiple entries/snippets.

## Feature Requests? ##

Feel free to create an issue or reach out. Depending upon your request and experience level a pull request may be helpful.

