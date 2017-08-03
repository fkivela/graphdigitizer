classdef PreviewImage < handle
       
    properties
        xPosition
        yPosition
        zoomLevel
        minZoom;
        maxZoom;
        imageMatrix
    end
    
    properties(Dependent)
        xSize
        ySize
    end
    
    methods
        
        function obj = PreviewImage(minZoom, maxZoom)
            obj.minZoom = minZoom;
            obj.maxZoom = maxZoom;
        end

        function x = trySetX(obj, value)
            x = checkvalue(value, 0, 1);
            obj.xPosition = value;
        end

        function y = trySetY(obj, value)
            y = checkvalue(value, 0, 1);
            obj.yPosition = value;
        end
        
        function z = trySetZ(obj, value)
            z = checkvalue(value, obj.minZoom, obj.maxZoom);
            obj.zoomLevel = value;
        end
                
        function xsz = get.xSize(obj)
            xsz = size(obj.imageMatrix, 2);
        end
        
        function ysz = get.ySize(obj)
            ysz = size(obj.imageMatrix, 1);
        end
        
        function img = loadImage(obj, filename)
            
            [img, map] = imread(filename);
            
            %Convert gifs(1d array) to 3d array
            if size(size(img), 2) < 3
                img = ind2rgb(img, map);
            end
            
            obj.imageMatrix = img;            
        end
        
        function borders = zoomedImage(obj)
                        
            if isempty(obj.imageMatrix)
                borders = [];
                return
            end

            borders = zoomedimage(obj.imageMatrix, obj.zoomLevel, obj.xPosition, obj.yPosition);
            
        end
        
    end
        
end

%#ok<*MCSUP> I don't need to save instances of this class in files and I don't see an easy way to get rid of the warning