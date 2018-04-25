% Separates image into individual regions. Recombines nearby regions.
% For details see https://blogs.mathworks.com/steve/2010/09/07/almost-connected-component-labeling/
function [RGB_label, IM_Binary, cc] = grayscaleLabelMergeFilter(imageGray, recombRadius, minTruncate)

% Convert image to binary (black & white)
IM_Binary = imbinarize(imageGray);

% %%% Standard labeling %%%
cc = bwconncomp(IM_Binary, 8);
%labeled = labelmatrix(cc);
%whos labeled;
%RGB_label = label2rgb(labeled, @spring, 'c');
%RGB_label = label2rgb(labeled, 'jet', [.0 .0 .0]);

% Create new array, put first region there.
% Loop over all pairs of current region with following
% If following region not NaN and min distance is below threshold
% then merge into current and set it to Nan
PixelIdxListNew = [];
BanList = zeros(1, cc.NumObjects);
iNew = 1;

for i = 1:cc.NumObjects
    if BanList(i) == 0
        PixelIdxListNew(iNew) = cc.PixelIdxList{i};
        iNew = iNew + 1;
        
        for j = i+1:cc.NumObjects
            if regionShortestDist(cc, i, j) <= recombRadius
                BanList(j) = 1;
                PixelIdxListNew{iNew} = cc.PixelIdxList{j};
            end
        end
    end
end

cc.PixelIdxList = PixelIdxListNew;




%%% Labeling with recombination
% recombRadius = get(handles.spaceMergeMaxDistSlider, 'Value');
% imageInflated = bwdist(IM_Binary) <= recombRadius;
% imageInflatedObjects = bwconncomp(imageInflated);
% imageInflatedLabel = labelmatrix(imageInflatedObjects);
% imageInflatedLabel(~IM_Binary) = 0;
% RGB_label = imageInflatedLabel;
% fprintf("Identified %d regions", imageInflatedObjects.NumObjects);
% imshow(label2rgb(imageInflatedLabel, 'jet', [.7 .7 .7]))