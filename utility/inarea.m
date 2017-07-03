function result = inarea(point, area)

if ~isequal(size(point), [1 2])
    error(['Point must be a 1*2 vector, now its size was ' num2str(size(point))])
end

if ~isequal(size(area), [1 4])
    error(['Area must be a 1*4 vector, now its size was ' num2str(size(area))])
end

x = point(1);
y = point (2);

x1 = area(1);
y1 = area(2);

x2 = area(3);
y2 = area(4);


condXA = (x1 <= x) && (x <= x2);
condXB = (x2 <= x) && (x <= x1);
condX = condXA || condXB;

condYA = (y1 <= y) && (y <= y2);
condYB = (y2 <= y) && (y <= y1);
condY = condYA || condYB;

result = condX && condY;


