% --- Executes on button press in loadVideoButton.
function loadVideoButton_Callback(hObject, eventdata, handles)
    load('userparam.mat', 'loadFilePath')
    disp(['using temporary path', loadFilePath])

    [filename, pathname] = uigetfile('*.avi', 'Open Reflective Video For Evaluating', loadFilePath);

    if filename ~= 0
        loadFilePath = pathname
        save('userparam.mat', 'loadFilePath', '-append')

        handles.pathfilename = strcat(pathname,filename);

        % Play Video if necessary
        % implay(pathfilename)

        %Read Next frame
        handles.v = VideoReader(handles.pathfilename);
        handles.totalframes = handles.v.NumberOfFrames;
        handles.v = VideoReader(handles.pathfilename);  % Need to recreate object after quering frame count
        handles.nextFrame = readFrame(handles.v);
        fprintf('opened file with %d frames \n', handles.totalframes);
        imshow(handles.nextFrame);

        %Update frame slider
        set(handles.frameSlider, 'max', handles.totalframes);

        guidata(hObject, handles);
    end
end