classdef GraphFinder < handle
   
    properties
      colorDiffParameter
      shapeDiffParameter
      graphColorParameter
      startX
      startY
      imageMatrix
    end
    
    properties(Dependent)
       parameters
       startPoint
       x
       y
    end
    
    methods
        
        function obj = GraphFinder()
            obj.colorDiffParameter = NaN;
            obj.shapeDiffParameter = NaN;
            obj.graphColorParameter = NaN;
            obj.startX = NaN;
            obj.startY = NaN;
            obj.imageMatrix = NaN;
        end
        
         function set.imageMatrix(obj, value)
             %Since Matlab does not guarantee initialization order, this
             %functionality should be changed if instances of this class
             %have to be ever saved in a file.
             obj.zero()
             obj.imageMatrix = value;
         end
         
%          function trySetX(obj, value)
%             
%              obj.startX = value;
%             r = value;
%          end
        
        function x = get.x(obj)
            [x, ~] = obj.findGraph();
        end
        
        function y = get.y(obj)
            [~, y] = obj.findGraph();
        end
        
        function par = get.parameters(obj)
           par(1) = obj.colorDiffParameter;
           par(2) = obj.shapeDiffParameter;
           par(3) = obj.graphColorParameter;
        end
        
        function point = get.startPoint(obj)
            point(1) = obj.startX;
            point(2) = obj.startY;
        end
        
        function [x, y] = findGraph(obj)
            x = NaN;
            y = NaN;
            
            if isnan(obj.imageMatrix)
                return
            end
            
            if any(isnan(obj.startPoint))
                return
            end
            
            if any(isnan(obj.parameters))
                return
            end
            
            [x, y] = findgraph(obj.imageMatrix, obj.startPoint, obj.parameters);
        end
        
        function zero(obj)
            obj.startX = NaN;
            obj.startY = NaN;
            obj.imageMatrix = NaN;
        end
        
   end
end