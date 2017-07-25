function smoothedY = smooth(x, y, amount)

%The amount of x-space between data points is relevant if data points are not equally spaced
%spaces(i) = the length of the part of the x-axis where x(i) is the closest
%data point

spaces = x;
spaces(1) = (x(2) - x(1)) / 2;
spaces(end) = (x(end) - x(end-1)) / 2;

for i = 2:length(x) - 1
    spaces(i) = (x(i+1) - x(i-1)) / 2; 
end

smoothedY = y;

range = amount / 100 * (x(end) - x(1)); %Amount given as a percentage

sz = length(x);

for i = 1:sz
    currentX = x(i);
    
    upperLim = currentX+range/2;
    lowerLim = currentX-range/2;
    
    yInRange = y(lowerLim <= x & x <= upperLim);
    
    %Weighted average of y-values in range
    sum = 0;
    coeffSum = 0;
    
    for j=1:length(yInRange)
        sum = sum + yInRange(j)*spaces(j);
        coeffSum = coeffSum + spaces(j);
    end

    smoothedY(i) = sum / coeffSum;    
end


