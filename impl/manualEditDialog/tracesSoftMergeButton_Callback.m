% --- Executes on button press in tracesSoftMergeButton.
function tracesSoftMergeButton_Callback(hObject, eventdata, handles)

    % merge all points into single array
    for iTrIdx = 1:length(handles.traceIndices)
       traceIdx =  handles.traceIndices(iTrIdx);
       if iTrIdx == 1
           newCell = handles.old_list{traceIdx};
       else
           newCell.f = [newCell.f handles.old_list{traceIdx}.f];
           newCell.x = [newCell.x handles.old_list{traceIdx}.x];
           newCell.y = [newCell.y handles.old_list{traceIdx}.y];
           newCell.m = [newCell.m handles.old_list{traceIdx}.m];
       end
    end

    % sort ascendingly by frame
    [newCell.f, sortIdx] = sort(newCell.f);
    newCell.x = newCell.x(sortIdx);
    newCell.y = newCell.y(sortIdx);
    newCell.m = newCell.m(sortIdx);

    % Loop over all entries
    resultCell = struct();
    resultCell.f = [];
    resultCell.x = [];
    resultCell.y = [];
    resultCell.m = [];

    tmpF = 0;

    for i = 1:length(newCell.f)
        fprintf("processing frame %i \n", i);
        % When encounter new frame
        if newCell.f(i) ~= tmpF
            % Unless this is the very start
            if tmpF ~= 0
                % Append weighted-average of stored datapoint to the new trace
                avgX = tmpX / tmpM;
                avgY = tmpY / tmpM;
                
                resultCell.f = [resultCell.f tmpF];
                resultCell.x = [resultCell.x avgX];
                resultCell.y = [resultCell.y avgY];
                resultCell.m = [resultCell.m tmpY];
            end

            % Store new data point 
            tmpF = newCell.f(i);
            tmpM = newCell.m(i);
            tmpX = newCell.x(i) * newCell.m(i);
            tmpY = newCell.y(i) * newCell.m(i);
            
        else
            % If frame is repeating, increase count and merge coordinates
            tmpM = tmpM + newCell.m(i);
            tmpX = tmpX + newCell.x(i) * newCell.m(i);
            tmpY = tmpY + newCell.y(i) * newCell.m(i);
            
        end
    end
    
    % Append the last one
    avgX = tmpX / tmpM;
    avgY = tmpY / tmpM;

    resultCell.f = [resultCell.f tmpF];
    resultCell.x = [resultCell.x avgX];
    resultCell.y = [resultCell.y avgY];
    resultCell.m = [resultCell.m tmpY];
    
    fprintf("resulting large array length is %i %i \n", length(resultCell.f), length(resultCell.x));
    
    %delete the original traces from storage
    fprintf("number of traces before %i \n", length(handles.old_list));
    handles.old_list(handles.traceIndices) = [];
    fprintf("number of traces after %i \n", length(handles.old_list));
    
    %append the merged trace to storage
    handles.old_list{end + 1} = resultCell;
    
    % Fill resulting traces into the table. Store map from trace to table index
    handles.idxTrace2Table = tracesFillIntoTable(hObject, eventdata, handles);
    
    % After table refill, nothing should be selected
    handles.traceIndices = [];
    
    % Update plot
    handles.plotHandles = plotChooseTracesROI(handles);
    
    % Save
    guidata(hObject, handles);
    
end

