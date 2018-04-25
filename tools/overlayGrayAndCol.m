% Overlay coloured regions over the gray image
function ImgRez = overlayGrayAndCol(Img1Gray, Img2RGB)

%     % Check if any of R/G/B components are non-zero
%     ColouredImageIdx = any( (Img2RGB > 0), 3 );
%     % Inidices
%     [idx(:,1), idx(:,2)] = ind2sub( size(ColouredImageIdx), find(ColouredImageIdx) );
% 
%     %ImgRez = Img1Gray;
%     ImgRez = cat(3, Img1Gray, Img1Gray, Img1Gray);
%     
%     % Place colours
%     ImgRez( idx(:,1), idx(:,2), : ) = Img2RGB( idx(:,1), idx(:,2), : );  

ImgRez(:,:,1) = (1 - max(Img2RGB,[], 3)) .* Img1Gray + Img2RGB(:,:,1);
ImgRez(:,:,2) = (1 - max(Img2RGB,[], 3)) .* Img1Gray + Img2RGB(:,:,2);
ImgRez(:,:,3) = (1 - max(Img2RGB,[], 3)) .* Img1Gray + Img2RGB(:,:,3);


% someRGB = any(Img2RGB > 0, 3);
% ImGrayNoRGB = Img1Gray;
% ImGrayNoRGB(someRGB) = 0;
% ImgRez = Img2RGB;
% ImgRez(:,:,1) = (1 - Img2RGB(:,:,1)) .* ImGrayNoRGB + Img2RGB(:,:,1);
% ImgRez(:,:,2) = (1 - Img2RGB(:,:,2)) .* ImGrayNoRGB + Img2RGB(:,:,2);
% ImgRez(:,:,3) = (1 - Img2RGB(:,:,3)) .* ImGrayNoRGB + Img2RGB(:,:,3);


%     ImgRez = cat(3, Img1Gray, Img1Gray, Img1Gray);

%     Img1Gray = double(Img1Gray) ./ 255;
%     Img2RGB  = double(Img2RGB)  ./ 255;
%     
%     binaryR = imbinarize(Img2RGB(:,:,1));
%     binaryG = imbinarize(Img2RGB(:,:,2));
%     binaryB = imbinarize(Img2RGB(:,:,3));
% 
%     ImgRez = Img2RGB;
%     
%     ImgRez(:,:,1) = (1 - binaryR) .* Img1Gray + Img2RGB(:,:,1);
%     ImgRez(:,:,2) = (1 - binaryG) .* Img1Gray + Img2RGB(:,:,2);
%     ImgRez(:,:,3) = (1 - binaryB) .* Img1Gray + Img2RGB(:,:,3);

%     Comb(:,:,1) = (1-I).*E + I; % red
% Comb(:,:,2) = (1-I).*E; % green
% Comb(:,:,3) = (1-I).*E; % blue

%     disp(max(max(Img1Gray)))
%     disp(max(max(Img2RGB)))
% 
%     ImgR = Img2RGB(:,:,1);
%     ImgG = Img2RGB(:,:,2);
%     ImgB = Img2RGB(:,:,3);
%     
%     posR = ImgR == 0;
%     posG = ImgG == 0;
%     posB = ImgB == 0;
%     
%     ImgR(posR) = Img1Gray(posR);
%     ImgG(posG) = Img1Gray(posG);
%     ImgB(posB) = Img1Gray(posB);
% 
%     ImgRez = cat(3, ImgR, ImgG, ImgB);
    

%     Img2Gray = rgb2gray(Img2RGB);
%     Img2Bin = imbinarize(Img2Gray);
% 
%     ImgRez = double(Img1Gray) - double(Img2Bin*255);     % Subtract the overlayed part 
%     ImgRez(ImgRez<0) = 0;                                % Remove any negative values resulting from subtraction
%     
%     disp(min(min(ImgRez)));
%     disp(max(max(ImgRez)));
%     
%     ImgRez = cat(3, ImgRez, ImgRez, ImgRez);             % Convert to RGB
%     ImgRez = (ImgRez + double(Img2RGB)) / 255;           % Add colorful part
%     
%     disp(min(min(ImgRez)));
%     disp(max(max(ImgRez)));
end