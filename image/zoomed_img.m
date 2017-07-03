function [lims] = zoomed_img(I, amount, relX, relY)

xSize = size(I,2);
ySize = size(I,1);
 
xSize2 = ceil(xSize / amount);
ySize2 = ceil(ySize / amount);

xStart = floor(relX * (xSize - xSize2)) + 1;
yStart = floor(relY * (ySize - ySize2)) + 1;

% xSumma = xStart + xSize2;
% ySumma = yStart + ySize2;

% if xStart == 0
%     xStart = 1;
% end
% if yStart == 0
%     yStart = 1;
% end

xEnd = xStart + xSize2 - 1;
yEnd = yStart + ySize2 - 1;

yStart2 = ySize - yEnd + 1; %Convert from y-indices to matrix indices
yEnd2 = ySize - yStart + 1;


lims = [xStart xEnd; yStart2 yEnd2];

% xRange = xStart:xStart + xSize2 - 1;
% yRange = yStart:yStart + ySize2 - 1;
% yRange = flip(ySize - yRange + 1, 2);
%J = I(yRange,xRange,:);