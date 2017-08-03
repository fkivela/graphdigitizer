classdef DataManagerluonnos < handle
    
    properties
        imageMatrix
        GraphFinder
        ScaleFinder
        Data
    end
    
    properties(Dependent)
        colorDiffParameter
        shapeDiffParameter
        graphColorParameter
        startX
        startY
        scaleMode
        pointData
        xSize
        ySize
    end
    
    methods
        
        function obj = DataManager()
            obj.GraphFinder = GraphFinder();
            obj.ScaleFinder = ScaleFinder();
            obj.Data = Data();
        end
        
        function value = setColorDiffParameter(obj, value)
            value = obj.GraphFinder.trySetColorParam(value);
        end
        
%         function cdp = get.colorDiffParameter(obj)
%             cdp = obj.GraphFinder.colorDiffParameter;
%         end
        
        function value = setShapeDiffParameter(obj, value)
            value = obj.GraphFinder.trySetShapeParam(value);
        end
        
%         function sdp = get.shapeDiffParameter(obj)
%             sdp = obj.GraphFinder.shapeDiffParameter;
%         end
        
        function value = setGraphColorParameter(obj, value)
            value = obj.GraphFinder.trySetGraphParam(value);
        end
        
%         function gcp = get.graphColorParameter(obj)
%             gcp = obj.GraphFinder.graphColorParameter;
%         end
        
        function value = setStartX(obj, value)
            value = obj.GraphFinder.trySetX;
        end
        
%         function x = get.startX(obj)
%             x = obj.GraphFinder.startX;
%         end
        
        function value = setStartY(obj, value)
            value = obj.GraphFinder.trySetY;
        end
        
%         function y = get.startY(obj)
%             y = obj.GraphFinder.startY;
%         end

        
                
        
    end
    
end