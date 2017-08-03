classdef GraphFinder < handle
    
    properties
        colorDiffParameter
        shapeDiffParameter
        graphColorParameter
        startX
        startY
    end
    
    properties(Access=private)
        imageMatrix
        %imageMatrix is private in order to make it impossible to change it
        %without resetting startX and startY, the possible values of which
        %depend on imageMatrix.
    end
    
    properties(Dependent)
        parameters
        startPoint
        xData
        yData
        xSize
        ySize
    end
    
    methods
                
        function newImage(obj, img)
            obj.zero;
            obj.imageMatrix = img;
        end
        
        function x = trySetX(obj, value)
            if isempty(obj.imageMatrix) || isempty(value)
                x = [];
                return
            end
            
            x = checkvalue(value, 1, obj.xSize, 1);
            obj.startX = x;
        end
        
        function y = trySetY(obj, value)
            if isempty(obj.imageMatrix) || isempty(value)
                y = [];
                return
            end
            
            y = checkvalue(value, 1, obj.ySize, 1);
            obj.startY = y;
        end
        
        function cParam = trySetColorParam(obj, value)
            if isempty(value)
                cParam = 0;
                return
            end
            
            cParam = checkvalue(value, 0, 100);
            obj.colorDiffParameter = cParam;
        end
        
        function sParam = trySetShapeParam(obj, value)
            if isempty(value)
                sParam = 0;
                return
            end
            
            sParam = checkvalue(value, 0, 100);
            obj.shapeDiffParameter = sParam;
        end
        
        function gParam = trySetGraphParam(obj, value)
            if isempty(value)
                gParam = 0;
                return
            end
            
            gParam = checkvalue(value, 0, 100);
            obj.graphColorParameter = gParam;
        end
        
        function x = get.xData(obj)
            [x, ~] = obj.findGraph();
        end
        
        function y = get.yData(obj)
            [~, y] = obj.findGraph();
        end
        
        function xsz = get.xSize(obj)
            if isempty(obj.imageMatrix)
                xsz = [];
                return
            end
            
            xsz = size(obj.imageMatrix, 2);
        end
        
        function ysz = get.ySize(obj)
            if isempty(obj.imageMatrix)
                ysz = [];
                return
            end
            
            ysz = size(obj.imageMatrix, 1);
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
            x = [];
            y = [];
            
            if isempty(obj.imageMatrix)
                return
            end
            
            if obj.startPoint < 2
                return
            end
            
            if obj.parameters < 3
                return
            end
            
            [x, y] = findgraph(obj.imageMatrix, obj.startPoint, obj.parameters);
        end
        
        function zero(obj)
            obj.startX = [];
            obj.startY = [];
            obj.imageMatrix = [];
        end
        
    end
end