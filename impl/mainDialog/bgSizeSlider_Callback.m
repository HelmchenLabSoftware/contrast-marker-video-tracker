% --- Eliminate background by selecting smoothing radius
function bgSizeSlider_Callback(hObject, eventdata, handles)
    sliderBG = get(handles.bgSizeSlider, 'Value');
    sliderBGInt = fix(sliderBG);

    % Estimate background
    background = imopen(handles.nextFrame, strel('disk', sliderBGInt));

    % Display the Background Approximation as a Surface
    % figure
    % surf(double(background(1:8:end,1:8:end))),zlim([0 255]);
    % ax = gca;
    % ax.YDir = 'reverse';

    % Subtract background
    handles.nextFrameSub = handles.nextFrame - background;
    imshow(handles.nextFrameSub)
    guidata( hObject, handles);