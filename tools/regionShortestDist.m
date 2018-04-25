function rez = regionShortestDist(cc, i, j)
    pixlist1 = cc.PixelIdxList{i};
    pixlist2 = cc.PixelIdxList{j};
    
    s1 = size(pixlist1)
    s2 = size(pixlist2)
    
    LY = cc.ImageSize(1);
    
    mindist = intmax('int32')
    for i = 1:s1(2)
        for j = 1:s2(2)
            y1 = fix(pixlist1(i) / LY);
            x1 = mod(pixlist1(i), LY);
            
            y2 = fix(pixlist2(i) / LY);
            x2 = mod(pixlist2(i), LY);
            
            mindist = min([mindist ])
            
            
        end
    end
    
end