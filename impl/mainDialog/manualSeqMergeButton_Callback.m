% --- Executes on button press in manualSeqMergeButton.
function manualSeqMergeButton_Callback(hObject, eventdata, handles)

    disp("start manual edit dialog")
    manualEditParam = manualEditDialog(handles);
    fprintf("Using following parameters to filter:");
    disp(manualEditParam);

end
