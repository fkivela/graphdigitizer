classdef ImageClicker < handle
    
    properties
        mode
        areaPoint1
    end
    
    properties(Access=private)
        figure
    end
    
    properties(Constant)
        pointers = struct(...
            'none',              'arrow',...
            'selectStartPoint',  'hand',...
            'areaDelete',        'hand',...
            'deletePoints',      'cross',...
            'overwritePoints',   'crosshair',...
            'selectScale1',      'crosshair',...
            'selectScale2',      'crosshair')
    end
    
    properties(Dependent)
        modelist
    end
    
    methods
        
        function obj = ImageClicker(figure)
            obj.figure = figure;
            obj.mode = 'none';
        end
        
        function result = modeIs(obj, modes)
            result = any(strcmp(obj.mode, modes));
        end
        
        
        function set.mode(obj, mode)
            if ~any(strcmp(mode, obj.modelist))
                error('Unrecognized mode "%s"; recognized modes are: %s, %s, %s, %s', mode, obj.modelist{:})
            end
            
            obj.mode = mode;
            obj.figure.Pointer = obj.pointers.(obj.mode);
        end
        
        function modelist = get.modelist(obj)
            modelist = fieldnames(obj.pointers);
        end
        
        function click(obj, x, y)
            
            handles = guidata(obj.figure);
            
            xSize = handles.PreviewImageController.xSize;
            ySize = handles.PreviewImageController.ySize;
            
            if x < 1 || x > xSize
                return
            end
            
            if y < 1 || y > ySize
                return
            end
            
            if obj.modeIs('selectStartPoint')
                
                handles.GraphFinderController.startX = x;
                handles.GraphFinderController.startY = y;
                obj.mode = 'none';
            
            elseif obj.modeIs({'deletePoints', 'areaDelete', 'overwritePoints'})
                        
                    if obj.modeIs('areaDelete')
                        if isempty(obj.areaPoint1)
                            
                            obj.areaPoint1 = [x, y];
                            obj.figure.Pointer = 'cross';
                            return
                        else
                            %guidata(hObject, handles)
                            %deletepoints([obj.areaPoint1(1) obj.areaPoint1(2) x y], hObject, eventdata, handles)
                            %handles = guidata(hObject);
                            obj.areaPoint1 = [];
                            obj.figure.Pointer = 'hand';
                            x = [obj.areaPoint1 x];
                            y = [obj.areaPoint1 y];
                        end
                    end
                
                handles.Coordinator.editData(x, y, obj.mode)
            else
                error(['Unrecognized mode: ' obj.mode])
            end
            
            
            %             switch obj.mode
            %                 case 'selectStartPoint'
            %                     handles.GraphFinderController.startX = x;
            %                     handles.GraphFinderController.startY = y;
            %                     obj.mode = 'none';
            %
            %                 case 'deletePoints'
            %                     %handles.Coordinator.deletePoint(x, y);
            %
            %                 case 'areaDelete'
            %
            %                     if isempty(obj.areaPoint1)
            %
            %                         obj.areaPoint1 = [x, y];
            %                         obj.figure.Pointer = 'cross';
            %                     else
            %                         %guidata(hObject, handles)
            %                         %deletepoints([obj.areaPoint1(1) obj.areaPoint1(2) x y], hObject, eventdata, handles)
            %                         %handles = guidata(hObject);
            %                         handles.Coordinator.areaDelete([obj.areaPoint1(1) x], [obj.areaPoint1(2) y])
            %                         obj.areaPoint1 = [];
            %                         obj.figure.Pointer = 'hand';
            %                     end
            %
            %                 case 'overwritePoints'
            %                     %                     handles.y_data(x) = y;
            %                     %
            %                     %                     guidata(hObject, handles)
            %                     %                     refresh_preview(hObject, eventdata, handles);
            %                     %                     handles = guidata(hObject);
            %                     handles.Coordinator.overwritePoint(x, y);
            %
            %             end
        end
        
        
        
    end
    
end

%#ok<*MCSUP>