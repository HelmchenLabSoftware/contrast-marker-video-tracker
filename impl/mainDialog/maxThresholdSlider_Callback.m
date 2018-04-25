% --- Executes on slider movement.
function maxThresholdSlider_Callback(hObject, eventdata, handles)
    sliderMin = get(handles.minThresholdSlider, 'Value');
    sliderMax = get(handles.maxThresholdSlider, 'Value');
    handles.nextFrameAdj = imadjust(handles.nextFrameSub, [sliderMin sliderMax]);
    imshow(handles.nextFrameAdj)
    guidata( hObject, handles);