function plotHandles = plotTracesByParameter(handles, paramIdx, tracesIdxs)
    axes(handles.manualTraceAxes);
    cla;
    set(gca,'Ydir','Normal')
    set(gcf,'toolbar','figure');

    
    plotHandles = [];
    switch paramIdx
    case 1
        hold on
        for iTraces = 1:length(tracesIdxs)
            iRegOld = tracesIdxs(iTraces);
            thisHandle = plot(handles.old_list{iRegOld}.f, handles.old_list{iRegOld}.x, '-x');
            plotHandles = [plotHandles thisHandle];
        end
        hold off
        title('X')
        disp(length(handles.old_list))
    case 2
        hold on
        for iTraces = 1:length(tracesIdxs)
            iRegOld = tracesIdxs(iTraces);
            thisHandle = plot(handles.old_list{iRegOld}.f, handles.old_list{iRegOld}.y, '-x');
            plotHandles = [plotHandles thisHandle];
        end
        hold off
        title('Y')
    case 3
        hold on
        for iTraces = 1:length(tracesIdxs)
            iRegOld = tracesIdxs(iTraces);
            thisHandle = plot(handles.old_list{iRegOld}.f, handles.old_list{iRegOld}.m, '-x');
            plotHandles = [plotHandles thisHandle];
        end
        hold off
        title('M')
    case 4
        hold on
        for iTraces = 1:length(tracesIdxs)
            iRegOld = tracesIdxs(iTraces);
            thisHandle = plot3(handles.old_list{iRegOld}.f, handles.old_list{iRegOld}.x, handles.old_list{iRegOld}.y, '-x');
            plotHandles = [plotHandles thisHandle];
        end
        hold off
        title('XY')
    case 5
        imshow(handles.firstFrame);
        h = gca;
        h.Visible = 'On';
        hold on
        for iTraces = 1:length(tracesIdxs)
            iRegOld = tracesIdxs(iTraces);
            thisHandle = plot(handles.old_list{iRegOld}.x, handles.old_list{iRegOld}.y);
            plotHandles = [plotHandles thisHandle];
        end
        hold off
    end
    %axis tight
    
    hA = gca;
    resetplotview(hA,'InitializeCurrentView');
end