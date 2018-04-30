% Separates image into individual regions. Recombines nearby regions.
% For details see https://blogs.mathworks.com/steve/2010/09/07/almost-connected-component-labeling/
function cc = grayscaleLabelZealousNoise(imageGray, recombRadius)

    % Convert image to binary (black & white)
    IM_Binary = imbinarize(imageGray);
    
    %%% Regular identification
    cc_reg = bwconncomp(IM_Binary);    

    %%% Labeling with recombination
    IM_Binary_Inflated = bwdist(IM_Binary) <= recombRadius;
    cc_infl = bwconncomp(IM_Binary_Inflated);
    lm_infl = labelmatrix(cc_infl);
    %lm(~IM_Binary) = 0;

    % Construct a map from color to PixelIdxList
    % For each regular region, check its color in inflated labelmatrix
    % Thus merge regular regions if they share color
    LY = cc_reg.ImageSize(1);
    colorRegMap = containers.Map('KeyType','int32','ValueType','any');
    
    for i = 1:cc_reg.NumObjects
        thisIdxList = cc_reg.PixelIdxList{i};
        
        y = mod(thisIdxList(1), LY) + 1;
        x = fix(thisIdxList(1) / LY) + 1;
        color = lm_infl(y, x);
        
        if isKey(colorRegMap, color)
%             disp(size(colorRegMap(color)))
%             disp(size(thisIdxList))
            colorRegMap(color) = vertcat(colorRegMap(color), thisIdxList);
        else
            colorRegMap(color) = thisIdxList;
        end
    end
    
    % Create new region set where disjoint nearby regions are merged
    cc = cc_infl;
    cc.PixelIdxList = values(colorRegMap);
end