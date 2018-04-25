function imgRGB = labelRegions(cc)
    labeled = labelmatrix(cc);
    %whos labeled;
    %thisFrameLabelRGB = label2rgb(labeled, @spring, 'c');
    
    % Note: Last param is BG color - keep empty for good merge
    imgRGB = label2rgb(labeled, 'jet', [.0 .0 .0]);
end