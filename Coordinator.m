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
            disp('coordinator delete')
           obj.Data.delete(x, y);
           obj.refresh
        end
        
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
end