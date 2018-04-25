function ccFilter = regionNoiseFilter(cc, minSize, maxSize)
    
    PixelIdxListNew = {};
    iNew = 0;
    
    for i = 1:cc.NumObjects
        s1 = size(cc.PixelIdxList{i});
        if (s1(1) >= minSize) && (s1(1) <= maxSize)
            iNew = iNew + 1;
            PixelIdxListNew{iNew} = cc.PixelIdxList{i};
        end
    end
    
    s2 = size(PixelIdxListNew);
    
    ccFilter = cc;
    ccFilter.NumObjects = s2(2);
    ccFilter.PixelIdxList = PixelIdxListNew;
end