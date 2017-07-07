function [x, y] = findgraph(I, startPoint, diffParam, colorParam)

xSize = size(I, 2);
ySize = size(I, 1);
x = 1:xSize;

startPointJ = startPoint(1);
startPointI = startPoint(2);

graphColor = I(startPointI, startPointJ, :);
graphColor = double(squeeze(graphColor))';

%Finding pixels belonging to the graph
[graphIndices, smallestDifferences] = findIndices();

%Automatic removal of unnecessary pixels
% avgDifference = mean(smallestDifferences);
for jj = 1:xSize
    if smallestDifferences(jj) > diffParam
       graphIndices(jj) = NaN;
    end
end

y = graphIndices;


function [graphIndices, smallestDifferences] = findIndices()

%Calculate color differences between graph and pixels
colors = double(I);
differences = zeros(ySize, xSize);

for i = 1:ySize
    for j = 1:xSize
        color = [colors(i, j, 1), colors(i, j, 2), colors(i, j, 3)];
        difference = norm(color - graphColor);
        differences(i, j) = difference;
    end
end

graphIndices = zeros(1, xSize);
smallestDifferences = 999 * ones(1, xSize);

%Find i-indices of graph points using differences
[indicesEnd, diffEnd] = indicesFromDifferences(startPointI, colors, differences(:, startPointJ : xSize), colorParam);
graphIndices(startPointJ : xSize) = indicesEnd;
smallestDifferences(startPointJ : xSize) = diffEnd;

[indicesStart, diffStart] = indicesFromDifferences(startPointI, colors, differences(:, startPointJ: -1 : 1), colorParam);
graphIndices(startPointJ : -1 : 1) = indicesStart;
smallestDifferences(startPointJ : -1 : 1) = diffStart;

end

end

function [graphIndices, smallestDifferences] = indicesFromDifferences(startI, colors, differences, colorParam)

ySize = size(differences, 1);
xSize = size(differences, 2);

graphIndices = zeros(1, xSize);
smallestDifferences = graphIndices;

scores = zeros(ySize, xSize);

for j = 1:xSize

    for i = 1:ySize
        colorDiff = 1000 * differences(i, j) / sqrt(3);
        
        if j == 1
            newI = startI;
        elseif j == 2
            newI = 2 * graphIndices(j - 1) - startI;
        else
            newI = 2 * graphIndices(j - 1) - graphIndices(j - 2);
        end
   
        shapeDiff = 1000 * abs(i - newI) / ySize;
        scores(i, j) = colorParam * colorDiff + (1-colorParam) * shapeDiff;

    end
    
    column = scores(:,j);
    [~, sortedIndices] = sort(column);
    bestI = sortedIndices(1);
    graphIndices(j) = bestI;
    smallestDifferences(j) = column(bestI);

end

%stopcondition = @(i, j) (differences(i, j) > sqrt(3) / 2) || (sum(colors(i,j,1:3),3) < sqrt(3) / 10);
%stopcondition = @(i, j) (differences(i, j) > sqrt(3) / 2) || (sum(colors(i,j,1:3),3) < 0.3);
%stopcondition = @(i, j) (differences(i, j) > sqrt(3) / 2) || true;
stopcondition = @(i, j) (differences(i, j) > sqrt(3) / 5);


for j = 1:xSize
    i0 = graphIndices(j);

    list = [i0 differences(i0, j)];
    
    for i = i0 + 1 : i0 + ySize / 20
        if i < 1 || i > ySize
            continue
        end
        
        if stopcondition(i, j)
            break
        end
        
        list = cat(1, list, [i, differences(i, j)]);
    end
    
    for i = i0 - 1 : -1 : i0 - ySize / 20
        if i < 1 || i > ySize
            continue
        end
                
        if stopcondition(i, j)
            break
        end
        
        list = cat(1, list, [i, differences(i, j)]);
    end
    
    total = 0;
    colorsum = 0;
    for i = 1:size(list, 1)
        total = total + list(i, 1) * (sqrt(3) - list(i, 2));
        colorsum = colorsum + (sqrt(3) - list(i, 2));
    end
    
    graphIndices(j) = round(total / colorsum);
    
     %if j < 5
     %    j
     %    list
     %end
end    

end