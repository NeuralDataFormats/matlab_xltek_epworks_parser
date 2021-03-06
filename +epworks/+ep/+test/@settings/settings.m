classdef settings < epworks.id_object
    %
    %   Class:
    %   epworks.ep.test.settings
    
    %   NOTE: The settings links are currently populated by a method in
    %   test. Eventually this should be moved here for better
    %   encapsulation.
    %
    properties (Hidden)
       Stims 
    end
    
    properties
        ActiveLayout
        BoardRevision
        %ConfigData
        CursorCalc %epworks.ep.test.settings.cursor_calc
        CursorDef  %
        DefaultTemplate
        EEG
        Electrodes
        ElementLayouts
        FileName
        ForceFixChanMap
        GroupDef
        HBType
        HardwareConfig
        HistorySets
        IChans
        ID
        IsEMGTest
        ManufacturingTest
        Name
        OChans
       
        
        %????? - where are these linked at????
        %See test class
        auditory_stims
        electrical_stims
        external_stims
        tcemep_stims
        visual_stims

        TestTips
        Timelines
        TrendSets
        d1 = '----  Pointers to Other Objects  ----'
        active_layout
    end
    properties (Constant,Hidden)
        ID_PROP_INFO_1 = {
            'ActiveLayout'   'active_layout'
            }
    end
    methods
        function fixStimsObjects(objs)
           %
           %    From object population Stims is a cell array
           %    of different stim object subclasses. Here we break them
           %    up by type and assign them to the correct properties.
           
           n_objs = length(objs);
           for iObj = 1:n_objs
               cur_obj = objs(iObj);
               
               stim_cell = cur_obj.Stims;
               
               types = cellfun(@(x) x.Type,stim_cell,'un',0);
               
               cur_obj.auditory_stims   = [stim_cell{strcmp(types,'Auditory')}];
               cur_obj.electrical_stims = [stim_cell{strcmp(types,'Electrical')}];
               cur_obj.external_stims   = [stim_cell{strcmp(types,'External')}];
               cur_obj.tcemep_stims     = [stim_cell{strcmp(types,'TceMEP')}];
               cur_obj.visual_stims     = [stim_cell{strcmp(types,'Visual')}];
           end
        end
    end
    
end

