classdef Data < handle
    
    properties
        yData
        xData
    end
    
    methods
        
        function overwrite(obj, xPoints, yPoints)
            
            for i = 1:length(xPoints)
                obj.yData(xPoints(i)) = yPoints(i);
            end
        end
        
        function delete(obj, xPoints, yPoints)
            for i = 1:length(xPoints)
                if obj.yData(xPoints(i)) == yPoints(i)
                    obj.yData(xPoints(i)) = NaN;
                end
            end
        end
        
        function areaDelete(obj, borders) %borders = [x1 y1 x2 y2]
            for i = 1:length(obj.xData)
                if inarea([obj.xData(i) obj.yData(i)], borders)
                    obj.delete(obj.xData(i), obj.yData(i))
                end
            end
        end
        
    end
end