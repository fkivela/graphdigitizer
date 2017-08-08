classdef Coordinator < handle
    
    properties
        GraphFinderController
        PreviewImageController
        ImageClicker
        Data
    end
    
    methods
        
        function obj = Coordinator(GFC, PIC, IC, D)
            obj.GraphFinderController = GFC;
            obj.PreviewImageController = PIC;
            obj.ImageClicker = IC;
            obj.Data = D;
        end
        
        function findGraph(obj)
            [x, y] = obj.GraphFinderController.findGraph;
            
            if isempty(x) || isempty(y)
                return
            end
            
            obj.Data.xData = x;
            obj.Data.yData = y;
            
            obj.refresh
        end
        
        function newImage(obj, filename)
            obj.PreviewImageController.loadImage(filename)
            obj.GraphFinderController.image = obj.PreviewImageController.originalImageMatrix;
        end
        
        function refresh(obj)
            obj.PreviewImageController.refreshPreview(obj.Data.yData);
        end
        
        function deletePoint(obj, x, y)
           obj.Data.delete(x, y);
           obj.refresh
        end
        
        function areaDelete(obj, borders)
           obj.Data.areaDelete(borders);
           obj.refresh
        end
        
        function overwritePoint(obj, x, y)
           obj.Data.overwrite(x, y);
           obj.refresh
        end
        
        function editData(obj, x, y, mode)
            d = obj.Data;
            
            switch mode
               
                case 'deletePoints'
                    d.delete(x, y);
                case 'areaDelete'
                    d.areaDelete([x(1) y(2) x(2) y(2)]);
                case 'overwritePoints'
                    d.overwritePoints(x, y);
            end
            
            obj.refresh()
        end
        
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
end