%{
'EPTest.Data.Settings.ActiveLayout'
'EPTest.Data.Settings.AppTestSettings'
'EPTest.Data.Settings.AppTestSettings.Build'
'EPTest.Data.Settings.AppTestSettings.Version'
'EPTest.Data.Settings.BoardRevision'
'EPTest.Data.Settings.ConfigData'
'EPTest.Data.Settings.ConfigData.{57CF9D5C-AC2F-11D3-A8CC-00105AA89390}ShowSplitGains'
'EPTest.Data.Settings.CursorCalc'
'EPTest.Data.Settings.CursorCalc.000'
'EPTest.Data.Settings.CursorCalc.000.AlarmInPrcnt'
'EPTest.Data.Settings.CursorCalc.000.AlarmLevel'
'EPTest.Data.Settings.CursorCalc.000.AreaType'
'EPTest.Data.Settings.CursorCalc.000.DisplayType'
'EPTest.Data.Settings.CursorCalc.000.FromDef'
'EPTest.Data.Settings.CursorCalc.000.ID'
'EPTest.Data.Settings.CursorCalc.000.IsMarker'
'EPTest.Data.Settings.CursorCalc.000.Name'
'EPTest.Data.Settings.CursorCalc.000.NegAlarmLevel'
'EPTest.Data.Settings.CursorCalc.000.ToDef'
'EPTest.Data.Settings.CursorCalc.000.ValueType'
'EPTest.Data.Settings.CursorDef'
'EPTest.Data.Settings.CursorDef.000'
'EPTest.Data.Settings.CursorDef.000.DisplayName'
'EPTest.Data.Settings.CursorDef.000.GroupDef'
'EPTest.Data.Settings.CursorDef.000.ID'
'EPTest.Data.Settings.CursorDef.000.IsMarker'
'EPTest.Data.Settings.CursorDef.000.LatencyFrom'
'EPTest.Data.Settings.CursorDef.000.LatencyTo'
'EPTest.Data.Settings.CursorDef.000.Name'
'EPTest.Data.Settings.CursorDef.000.Placement'
'EPTest.Data.Settings.CursorDef.000.Style'
'EPTest.Data.Settings.CursorDef.000.TraceID'
'EPTest.Data.Settings.CursorDef.000.UseType'
'EPTest.Data.Settings.CursorDef.000.VisiblePlacementOnly'
'EPTest.Data.Settings.DefaultTemplate'
'EPTest.Data.Settings.EEG'
'EPTest.Data.Settings.EEG.AlphaMax'
'EPTest.Data.Settings.EEG.AlphaMin'
'EPTest.Data.Settings.EEG.AppliedMontage'
'EPTest.Data.Settings.EEG.AppliedMontageKeyTree'
'EPTest.Data.Settings.EEG.AppliedMontageKeyTree.Bin0'
'EPTest.Data.Settings.EEG.AppliedMontageKeyTree.Bin1'
'EPTest.Data.Settings.EEG.AppliedMontageKeyTree.Bin2'
'EPTest.Data.Settings.EEG.AppliedMontageKeyTree.Bin3'
'EPTest.Data.Settings.EEG.AppliedMontageKeyTree.Bin4'
'EPTest.Data.Settings.EEG.AppliedMontageKeyTree.Bin5'
'EPTest.Data.Settings.EEG.AppliedMontageKeyTree.ChanNames'
'EPTest.Data.Settings.EEG.AppliedMontageKeyTree.Channels'
'EPTest.Data.Settings.EEG.AppliedMontageKeyTree.FileName'
'EPTest.Data.Settings.EEG.AppliedMontageKeyTree.HalfMontageChannels'
'EPTest.Data.Settings.EEG.AppliedMontageKeyTree.InputChannels'
'EPTest.Data.Settings.EEG.AppliedMontageKeyTree.MontageName'
'EPTest.Data.Settings.EEG.AppliedMontageKeyTree.MontageType'
'EPTest.Data.Settings.EEG.AppliedMontageKeyTree.Name'
'EPTest.Data.Settings.EEG.AppliedMontageKeyTree.Schema'
'EPTest.Data.Settings.EEG.AppliedMontageKeyTree.SpecDecimation'
'EPTest.Data.Settings.EEG.AppliedMontageKeyTree.SpecNumBins'
'EPTest.Data.Settings.EEG.AppliedMontageKeyTree.SpecResolution'
'EPTest.Data.Settings.EEG.AppliedMontageKeyTree.SpecType'
'EPTest.Data.Settings.EEG.AppliedMontageKeyTree.Type'
'EPTest.Data.Settings.EEG.BetaMax'
'EPTest.Data.Settings.EEG.BetaMin'
'EPTest.Data.Settings.EEG.Delay'
'EPTest.Data.Settings.EEG.DeltaMax'
'EPTest.Data.Settings.EEG.DeltaMin'
'EPTest.Data.Settings.EEG.Duration'
'EPTest.Data.Settings.EEG.Epoch'
'EPTest.Data.Settings.EEG.Reference'
'EPTest.Data.Settings.EEG.SpectralEdge'
'EPTest.Data.Settings.EEG.ThetaMax'
'EPTest.Data.Settings.EEG.ThetaMin'
'EPTest.Data.Settings.EEG.TrueDifferential'
'EPTest.Data.Settings.Electrodes'
'EPTest.Data.Settings.Electrodes.000'
'EPTest.Data.Settings.Electrodes.000.EEGSiteGUID'
'EPTest.Data.Settings.Electrodes.000.ID'
'EPTest.Data.Settings.Electrodes.000.Location'
'EPTest.Data.Settings.Electrodes.000.PhysElectrode'
'EPTest.Data.Settings.Electrodes.000.PhysName'
'EPTest.Data.Settings.ElementLayouts'
'EPTest.Data.Settings.ElementLayouts.000'
'EPTest.Data.Settings.ElementLayouts.000.Elements'
'EPTest.Data.Settings.ElementLayouts.000.ID'
'EPTest.Data.Settings.ElementLayouts.000.Name'
'EPTest.Data.Settings.FileName'
'EPTest.Data.Settings.ForceFixChanMap'
'EPTest.Data.Settings.GroupDef'
'EPTest.Data.Settings.GroupDef.000'
'EPTest.Data.Settings.GroupDef.000.CaptureChime'
'EPTest.Data.Settings.GroupDef.000.CaptureEnable'
'EPTest.Data.Settings.GroupDef.000.CaptureThreshold'
'EPTest.Data.Settings.GroupDef.000.CollectMaxData'
'EPTest.Data.Settings.GroupDef.000.DesiredUpdateInterval'
'EPTest.Data.Settings.GroupDef.000.DiscreteReadings'
'EPTest.Data.Settings.GroupDef.000.DisplayMode'
'EPTest.Data.Settings.GroupDef.000.EMGCableMode'
'EPTest.Data.Settings.GroupDef.000.FWaveFilter'
'EPTest.Data.Settings.GroupDef.000.ForcedDecimation'
'EPTest.Data.Settings.GroupDef.000.ID'
'EPTest.Data.Settings.GroupDef.000.IsEegGroup'
'EPTest.Data.Settings.GroupDef.000.LimitedHBDecimation'
'EPTest.Data.Settings.GroupDef.000.Location'
'EPTest.Data.Settings.GroupDef.000.MaacsGroupId'
'EPTest.Data.Settings.GroupDef.000.Name'
'EPTest.Data.Settings.GroupDef.000.NumDivisionsToCollect'
'EPTest.Data.Settings.GroupDef.000.PreTriggerDCOffset'
'EPTest.Data.Settings.GroupDef.000.PreTriggerTriggerDelay'
'EPTest.Data.Settings.GroupDef.000.RollingWindow'
'EPTest.Data.Settings.GroupDef.000.ShowLiveTriggered'
'EPTest.Data.Settings.GroupDef.000.SignalType'
'EPTest.Data.Settings.GroupDef.000.SpecialType'
'EPTest.Data.Settings.GroupDef.000.StartOnTestActivation'
'EPTest.Data.Settings.GroupDef.000.SweepsPerAvg'
'EPTest.Data.Settings.GroupDef.000.TimelineID'
'EPTest.Data.Settings.GroupDef.000.TriggerDelay'
'EPTest.Data.Settings.GroupDef.000.TriggerSource'
'EPTest.Data.Settings.HBType'
'EPTest.Data.Settings.HardwareConfig'
'EPTest.Data.Settings.HistorySets'
'EPTest.Data.Settings.HistorySets.000'
'EPTest.Data.Settings.HistorySets.000.HistoryTrace0'
'EPTest.Data.Settings.HistorySets.000.HistoryTrace1'
'EPTest.Data.Settings.HistorySets.000.HistoryTrace10'
'EPTest.Data.Settings.HistorySets.000.HistoryTrace11'
'EPTest.Data.Settings.HistorySets.000.HistoryTrace12'
'EPTest.Data.Settings.HistorySets.000.HistoryTrace13'
'EPTest.Data.Settings.HistorySets.000.HistoryTrace14'
'EPTest.Data.Settings.HistorySets.000.HistoryTrace15'
'EPTest.Data.Settings.HistorySets.000.HistoryTrace16'
'EPTest.Data.Settings.HistorySets.000.HistoryTrace17'
'EPTest.Data.Settings.HistorySets.000.HistoryTrace2'
'EPTest.Data.Settings.HistorySets.000.HistoryTrace3'
'EPTest.Data.Settings.HistorySets.000.HistoryTrace4'
'EPTest.Data.Settings.HistorySets.000.HistoryTrace5'
'EPTest.Data.Settings.HistorySets.000.HistoryTrace6'
'EPTest.Data.Settings.HistorySets.000.HistoryTrace7'
'EPTest.Data.Settings.HistorySets.000.HistoryTrace8'
'EPTest.Data.Settings.HistorySets.000.HistoryTrace9'
'EPTest.Data.Settings.HistorySets.000.ID'
'EPTest.Data.Settings.HistorySets.000.Name'
'EPTest.Data.Settings.IChans'
'EPTest.Data.Settings.IChans.000'
'EPTest.Data.Settings.IChans.000.ActiveElectrode'
'EPTest.Data.Settings.IChans.000.AudioVolume'
'EPTest.Data.Settings.IChans.000.EventThreshold'
'EPTest.Data.Settings.IChans.000.HardwareLFF'
'EPTest.Data.Settings.IChans.000.ID'
'EPTest.Data.Settings.IChans.000.IsSquelch'
'EPTest.Data.Settings.IChans.000.LogicalChan'
'EPTest.Data.Settings.IChans.000.MontageChanId'
'EPTest.Data.Settings.IChans.000.OldLogChan'
'EPTest.Data.Settings.IChans.000.Range'
'EPTest.Data.Settings.IChans.000.RefElectrode'
'EPTest.Data.Settings.IChans.000.Resolution'
'EPTest.Data.Settings.IChans.000.SamplingFreq'
'EPTest.Data.Settings.IChans.000.SquelchThreshold'
'EPTest.Data.Settings.IChans.000.ThresholdDelay'
'EPTest.Data.Settings.ID'
'EPTest.Data.Settings.IsEMGTest'
'EPTest.Data.Settings.ManufacturingTest'
'EPTest.Data.Settings.ManufacturingTest.AllowedCrossTalkRatio'
'EPTest.Data.Settings.ManufacturingTest.AllowedDCOffset'
'EPTest.Data.Settings.ManufacturingTest.AllowedDeviationPercent'
'EPTest.Data.Settings.ManufacturingTest.AllowedNoiseLevel'
'EPTest.Data.Settings.ManufacturingTest.CyclingPeriod'
'EPTest.Data.Settings.ManufacturingTest.IsCrossTalkTest'
'EPTest.Data.Settings.ManufacturingTest.IsManufacturingTest'
'EPTest.Data.Settings.ManufacturingTest.MinCrossTalkRatio'
'EPTest.Data.Settings.ManufacturingTest.ReferenceSignalFrequency'
'EPTest.Data.Settings.ManufacturingTest.ReferenceSignalP2P'
'EPTest.Data.Settings.Name'
'EPTest.Data.Settings.OChans'
'EPTest.Data.Settings.OChans.000'
'EPTest.Data.Settings.OChans.000.Color'
'EPTest.Data.Settings.OChans.000.FilteringStyle'
'EPTest.Data.Settings.OChans.000.From'
'EPTest.Data.Settings.OChans.000.GroupDef'
'EPTest.Data.Settings.OChans.000.HffCutoff'
'EPTest.Data.Settings.OChans.000.ID'
'EPTest.Data.Settings.OChans.000.IsChannelEnabled'
'EPTest.Data.Settings.OChans.000.IsChannelTrigger'
'EPTest.Data.Settings.OChans.000.IsRejectionOnStimSaturation'
'EPTest.Data.Settings.OChans.000.LeftDisplayGain'
'EPTest.Data.Settings.OChans.000.LffCutoff'
'EPTest.Data.Settings.OChans.000.MaacsTraceId'
'EPTest.Data.Settings.OChans.000.MaxUserVariation'
'EPTest.Data.Settings.OChans.000.Name'
'EPTest.Data.Settings.OChans.000.NotchCutoff'
'EPTest.Data.Settings.OChans.000.ResponseChime'
'EPTest.Data.Settings.OChans.000.RightDisplayGain'
'EPTest.Data.Settings.OChans.000.Timebase'
'EPTest.Data.Settings.OChans.000.To'
'EPTest.Data.Settings.Stims'
'EPTest.Data.Settings.Stims.000'
'EPTest.Data.Settings.Stims.000.2ndPulseIntensity'
'EPTest.Data.Settings.Stims.000.AudStimOutput'
'EPTest.Data.Settings.Stims.000.AudioOnset'
'EPTest.Data.Settings.Stims.000.AudioRamp'
'EPTest.Data.Settings.Stims.000.Colour'
'EPTest.Data.Settings.Stims.000.ConstVoltage'
'EPTest.Data.Settings.Stims.000.ContraMode'
'EPTest.Data.Settings.Stims.000.Delay'
'EPTest.Data.Settings.Stims.000.DeviceType'
'EPTest.Data.Settings.Stims.000.Divisions'
'EPTest.Data.Settings.Stims.000.ID'
'EPTest.Data.Settings.Stims.000.InitIntensity'
'EPTest.Data.Settings.Stims.000.Intensity'
'EPTest.Data.Settings.Stims.000.InterPulseDuration'
'EPTest.Data.Settings.Stims.000.IpsiMode'
'EPTest.Data.Settings.Stims.000.IsActiveHigh'
'EPTest.Data.Settings.Stims.000.IsOutput'
'EPTest.Data.Settings.Stims.000.Location'
'EPTest.Data.Settings.Stims.000.MaskIntensity'
'EPTest.Data.Settings.Stims.000.Mode'
'EPTest.Data.Settings.Stims.000.Nerve'
'EPTest.Data.Settings.Stims.000.NumberOfPhases'
'EPTest.Data.Settings.Stims.000.OnTimeline'
'EPTest.Data.Settings.Stims.000.PhysName'
'EPTest.Data.Settings.Stims.000.PhysNum'
'EPTest.Data.Settings.Stims.000.Polarity'
'EPTest.Data.Settings.Stims.000.PrimingGap'
'EPTest.Data.Settings.Stims.000.PrimingPulses'
'EPTest.Data.Settings.Stims.000.PulseDuration'
'EPTest.Data.Settings.Stims.000.PulseIntensity'
'EPTest.Data.Settings.Stims.000.PulsesPerTrain'
'EPTest.Data.Settings.Stims.000.Range'
'EPTest.Data.Settings.Stims.000.Rate'
'EPTest.Data.Settings.Stims.000.RelayPort'
'EPTest.Data.Settings.Stims.000.RelaySwitchDelay'
'EPTest.Data.Settings.Stims.000.SwStimId'
'EPTest.Data.Settings.Stims.000.TrainRate'
'EPTest.Data.Settings.Stims.000.TriggerToStimLat'
'EPTest.Data.Settings.Stims.000.Type'
'EPTest.Data.Settings.Stims.000.VisualField'
'EPTest.Data.Settings.Stims.000.VisualFlash'
'EPTest.Data.Settings.Stims.000.VisualStimOutput'
'EPTest.Data.Settings.Stims.000.VisualTrigger'
'EPTest.Data.Settings.TestTips'
'EPTest.Data.Settings.Timelines'
'EPTest.Data.Settings.Timelines.000'
'EPTest.Data.Settings.Timelines.000.ID'
'EPTest.Data.Settings.Timelines.000.IsEnabled'
'EPTest.Data.Settings.Timelines.000.IsPaused'
'EPTest.Data.Settings.Timelines.000.IsRunning'
'EPTest.Data.Settings.Timelines.000.IsWaiting'
'EPTest.Data.Settings.Timelines.000.RestartDelay'
'EPTest.Data.Settings.Timelines.000.StartWaiting'
'EPTest.Data.Settings.Timelines.000.Type'
'EPTest.Data.Settings.TrendSets'
'EPTest.Data.Settings.TrendSets.000'
'EPTest.Data.Settings.TrendSets.000.ID'
'EPTest.Data.Settings.TrendSets.000.Name'
'EPTest.Data.Settings.TrendSets.000.TrendCalc0'
'EPTest.Data.Settings.TrendSets.000.TrendCalc1'

%}