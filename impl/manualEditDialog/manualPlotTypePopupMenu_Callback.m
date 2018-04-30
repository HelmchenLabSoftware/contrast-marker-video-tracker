% --- Executes on selection change in manualPlotTypePopupMenu.
function manualPlotTypePopupMenu_Callback(hObject, eventdata, handles)
% hObject    handle to manualPlotTypePopupMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns manualPlotTypePopupMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from manualPlotTypePopupMenu

% fprintf("totalframes=%i \n", handles.totalframes);

%      h = findobj('Tag','MouseTrackingMainGui');
% 
%      % if exists (not empty)
%      if ~isempty(h)
%         % get handles and other user-defined data associated to Gui1
%         g1data = guidata(h);
% 
%         % maybe you want to set the text in Gui2 with that from Gui1
%         %lolz = 0
%         %set(lolz, 'int', get(g1data.totalframes, 'int'));
%         disp(get(g1data.totalframes, 'int'))
% 
%         % maybe you want to get some data that was saved to the Gui1 app
% %         old_list = getappdata(h, 'old_list');
%         %lolz = getappdata(h, 'totalframes');
%         %fprintf("totalframes=%i \n", lolz);
%      end

    paramIdx = get(handles.manualPlotTypePopupMenu, 'Value');
    %if exist('handles.old_list', 'var')
    if handles.haveTimeMerge == 1
        
        if isempty(handles.traceIndices)
            tracesIdxs = 1:length(handles.old_list);
        else
            tracesIdxs = handles.traceIndices;
        end
        
        plotTracesByParameter(handles, paramIdx, tracesIdxs)
    else
        plotROIByParameter(handles, paramIdx)
    end
end