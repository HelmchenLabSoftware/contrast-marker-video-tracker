function plotTracesByParameter(handles, paramIdx, tracesIdxs)
    axes(handles.manualTraceAxes);
    cla;
    set(gcf,'toolbar','figure');

    switch paramIdx
    case 1
        hold on
        for iTraces = 1:length(tracesIdxs)
            iRegOld = tracesIdxs(iTraces);
            plot(handles.old_list{iRegOld}.f, handles.old_list{iRegOld}.x, '-x');
        end
        hold off
        title('X')
        disp(length(handles.old_list))
    case 2
        hold on
        for iTraces = 1:length(tracesIdxs)
            iRegOld = tracesIdxs(iTraces);
            plot(handles.old_list{iRegOld}.f, handles.old_list{iRegOld}.y, '-x');
        end
        hold off
        title('Y')
    case 3
        hold on
        for iTraces = 1:length(tracesIdxs)
            iRegOld = tracesIdxs(iTraces);
            plot(handles.old_list{iRegOld}.f, handles.old_list{iRegOld}.m, '-x');
        end
        hold off
        title('M')
    end
    axis tight
end