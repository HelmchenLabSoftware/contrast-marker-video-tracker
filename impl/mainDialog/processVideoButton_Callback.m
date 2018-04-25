% --- Executes on button press in processVideoButton.
% Apply selected operations to each frame in the video, play 
function processVideoButton_Callback(hObject, eventdata, handles)
    sliderBG = get(handles.bgSizeSlider, 'Value');
    sliderMin = get(handles.minThresholdSlider, 'Value');
    sliderMax = get(handles.maxThresholdSlider, 'Value');
    overlayOn = get(handles.overlayCheckbox, 'Value');
    saveVidOn = get(handles.saveVideoCheckBox, 'Value');
    recombRadius = get(handles.spaceMergeMaxDistSlider, 'Value');
    % sliderNoise = get(handles.regionMinSizeSlider, 'Value');
    % sliderNoiseInt = fix(sliderNoise);
    sliderBGInt = fix(sliderBG);

    noiseMinSize = 3;
    noiseMaxSize = 10000;
    
    if saveVidOn
        % User input of filename and path for video to save
        % Use most recently used path from parameters file
        load('userparam.mat', 'saveFilePath');
        disp(['using temporary path', saveFilePath]);
        [filename, pathname] = uiputfile('*.avi', 'Save', saveFilePath);
        assert(filename ~= 0, 'Bad filename');        
        handles.rezVidPathFilename = strcat(pathname,filename);
        
        % Save most recent path to parameters file
        saveFilePath = pathname;
        save('userparam.mat', 'saveFilePath', '-append');

        % Initialize video writer
        vWR = VideoWriter(handles.rezVidPathFilename);
        open(vWR);
    end
    
    handles.regioncount = [];
    handles.ProcessedXList=[];
    handles.ProcessedYList=[];
    handles.ProcessedMList=[];
    processedFrameList=[];

    % Restart VideoReader to get back to the first frame
    handles.v = VideoReader(handles.pathfilename);

    while hasFrame(handles.v)
    %for iFrame = 1:200

        % Read Frame
        thisFrame = readFrame(handles.v);

        % Apply filters
        background = imopen(thisFrame, strel('disk', sliderBGInt));
        thisFrameSub = thisFrame - background;
        thisFrameAdj = imadjust(thisFrameSub, [sliderMin sliderMax]);

        % Identify the regions
        %cc = grayscaleLabelSimple(thisFrameAdj);
        cc = grayscaleLabelZealousNoise(thisFrameAdj, recombRadius);

        % Denoise
        cc = regionNoiseFilter(cc, noiseMinSize, noiseMaxSize);

        % Compute metrics
        [x,y,m] = connectedRegionMetrics(cc);

        handles.regioncount = [handles.regioncount cc.NumObjects];
        handles.ProcessedXList = vertcat(handles.ProcessedXList, x);
        handles.ProcessedYList = vertcat(handles.ProcessedYList, y);
        handles.ProcessedMList = vertcat(handles.ProcessedMList, m);
        tmplist = zeros(cc.NumObjects, 1);
        tmplist(:) = length(handles.regioncount);
        processedFrameList = vertcat(processedFrameList, tmplist);

        fprintf('did frame %d of %d, nregionsFound=%d \n', length(handles.regioncount), handles.totalframes, cc.NumObjects);
        

        if saveVidOn
            % Label the regions
            thisFrameLabelRGB = labelRegions(cc);
            % If necessary, overlay regions over the original image
            if overlayOn
                thisFrameLabelRGB = overlayGrayAndCol(thisFrame, thisFrameLabelRGB);
            end

            % Write region color map video
            writeVideo(vWR, thisFrameLabelRGB);
        end
    end

    if saveVidOn
        % Close video writer
        close(vWR)
    end
    
    
    % Plot the metrics
    %save('vidresult.mat', 'frameidx', 'regioncount');

    figure
    subplot(2,2,1)
    scatter(processedFrameList, handles.ProcessedXList)
    title('X')

    subplot(2,2,2)
    scatter(processedFrameList, handles.ProcessedYList)
    title('Y')

    subplot(2,2,3)
    scatter(processedFrameList, handles.ProcessedMList)
    title('M')

    subplot(2,2,4)
    frameidx = 1:length(handles.regioncount);
    scatter(frameidx, handles.regioncount)
    title('R')
          
    % Update handles with new variables
    guidata( hObject, handles);
end