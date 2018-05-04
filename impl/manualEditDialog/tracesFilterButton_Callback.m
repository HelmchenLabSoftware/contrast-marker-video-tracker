% --- Executes on button press in tracesFilterButton.
function tracesFilterButton_Callback(hObject, eventdata, handles)
% hObject    handle to filterRunDialogButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    disp("start filter dialog")
    filterParam = filterDialog();
    
    if filterParam.undo == true
        if filterParam.filterType == 1
            fprintf("Reverting last point-filter operation")
            handles.regioncount = handles.regioncount_old;
            handles.ProcessedXList = handles.ProcessedXList_Old;
            handles.ProcessedYList = handles.ProcessedYList_Old;
            handles.ProcessedMList = handles.ProcessedMList_Old;
        else
            fprintf("Reverting last trace-filter operation")
            handles.old_list = handles.old_list_old;
        end
    else
        if filterParam.filterType == 1
            fprintf("Performing point-filter with following parameters:");
            disp(filterParam);
            
            % Backup
            handles.regioncount_old = handles.regioncount;
            handles.processedFrameList_Old = handles.processedFrameList;
            handles.ProcessedXList_Old = handles.ProcessedXList;
            handles.ProcessedYList_Old = handles.ProcessedYList;
            handles.ProcessedMList_Old = handles.ProcessedMList;

            % Perform filtering
            filteredData = filterPointData(handles.regioncount, handles.processedFrameList, handles.ProcessedXList, handles.ProcessedYList, handles.ProcessedMList, filterParam);

            % Update filtered data
            handles.regioncount = filteredData.regCount;
            handles.processedFrameList = filteredData.fList;
            handles.ProcessedXList = filteredData.xList;
            handles.ProcessedYList = filteredData.yList;
            handles.ProcessedMList = filteredData.mList;
            
            handles.haveTimeMerge = 0;
            
        else
            fprintf("Performing trace-filter with following parameters:\n");
            disp(filterParam);
            
            % Backup
            handles.old_list_old = handles.old_list;

            % Perform filtering
            filteredData = filterTraceData(handles.old_list, filterParam);

            % Update filtered data
            handles.old_list = filteredData.old_list;
            
            % Fill resulting traces into the table
            tracesFillIntoTable(hObject, eventdata, handles)

            % Store selected table indices, and that the table was created
            handles.haveTimeMerge = 1;
            handles.traceIndices = [];
        end
    end
    
    % Update plot
    handles.plotHandles = plotChooseTracesROI(handles);
    
    % Update handles with new variables
    guidata( hObject, handles);

end