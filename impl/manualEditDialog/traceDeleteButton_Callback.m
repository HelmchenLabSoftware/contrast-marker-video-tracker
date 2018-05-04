% --- Executes on button press in traceDeleteButton.
function traceDeleteButton_Callback(hObject, eventdata, handles)

    if handles.haveTimeMerge == 0
        % In case of ROI, only delete something selected by brush
        brush = get(handles.plotHandles(1), 'BrushData');
        dataIdx = find(brush);
        
        handles.processedFrameList(dataIdx) = [];
        handles.ProcessedXList(dataIdx) = [];
        handles.ProcessedYList(dataIdx) = [];
        handles.ProcessedMList(dataIdx) = [];
        
        % Reconstruct region count from updated processedFrameList
        handles.regioncount = frameList2regCount(handles.processedFrameList, handles.totalframes);

    else
        % In case of traces, only delete something selected in table
        %delete the original traces from storage
        fprintf("number of traces before %i \n", length(handles.old_list));
        handles.old_list(handles.traceIndices) = [];
        fprintf("number of traces after %i \n", length(handles.old_list));

        % Fill resulting traces into the table. Store map from trace to table index
        handles.idxTrace2Table = tracesFillIntoTable(hObject, eventdata, handles);

        % Update that nothing in currently selected
        handles.traceIndices = [];
    end


    % Update plot
    handles.plotHandles = plotChooseTracesROI(handles);

    % Save update
    guidata(hObject, handles);
end