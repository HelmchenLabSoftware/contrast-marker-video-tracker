% Separates image into individual regions.
function cc = grayscaleLabelSimple(imageGray)

    % Convert image to binary (black & white)
    IM_Binary = imbinarize(imageGray);

    % Identify regions
    cc = bwconncomp(IM_Binary, 8);
end