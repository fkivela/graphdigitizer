function checkoutput(varargin)

if nargin == 0
    filename = 'output.txt';
else
    filename = varargin{1};
end

M = dlmread(filename,'',1,0);
x = M(:,1);
y = M(:,2);
plot(x,y);