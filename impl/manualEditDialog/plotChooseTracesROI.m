function plotHandles = plotChooseTracesROI(handles)
    
    paramIdx = get(handles.manualPlotTypePopupMenu, 'Value');
    %if exist('handles.old_list', 'var')
    if handles.haveTimeMerge == 1
        
        if isempty(handles.traceIndices)
            tracesIdxs = 1:length(handles.old_list);
        else
            tracesIdxs = handles.traceIndices;
        end
        
        plotHandles = plotTracesByParameter(handles, paramIdx, tracesIdxs);
    else
        plotHandles = plotROIByParameter(handles, paramIdx);
    end
end