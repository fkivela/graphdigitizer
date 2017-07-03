function [i] = rind(x, max)

i = round(x);
    
if i < 1
    i = 1;
elseif i > max
    i = max;
end
