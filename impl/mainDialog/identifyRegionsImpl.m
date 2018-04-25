% --- Executes on button press in overlayCheckbox.
function identifyRegionsImpl(hObject, eventdata, handles)
    overlayOn = get(handles.overlayCheckbox, 'Value');
    recombRadius = get(handles.spaceMergeMaxDistSlider, 'Value');
    
    noiseMinSize = 3;
    noiseMaxSize = 10000;
    
    % Identify the regions
    %cc = grayscaleLabelSimple(handles.nextFrameAdj);
    cc = grayscaleLabelZealousNoise(handles.nextFrameAdj, recombRadius);
    fprintf("Identified %d regions after merge \n", cc.NumObjects);
    
    % Denoise
    cc = regionNoiseFilter(cc, noiseMinSize, noiseMaxSize);
    fprintf("Identified %d regions after denoise \n", cc.NumObjects);

    % Label the regions
    thisFrameLabelRGB = labelRegions(cc);
    
    % If necessary, overlay regions over the original image
    if overlayOn
        thisFrameLabelRGB = overlayGrayAndCol(handles.nextFrame, thisFrameLabelRGB);
    end
    
    imshow(thisFrameLabelRGB)
end