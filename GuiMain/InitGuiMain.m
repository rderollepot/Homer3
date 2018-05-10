function guiMain = InitGuiMain(handles, group, currElem)

axesSDG = InitAxesSDG(handles);
axesData = InitAxesData(handles, axesSDG);
guiMain = struct(...
                     'handles', struct(...
                                       'radiobuttonPlotConc', handles.radiobuttonPlotConc, ...
                                       'radiobuttonPlotOD', handles.radiobuttonPlotOD, ...
                                       'radiobuttonPlotRaw', handles.radiobuttonPlotRaw, ...
                                       'checkboxPlotHRF', handles.checkboxPlotHRF, ...
                                       'checkboxPlotProbe', handles.checkboxPlotProbe, ...
                                       'listboxPlotWavelength', handles.listboxPlotWavelength, ...
                                       'listboxPlotConc', handles.listboxPlotConc, ...
                                       'popupmenuConditions', handles.popupmenuConditions, ...
                                       'menuItemViewHRFStdErr', handles.menuItemViewHRFStdErr ...
                                      ), ...
                     'datatype', 0, ...
                     'condition', 0, ...
                     'ch', 0, ...
                     'wl', 0, ...
                     'hbType', 0, ...
                     'buttonVals', struct(...
                                          'RAW',1, ...
                                          'RAW_HRF',2, ...
                                          'RAW_HRF_PLOT_PROBE',3, ...
                                          'OD',4, ...
                                          'OD_HRF',5, ...
                                          'OD_HRF_PLOT_PROBE',6, ...
                                          'CONC',7, ...
                                          'CONC_HRF',8, ...
                                          'CONC_HRF_PLOT_PROBE',9 ...
                                         ), ...
                     'sclConc', 1e6, ...                      % convert Conc from Molar to uMolar
                     'axesSDG', axesSDG, ...
                     'axesData', axesData, ...
                     'showStdErr', false, ... 
                     'flagPlotRange', 0 ...
                 );

guiMain = UpdateAxesDataCondition(guiMain, group, currElem);
setWl(guiMain, currElem.procElem.SD.Lambda);

guiMain.datatype  = getDatatype(guiMain);
guiMain.condition = getCondition(guiMain);
guiMain.wl        = getWl(guiMain, currElem.procElem.SD.Lambda);
guiMain.hbType    = getHbType(guiMain);
guiMain.ch        = GetAxesSDGSelection(guiMain.axesSDG);
if strcmp(get(handles.menuItemViewHRFStdErr, 'checked'), 'on');
    guiMain.showStdErr = true;
elseif strcmp(get(handles.menuItemViewHRFStdErr, 'checked'), 'off');
    guiMain.showStdErr = false;
end

if guiMain.datatype == guiMain.buttonVals.RAW || guiMain.datatype == guiMain.buttonVals.RAW_HRF || guiMain.datatype == guiMain.buttonVals.RAW_HRF_PLOT_PROBE

    set(guiMain.handles.listboxPlotWavelength, 'visible','on');
    set(guiMain.handles.listboxPlotConc, 'visible','off');
    
elseif guiMain.datatype == guiMain.buttonVals.OD || guiMain.datatype == guiMain.buttonVals.OD_HRF || guiMain.datatype == guiMain.buttonVals.OD_HRF_PLOT_PROBE
    
    set(guiMain.handles.listboxPlotWavelength, 'visible','on');
    set(guiMain.handles.listboxPlotConc, 'visible','off');
    
elseif guiMain.datatype == guiMain.buttonVals.CONC || guiMain.datatype == guiMain.buttonVals.CONC_HRF || guiMain.datatype == guiMain.buttonVals.CONC_HRF_PLOT_PROBE
    
    set(guiMain.handles.listboxPlotWavelength, 'visible','off');
    set(guiMain.handles.listboxPlotConc, 'visible','on');
    
end
