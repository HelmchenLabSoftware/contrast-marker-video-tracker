function regCount = frameList2regCount(frameList, maxFrame)

    regCount = zeros(maxFrame, 1);

    fListIdx = 1;
    lenFList = length(frameList);
    
    % Loop over all possible frames. Count number of repeating frames, even
    % if it is zero.
    for iFrame = 1:maxFrame
        nRegThis = 0;
        while (fListIdx <= lenFList) && (frameList(fListIdx) == iFrame)
            fListIdx = fListIdx + 1;
            nRegThis = nRegThis + 1;
        end
        regCount(iFrame) = nRegThis;
    end
end
