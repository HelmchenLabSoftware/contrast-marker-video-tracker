% --- Choose current frame for inspection
function frameSlider_Callback(hObject, eventdata, handles)
    frameInt = fix(get(handles.frameSlider, 'Value'));
    
    handles.v = VideoReader(handles.pathfilename);
    handles.nextFrame = read(handles.v, frameInt);
    %handles.nextFrame = readFrame(handles.v, frameInt);
    %handles.v = VideoReader(pathfilename);  % Need to recreate object after quering frame count
    imshow(handles.nextFrame);
    guidata( hObject, handles);