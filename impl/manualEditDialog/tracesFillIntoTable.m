function idxTrace2Table = tracesFillIntoTable(hObject, eventdata, handles)


    % Temporarily disable callback while table is edited
%     set(handles.tracesTable, 'CellSelectionCallback', []);

    %oldData = get(hTable,'Data');
    % newData = [oldData; newRow];
    
    newData = [];
    mag = [];
    nTracesTotal = length(handles.old_list);
    for iRegOld = 1:nTracesTotal
        newRow = [iRegOld, min(handles.old_list{iRegOld}.f), max(handles.old_list{iRegOld}.f)];
        newData = [newData; newRow];
        mag = [mag; newRow(3)-newRow(2)];
    end
    
    % Sort wrt new array
    [~, idxTable2Trace] = sort(mag, 'descend');
    newDataSorted = newData(idxTable2Trace, :);
    
    set(handles.tracesTable, 'Data', newDataSorted)
    
    % Since rows are stored and displayed in different order, we need to
    % store the mapping, so that table rows corresponding to individual
    % traces can be accessed programmatically. However, we need the inverse
    % of the mapping we get from sort, because we will use trace index to
    % access table rows
    idxTrace2Table = zeros(nTracesTotal, 1);
    for iTable = 1:nTracesTotal
        idxTrace2Table(idxTable2Trace(iTable)) = iTable;
    end
    
    
%     % Enable callback again. Apparently it does not work without a small pause
%     pause(1)
%     set(handles.tracesTable, 'CellSelectionCallback', @tracesTable_CellSelectionCallback);
%     
%     % Save data
%     guidata( hObject, handles);
end