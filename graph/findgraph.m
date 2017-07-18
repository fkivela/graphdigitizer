function [x, y] = findgraph(I, startPoint, parameters)

colorDiffPerc = parameters(1); %Color difference tolerance percentage
shapeDiffPerc = parameters(2);
graphColorPerc = parameters(3);

colors = im2double(I); %Converts the image to a 3d array with values between 0 and 1

[graphIndices, colorDifferences, shapeDifferences] = findindices(colors, graphColorPerc, startPoint); %Find the graph using a rough algorithm
graphIndices = findmiddle(graphIndices, colorDifferences); %Find the middle of thick lines
graphIndices = removedifferences(graphIndices, colorDifferences, shapeDifferences, colorDiffPerc, shapeDiffPerc); %Remove pixels with color or shape variation outside tolerance

x = 1:size(I, 2);
y = graphIndices;
end


function [graphIndices, colorDifferences, shapeDifferences] = findindices(colors, graphColorPerc, startPoint)

[ySize, xSize, ~] = size(colors);
startPointJ = startPoint(1);
startPointI = startPoint(2);
maxDiff = sqrt(3);  
graphColor = (squeeze(colors(startPointI, startPointJ, :)))';

shapeDifferences = zeros(ySize, xSize);
colorDifferences = zeros(ySize, xSize);
graphIndices = zeros(1, xSize);
scores = zeros(ySize, xSize);

prevI = startPointI;
for j = startPointJ:xSize
    newBestI = findbesti(j, prevI);
    prevI(2) = prevI(1);
    prevI(1) = newBestI;
end

prevI = startPointI;
for j = startPointJ:-1:1
        newBestI = findbesti(j, prevI);
    prevI(2) = prevI(1);
    prevI(1) = newBestI;

end

function bestI = findbesti(j, previousI)

sz = size(previousI, 2);
if sz == 1
    newI = previousI(1);
elseif sz == 2
    newI = 2 * previousI(1) - previousI(2);
end

newI = min([ySize newI]); %Assure that newI is withing image borders
newI = max([1 newI]);
       
for i = 1:ySize
        color = [colors(i, j, 1), colors(i, j, 2), colors(i, j, 3)];
        colorDiff = 100 * norm(color - graphColor) / maxDiff;
        
        shapeDiff = 100 * abs(i - newI) / ySize;

        scores(i, j) = graphColorPerc / 100 * colorDiff + (1 - graphColorPerc / 100) * shapeDiff;
        colorDifferences(i, j) = colorDiff;
        shapeDifferences(i, j) = shapeDiff;
end

column = scores(:,j);
[~, sortedIndices] = sort(column);
bestI = sortedIndices(1);
graphIndices(j) = bestI;
end
end


function graphIndices = findmiddle(graphIndices, colorDifferences)

[ySize, xSize] = size(colorDifferences);
maxDiff = sqrt(3);
stopcondition = @(i, j) (colorDifferences(i, j) >  20); %Make this an adjustable parameter?

for j = 1:xSize
    i0 = graphIndices(j);    
    list = i0;
    
    for i = i0 + 1 : i0 + ySize / 20 %Make this an adjustable parameter?
        
        if i < 1 || i > ySize
            continue
        end
        
        if stopcondition(i, j)
            break
        end
        
        list = cat(1, list, i);
    end
    
    for i = i0 - 1 : -1 : i0 - ySize / 20
        if i < 1 || i > ySize
            continue
        end
                
        if stopcondition(i, j)
            break
        end
        
        list = cat(1, list, i);
    end
        
    %Weighted average of pixels in list:
    total = 0;
    colorsum = 0;
    for i = 1:size(list)
        total = total + list(i) * (maxDiff - list(i));
        colorsum = colorsum + (maxDiff - list(i));
    end
    
    graphIndices(j) = round(total / colorsum);    
end    

end


function graphIndices = removedifferences(graphIndices, colorDifferences, shapeDifferences, colorDiffPerc, shapeDiffPerc)
xSize = size(graphIndices, 2);

for jj = 1:xSize
    if colorDifferences(graphIndices(jj), jj) > colorDiffPerc
       graphIndices(jj) = NaN;
       continue %No need to compare distDiff if value is already NaN
    end
    
    if shapeDifferences(graphIndices(jj), jj) > shapeDiffPerc
       graphIndices(jj) = NaN;
    end
end
        
end
