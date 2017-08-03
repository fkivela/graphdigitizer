classdef ScaleFinder < handle
    
    properties
        scaleMode
        pointData
        xSize
        ySize
    end
    
    properties(Dependent)
        xScale
        yScale
        x0index
        y0index
    end
    
    methods
        
        function obj = ScaleFinder(startingMode)
            obj.checkMode(startingMode);
            
            obj.scaleMode = startingMode;
            obj.pointData = obj.blankStruct;
            obj.xSize = NaN;
            obj.ySize = NaN;
        end
        
        function set.scaleMode(obj, value)
            obj.checkMode(value);
            obj.scaleMode = value;
        end
        
        function value = trySet(obj, PixOrVal, field, value)
            
            xFields = {'xAxisX' 'yAxisX' 'x1' 'x2' 'xAxisX1' 'xAxisX2'};
            yFields = {'xAxisY' 'yAxisY' 'y1' 'y2' 'yAxisY1' 'yAxisY2'};
            
            if ~(any(strcmp(xFields, field)) || any(strcmp(yFields, field)))
                error(['Invalid field name: ' field])
            end
            
            if strcmp(PixOrVal, 'pixels')
                
                if any(strcmp(xFields, field))
                    value = obj.checkX(value);
                elseif any(strcmp(yFields, field))
                    value = obj.checkY(value);
                end
                
            elseif ~strcmp(PixOrVal, 'values')
                error(['PixOrVal must equal ''pixels'' or ''values'', now was: ' PixOrVal])
            end
            
            obj.pointData.(obj.scaleMode).(PixOrVal).(field) = value;
        end
        
        function xsc = get.xScale(obj)
            [xsc, ~, ~, ~] = obj.findScale();
        end
        
        function ysc = get.yScale(obj)
            [~, ysc, ~, ~] = obj.findScale();
        end
        
        function x0i = get.x0index(obj)
            [~, ~, x0i, ~] = obj.findScale();
        end
        function y0i = get.y0index(obj)
            [~, ~, ~, y0i] = obj.findScale();
        end
        
        function zero(obj)
            obj.pointData = blankStruct;
            obj.xSize = NaN;
            obj.ySize = NaN;
        end
        
        function [xScale, yScale, x0index, y0index] = findScale(obj)
            pixelNames = fieldnames(obj.pointData.(obj.scaleMode).pixels);
            
            indices = [NaN NaN NaN NaN];
            for i = 1:length(pixelNames)
                indices(i) = obj.pointData.(obj.scaleMode).pixels.(pixelNames{i});
            end
            
            valueNames = fieldnames(obj.pointData.(obj.scaleMode).values);
            
            values = [NaN NaN NaN NaN];
            for i = 1:length(valueNames)
                values(i) = obj.pointData.(obj.scaleMode).values.(valueNames{i});
            end
            
            [xScale, yScale, x0index, y0index] = findscale(indices, values, obj.scaleMode);
        end
        
        function printData(obj)
            
            modes = fieldnames(obj.pointData);
            for i = 1:length(modes)
                mode = modes{i};
                fprintf('%s:\n', mode)
                types = fieldnames(obj.pointData.(mode));
                
                for j = 1:length(types)
                    pOrV = types{j};
                    fprintf('    %s:\n', pOrV)
                    fields = fieldnames(obj.pointData.(mode).(pOrV));
                    
                    for k = 1:length(fields)
                        field = fields{k};
                        fprintf('        %s: %g\n', field, obj.pointData.(mode).(pOrV).(field))
                    end
                end
            end
            
        end
        
    end
    
    methods(Access=private)
        
        function x = checkX(obj, value)
            if isnan(obj.xSize)
                x = NaN;
                return
            end
            
            x = checkvalue(value, 1, obj.xSize, 1);
        end
        
        function y = checkY(obj, value)
            if isnan(obj.ySize)
                y = NaN;
                return
            end
            
            y = checkvalue(value, 1, obj.ySize, 1);
        end

    end
    
    methods(Static, Access=private)
        
        function bStruct = blankStruct()
            sp = struct('xAxisX', NaN, 'xAxisY', NaN, 'yAxisX', NaN, 'yAxisY', NaN);
            sv = struct('xAxisX', NaN, 'yAxisY', NaN);
            aStruct = struct('pixels', sp, 'values', sv);
            
            s = struct('x1', NaN, 'y1', NaN, 'x2', NaN, 'y2', NaN);
            pStruct = struct('pixels', s, 'values', s);
            
            s = struct('xAxisX1', NaN, 'xAxisX2', NaN, 'yAxisY1', NaN, 'yAxisY2', NaN);
            apStruct = struct('pixels', s, 'values', s);
            
            bStruct = struct('axes', aStruct, 'points', pStruct, 'axispoints', apStruct);
        end
        
        function checkMode(value)
            if ~any(strcmp({'axes','points','axispoints'}, value))
                error(['scaleMode must equal ''axes'', ''points'' or ''axispoints'', now was: ' value])
            end
        end
        
    end
    
end