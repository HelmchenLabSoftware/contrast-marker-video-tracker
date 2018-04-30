function tracesFillIntoTable(hObject, eventdata, handles)
    %oldData = get(hTable,'Data');
    % newData = [oldData; newRow];

    newData = [];
    mag = [];
    for iRegOld = 1:length(handles.old_list)
        newRow = [iRegOld, min(handles.old_list{iRegOld}.f), max(handles.old_list{iRegOld}.f)];
        newData = [newData; newRow];
        mag = [mag; newRow(3)-newRow(2)];
    end
    
    % Sort wrt new array
    [~, indices] = sort(mag, 'descend');
    newDataSorted = newData(indices, :);
    
    set(handles.tracesTable, 'Data', newDataSorted)
end