function plotHandles = plotROIByParameter(handles, paramIdx)
    axes(handles.manualTraceAxes);
    cla;
    set(gca,'Ydir','Normal')
    set(gcf,'toolbar','figure');

    plotHandles = [];
    switch paramIdx
    case 1
        thisHandle = scatter(handles.processedFrameList, handles.ProcessedXList);
        plotHandles = [thisHandle];
        title('X')
    case 2
        thisHandle = scatter(handles.processedFrameList, handles.ProcessedYList);
        plotHandles = [thisHandle];
        title('Y')
    case 3
        thisHandle = scatter(handles.processedFrameList, handles.ProcessedMList);
        plotHandles = [thisHandle];
        title('M')
    case 4
        thisHandle = scatter3(handles.processedFrameList, handles.ProcessedXList, handles.ProcessedYList);
        plotHandles = [thisHandle];
        title('XY')
    case 5
        imshow(handles.firstFrame);
        h = gca;
        h.Visible = 'On';
        hold on
        thisHandle = scatter(handles.ProcessedXList, handles.ProcessedYList);
        plotHandles = [thisHandle];
        hold off
    end
    
    hA = gca;
    resetplotview(hA,'InitializeCurrentView');
end