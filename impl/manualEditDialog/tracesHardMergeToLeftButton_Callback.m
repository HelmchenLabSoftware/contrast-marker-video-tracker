% --- Executes on button press in tracesHardMergeButton.
function tracesHardMergeToLeftButton_Callback(hObject, eventdata, handles)

    % Description:
    % Merge 2 traces, removing all intersecting frames from left-most trace
    % and putting them into a new trace
    
    % Strategy:
    % 1) Assert there are exactly 2 traces
    % 2) Sort traces (A,B) by lowest first frame
    % 3) Let f be the first frame of B
    % 4) C = A(f:end)
    % 5) A = A(begin:f-1) && B
    % 6) B = C
    % 7) If B is empty, delete B

end