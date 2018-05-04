function rez = filterTraceData(old_list, filterParam)

    fprintf("before filter number of traces is %i \n", length(old_list));

    % Loop over all traces, mark ones that fit deletion criterion
    deleteList = [];
    for iTraces = 1:length(old_list)
        thisTrace = old_list{iTraces};
        
        % If this trace fits frame-filter, or no frame-filter selected
        if (~filterParam.useT) || (min(thisTrace.f) >= filterParam.minT) && (max(thisTrace.f) <= filterParam.maxT)
            
            if filterParam.useT && ~filterParam.useX && ~filterParam.useY && ~filterParam.useM
                % If frame-filter is the only filter and this trace fits, delete it
                deleteList = [deleteList iTraces];
            else
                % Check each point for fitness into X,Y,M criteria
                for iFrame = 1:length(thisTrace.f)
                    x = thisTrace.x(iFrame);
                    y = thisTrace.y(iFrame);
                    m = thisTrace.m(iFrame);

                    fitX = (~filterParam.useX) || ((x >= filterParam.minX) && (x <= filterParam.maxX));
                    fitY = (~filterParam.useY) || ((y >= filterParam.minY) && (y <= filterParam.maxY));
                    fitM = (~filterParam.useM) || ((m >= filterParam.minM) && (m <= filterParam.maxM));

                    if fitX && fitY && fitM
                        deleteList = [deleteList iTraces];
                        break  % If at least one datapoint fits criterion, no need to check the rest
                    end
                end
            end
        end
    end
    
    % Create output structure
    rez = struct();
    rez.old_list = old_list;
    
    % Delete filtered traces
    rez.old_list(deleteList) = [];
    
    fprintf("deleted %i traces \n", length(deleteList));
    fprintf("after filter number of traces is %i \n", length(rez.old_list));

    % Optional: get point new point arrays from trace arrays, thus deleting
    % associated points as well
end