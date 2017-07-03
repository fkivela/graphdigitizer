function [xOut, yOut] = removeNaNs(xIn, yIn)

if size(xIn) ~= size(yIn)
    error('xIn and yIn must be the same size')
end

xOut = xIn;
yOut = yIn;

i = 1;
while i <= size(xOut, 2)
   if isnan(yOut(i))
       xOut(i) = [];
       yOut(i) = [];
   else
       i = i + 1;
   end
end

end
