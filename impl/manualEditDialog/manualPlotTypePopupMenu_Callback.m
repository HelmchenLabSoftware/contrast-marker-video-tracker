% --- Executes on selection change in manualPlotTypePopupMenu.
function manualPlotTypePopupMenu_Callback(hObject, eventdata, handles)

    % Choose plot type, plot, and get handles to the plots
    handles.plotHandles = plotChooseTracesROI(handles);
    
    % Update handles structure
    guidata(hObject, handles);
end