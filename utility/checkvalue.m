function [x] = checkvalue(varargin)

p = inputParser;
p.addRequired('Input', @(x) isscalar(x))
p.addOptional('Min', -inf, @isscalar)
p.addOptional('Max', inf, @isscalar)
p.addOptional('ForceInteger', 0, @(x) x == 0 || x == 1)

p.parse(varargin{:})
x = p.Results.Input;
forceInteger = p.Results.ForceInteger;
min = p.Results.Min;
max = p.Results.Max;

if forceInteger
    x = round(x);
end
    
if x < min
    x = min;
end

if x > max
    x = max;
end

if min > max
    x = [];
end