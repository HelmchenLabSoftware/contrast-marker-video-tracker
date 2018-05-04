% --- Executes on button press in brushSelectButton.
function brushSelectButton_Callback(hObject, eventdata, handles)

%     brush = get(handles.manualTraceAxes, 'BrushData');
    
    fprintf("yolo\n");
    
    if handles.haveTimeMerge == 1
        
        % Temporarily disable table selection callback while table is edited
%         set(handles.tracesTable, 'CellSelectionCallback', []);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Find indices of selected traces
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        selectedTraceIdx = [];
        for iPlot = 1:length(handles.plotHandles)
            brush = get(handles.plotHandles(iPlot), 'BrushData');
            
            if ~isempty(find(brush, 1))
                %dataIdx = find(brush);
                selectedTraceIdx = [selectedTraceIdx iPlot];
            end
        end
        
        % Map selected trace-indices to table-indices
        selectedTableRowIdx = handles.idxTrace2Table(selectedTraceIdx);
        
        fprintf('Trace indices to select: ');  disp(selectedTraceIdx);
        fprintf('Table indices to select: ');  disp(selectedTableRowIdx);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Marking table rows as selected
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Select exactly dataIdx rows in table
        jUIScrollPane = findjobj(handles.tracesTable); 
        jUITable = jUIScrollPane.getViewport.getView;
        
        % Unselect everything
        jUITable.changeSelection(-1,-1, false, false);

        % Select 1st col for each selected row
        for iTableRowSel = 1:length(selectedTableRowIdx)
            jUITable.changeSelection(selectedTableRowIdx(iTableRowSel)-1, 0, true, false);
        end


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % React
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        
        % Update plot
        handles.plotHandles = plotChooseTracesROI(handles);
        
        % Enable callback again. Apparently it does not work without a small pause
        % pause(1)
%         set(handles.tracesTable, 'CellSelectionCallback', @tracesTable_CellSelectionCallback);
        
        % Save data
        guidata( hObject, handles);
    end
    
    


%     h = findobj(gca,'Type','line');
%     h = findobj(handles.manualTraceAxes,'type','line');
%     h = findobj(handles.manualTraceAxes.Scatter);
%     h = findobj(gca,'Type','line');
%     disp(h)
%     brush = get(h, 'BrushData');
%     disp(brush)
%     
%     dataIdxSel = [];
%     for i = 1:length(brush)
%         if ~isempty(find(brush{i}, 1))
%             dataIdxSel = [dataIdxSel i];
%         end
%     end
%     
%     disp(brush)
%     
%     disp(dataIdxSel)
    

%     xd = get(Handle, 'XData')
%     yd = get(Handle, 'YData')
%     brush = get(Handle, 'BrushData')
%     % brushed_x = xd(brush);
%     % brushed_y = yd(brush);
% 
%     for i = 1:5
%         xi = xd{i};
%         yi = yd{i};
%         bi = find(brush{i});
%         disp(["x" string(xi(bi)) "y" string(yi(bi))])
%     end

end