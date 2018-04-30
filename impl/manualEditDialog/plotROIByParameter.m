function plotROIByParameter(handles, paramIdx)
    axes(handles.manualTraceAxes);
    cla;
    set(gcf,'toolbar','figure');

    switch paramIdx
    case 1
        scatter(handles.processedFrameList, handles.ProcessedXList)
        title('X')
    case 2
        scatter(handles.processedFrameList, handles.ProcessedYList)
        title('Y')
    case 3
        scatter(handles.processedFrameList, handles.ProcessedMList)
        title('M')
    end
    axis tight
end