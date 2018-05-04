% --- Executes when selected cell(s) is changed in tracesTable.
function tracesTable_CellSelectionCallback(hObject, eventdata, handles)
    % Plot every time an entry is selected
    gridData = get(handles.tracesTable, 'Data');
    paramIdx = get(handles.manualPlotTypePopupMenu, 'Value');
    rowIndices = unique(eventdata.Indices(:,1));
    handles.traceIndices = gridData(rowIndices, 1);
    
    %disp(rowIndices)
    
    handles.plotHandles = plotTracesByParameter(handles, paramIdx, handles.traceIndices);
    
    % Save Data
    guidata(hObject, handles);
end