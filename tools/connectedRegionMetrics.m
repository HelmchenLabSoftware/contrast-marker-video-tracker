function [x, y, m] = connectedRegionMetrics(cc)

x = zeros(cc.NumObjects, 1, 'double');
y = zeros(cc.NumObjects, 1, 'double');
m = zeros(cc.NumObjects, 1, 'uint32');

LY = cc.ImageSize(1);

for i = 1:cc.NumObjects
    tmp = size(cc.PixelIdxList{i});
    m(i) = tmp(1);
    col = cc.PixelIdxList{i};
    
    for j = 1:m(i)
        x(i) = x(i) + fix(col(j) / LY);
        y(i) = y(i) + mod(col(j), LY);
    end
    y(i) = y(i) / double(m(i));
    x(i) = x(i) / double(m(i));
end


