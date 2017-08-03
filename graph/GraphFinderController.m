classdef GraphFinderController < handle
    
    properties(Access=private)
        GraphFinder
        figure
    end
    
    properties(Dependent)
        startX
        startY
        image
        graphColorParam
        colorDiffParam
        distanceDiffParam
    end
    
    methods
        
        function obj = GraphFinderController(figure, GraphFinder)
           obj.figure = figure;
           obj.GraphFinder = GraphFinder;
           
           handles = guidata(obj.figure);
           obj.startX = str2num(handles.edit_start_x.String);
           obj.startY = str2num(handles.edit_start_y.String);
           obj.graphColorParam = str2num(handles.edit_graphfinding1.String);
           obj.colorDiffParam = str2num(handles.edit_color_diff.String);
           obj.distanceDiffParam = str2num(handles.edit_distance_diff.String);
        end
        
        function set.image(obj, img)
           obj.GraphFinder.newImage(img); 
        end

        function set.startX(obj, value)
            value = obj.GraphFinder.trySetX(value);
            
            handles = guidata(obj.figure);
            handles.edit_start_x.String = value;
            %guidata(obj.figure, handles)
        end

        function set.startY(obj, value)
            value = obj.GraphFinder.trySetY(value);
            
            handles = guidata(obj.figure);
            handles.edit_start_y.String = value;
            %guidata(obj.figure, handles)
        end

        function set.graphColorParam(obj, value)
            value = obj.GraphFinder.trySetGraphParam(value);
            
            handles = guidata(obj.figure);
            handles.edit_graphfinding1.String = value;
            handles.edit_graphfinding2.String = num2str(100 - value);
            %guidata(obj.figure, handles)
        end

        function set.colorDiffParam(obj, value)
            value = obj.GraphFinder.trySetColorParam(value);
            
            handles = guidata(obj.figure);
            handles.edit_color_diff.String = value;
            guidata(obj.figure, handles)
        end

        function set.distanceDiffParam(obj, value)
            value = obj.GraphFinder.trySetShapeParam(value);

            
            handles = guidata(obj.figure);
            handles.edit_distance_diff.String = value;
            guidata(obj.figure, handles)
        end
        
        function [x, y] = findGraph(obj)
            x = obj.GraphFinder.xData;
            y = obj.GraphFinder.yData;
            
            if isempty(x) || isempty(y)
                x = [];
                y = [];
                disp('Insert error msg here')
                return
            end

        end
        
        
        
    end
    
end

%#ok<*MCSUP> I don't need to save instances of this class in files and I don't see an easy way to get rid of the warning
 %#ok<*ST2NM> I prefer str2num since it understands words such as 'pi'