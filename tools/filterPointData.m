function rez = filterPointData(regCount, fList, xList, yList, mList, filterParam)

    % Status update before
    nReg = length(regCount);
    nROITot = length(xList);
    nROIExp = sum(regCount);
    fprintf("before filter nFrames=%d, totalRegExpected=%d, totalRegReal=%d \n", nReg, nROIExp, nROITot);

    % Create output structure
    rez = struct();
    rez.regCount = zeros(1, nReg);
    rez.fList = fList;
    rez.xList = xList;
    rez.yList = yList;
    rez.mList = mList;
    
    % Determine which frames will be affected
    if filterParam.useT
        frameMin = max(filterParam.minT, 1);
        frameMax = min(filterParam.maxT, nReg);
    else
        frameMin = 1;
        frameMax = nReg;
    end
    
    % Loop over all frames and regions
    % Determine which ROI fit the filter and mark them for deletion
    deleteList = [];
    
    iROICount = 0;
    for iFrame = frameMin:frameMax
        subROICount = 0;
        for iROIThis = 1:regCount(iFrame)
            iROICount = iROICount + 1;

            x = xList(iROICount);
            y = yList(iROICount);
            m = mList(iROICount);

            fitX = (~filterParam.useX) || ((x >= filterParam.minX) && (x <= filterParam.maxX));
            fitY = (~filterParam.useY) || ((y >= filterParam.minY) && (y <= filterParam.maxY));
            fitM = (~filterParam.useM) || ((m >= filterParam.minM) && (m <= filterParam.maxM));

            if fitX && fitY && fitM
                subROICount = subROICount + 1;
                deleteList = [deleteList iROICount];
            end
        end

        % Decrease region count per frame, based on number of deleted regions
        rez.regCount(iFrame) = regCount(iFrame) - subROICount;
    end
    
    % Delete regions
    rez.fList(deleteList) = [];
    rez.xList(deleteList) = [];
    rez.yList(deleteList) = [];
    rez.mList(deleteList) = [];

    % Status update after
    nReg = length(rez.regCount);
    nROITot = length(rez.xList);
    nROIExp = sum(rez.regCount);
    fprintf("deleted %i ROI \n", length(deleteList));
    fprintf("after filter nFrames=%d, totalRegExpected=%d, totalRegReal=%d \n", nReg, nROIExp, nROITot);
end