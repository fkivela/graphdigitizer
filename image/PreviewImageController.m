classdef PreviewImageController < handle
    
    properties (Access = private)
        axes
        imageObject
        PreviewImage
    end
    
    properties(Dependent)
        imageMatrix
        originalImageMatrix
        xPosition
        yPosition
        zoomLevel
        xSize
        ySize
    end

    
    methods
        
        function obj = PreviewImageController(axes, PreviewImage)
            obj.axes = axes;
            obj.PreviewImage = PreviewImage;
            
            handles = guidata(obj.axes);
            obj.xPosition = handles.slider_x.Value;
            obj.yPosition = handles.slider_y.Value;
            obj.zoomLevel = handles.slider_z.Value;
        end
        
        function set.xPosition(obj, value)
            value = obj.PreviewImage.trySetX(value);
            
            handles = guidata(obj.axes);
            handles.slider_x.Value = value;
            %guidata(obj.axes, handles)
            obj.refreshImage
        end
        
        function set.yPosition(obj, value)
            value = obj.PreviewImage.trySetY(value);
            
            handles = guidata(obj.axes);
            handles.slider_y.Value = value;
            %guidata(obj.axes, handles)
            obj.refreshImage
        end
        
        function set.zoomLevel(obj, value)            
            value = obj.PreviewImage.trySetZ(value);
            
            handles = guidata(obj.axes);
            handles.slider_z.Value = value;
            %guidata(obj.axes, handles)
            obj.refreshImage
        end
        
        function x = get.xPosition(obj)
            x = obj.PreviewImage.xPosition;
        end
        
        function y = get.yPosition(obj)
            y = obj.PreviewImage.yPosition;
        end
        
        function z = get.zoomLevel(obj)
            z = obj.PreviewImage.zoomLevel;
        end
        
        function x = get.xSize(obj)
            x = obj.PreviewImage.xSize;
        end
        
        function y = get.ySize(obj)
            y = obj.PreviewImage.ySize;
        end
        
        function img = get.imageMatrix(obj)
           img = obj.PreviewImage.imageMatrix; 
        end
        
        function img = get.originalImageMatrix(obj)
           img = obj.PreviewImage.originalImageMatrix; 
        end

                
        function loadImage(obj, filename)
            
            handles = guidata(obj.axes);
            
            try
                obj.PreviewImage.loadImage(filename);
            catch
                handles.text_not_found.Visible = 'on';
                return
            end
                        
            obj.imageObject = image(obj.axes, obj.originalImageMatrix,'ButtonDownFcn',{@img_click_Callback});
            
            handles.text_not_found.Visible = 'off';
            handles.edit_filename.String = filename;
            
            obj.refreshImage
            %Zero all
            %erasefields(hObject, eventdata, handles, 'value', 'index',
            %'start') FIX
            
        end
        
        function refreshPreview(obj, yData)
            obj.PreviewImage.refreshPreview(yData);
            obj.imageObject.CData = obj.imageMatrix;
            obj.refreshImage;
        end
        
        function refreshImage(obj, yData)

            borders = obj.PreviewImage.zoomedImage;
            
            if isempty(borders)
               return 
            end
            
            xStart = borders(1,1);
            xEnd = borders(1,2);
            yStart = borders(2,1);
            yEnd = borders(2,2);
            
            obj.axes.XLim = [xStart xEnd];
            obj.axes.YLim = [yStart yEnd];
            
        end
                
    end
    
end

%#ok<*MCSUP> I don't need to save instances of this class in files and I don't see an easy way to get rid of the warning