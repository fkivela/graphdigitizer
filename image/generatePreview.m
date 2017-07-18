function I = generatePreview(I, iIndices)

xSize = size(I,2);
ySize = size(I,1);
 
for j = 1:xSize
    i = iIndices(j);
 
    if isnan(i)
        continue
    end
    
    for dj = -1:1
        for di = -1:1
            
            if i + di < 1 || i + dj > ySize
                continue
            end
            
            if j + dj < 1 || j + dj > xSize
                continue
            end

            I(i + di, j + dj, :) = [0 256 0];
        end
    end
end

for j = 1:xSize
    i = iIndices(j);
    if isnan(i)
        continue
    end
    I(i, j, :) = [256 256 0];
end

end







