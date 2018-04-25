% --- Executes on button press in filterRunDialogButton.
function filterRunDialogButton_Callback(hObject, eventdata, handles)
% hObject    handle to filterRunDialogButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    disp("start dialg")
    filterParam = filterDialog();
    fprintf("Using following parameters to filter:");
    disp(filterParam);
    
    if filterParam.undo == true
        fprintf("Reverting last filter operation")
        handles.regioncount = handles.regioncount_old;
        handles.ProcessedXList = handles.ProcessedXList_Old;
        handles.ProcessedYList = handles.ProcessedYList_Old;
        handles.ProcessedMList = handles.ProcessedMList_Old;
    else
        nData = length(handles.ProcessedXList);
        nReg = length(handles.regioncount);
        nTot = sum(handles.regioncount);

        fprintf("before filter ndata=%d, nROI=%d, nTot=%d \n", nData, nReg, nTot);


        % Backup
        handles.regioncount_old = handles.regioncount;
        handles.ProcessedXList_Old = handles.ProcessedXList;
        handles.ProcessedYList_Old = handles.ProcessedYList;
        handles.ProcessedMList_Old = handles.ProcessedMList;

        nData = length(handles.ProcessedXList);
        deleteList = zeros(1, nData);

        % Loop over all frames and regions
        % Determine which ROI fit the filter and mark them for deletion
        iROICount = 0;
        for iFrame = 1:length(handles.regioncount)
            subROICount = 0;
            for iROIThis = 1:handles.regioncount(iFrame)
                iROICount = iROICount + 1;

                x = handles.ProcessedXList(iROICount);
                y = handles.ProcessedYList(iROICount);
                m = handles.ProcessedMList(iROICount);

                fitX = (~filterParam.useX) || ((x >= filterParam.minX) && (x <= filterParam.maxX));
                fitY = (~filterParam.useY) || ((y >= filterParam.minY) && (y <= filterParam.maxY));
                fitM = (~filterParam.useM) || ((m >= filterParam.minM) && (m <= filterParam.maxM));

                if fitX && fitY && fitM
                    %fprintf("deleting region %d %d %d %d \n", iFrame, x, y, m);

                    subROICount = subROICount + 1;
                    deleteList(iROICount) = 1;
                end
            end

            % Decrease region count per frame, based on number of deleted regions
            handles.regioncount(iFrame) = handles.regioncount(iFrame) - subROICount;
        end

        % Delete regions
        handles.ProcessedXList(deleteList == 1) = [];
        handles.ProcessedYList(deleteList == 1) = [];
        handles.ProcessedMList(deleteList == 1) = [];

        nData = length(handles.ProcessedXList);
        nReg = length(handles.regioncount);
        nTot = sum(handles.regioncount);

        disp(sum(deleteList))

        fprintf("after filter ndata=%d, nROI=%d, nTot=%d \n", nData, nReg, nTot);
    end
    
    % Update handles with new variables
    guidata( hObject, handles);

end