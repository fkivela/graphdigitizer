function callbacks = editfieldcallbacks
%#ok<*ST2NM> str2num understans words such as 'pi'
%#ok<*INUSL>

callbacks = struct(...
      'fileName', @edit_filename_Callback,...
      'colorDiff', @edit_color_diff_Callback,...
      'distanceDiff', @edit_distance_diff_Callback,...
      'graphfinding1', @edit_graphfinding1_Callback,...
      'graphfinding2', @edit_graphfinding2_Callback,...
      'startX', @edit_start_x_Callback,...
      'startY', @edit_start_y_Callback,...
      'index1', @edit_index1_Callback,...
      'index2', @edit_index2_Callback,...
      'index3', @edit_index3_Callback,...
      'index4', @edit_index4_Callback,...
      'value1', @edit_value1_Callback,...
      'value2', @edit_value2_Callback,...
      'value3', @edit_value3_Callback,...
      'value4', @edit_value4_Callback,...
      'savefile', @edit_save_file_Callback);
end

function edit_filename_Callback(hObject, eventdata, handles)

% try
%     filename = hObject.String;
%     guidata(hObject, handles)
%     create_img(filename, hObject, eventdata, handles);
%     
% catch
%     handles.text_not_found.Visible = 'on';
%     guidata(hObject, handles);
% end
filename = hObject.String;
handles.Coordinator.newImage(filename)
end

%Parameters

function edit_color_diff_Callback(hObject, eventdata, handles)
handles.GraphFinderController.colorDiffParam = str2num(hObject.String);
end

function edit_distance_diff_Callback(hObject, eventdata, handles)
handles.GraphFinderController.distanceDiffParam = str2num(hObject.String);
end

function edit_graphfinding1_Callback(hObject, eventdata, handles)
handles.GraphFinderController.graphColorParam = str2num(hObject.String);
end

function edit_graphfinding2_Callback(hObject, eventdata, handles)
handles.GraphFinderController.graphColorParam = 100 - str2num(hObject.String);
end


%Starting point

function edit_start_x_Callback(hObject, eventdata, handles)

x = check_input(1, handles.x_size, 1, hObject);
uicontrol(handles.edit_start_y)

handles = guidata(hObject);
handles.start_x = x;
guidata(hObject, handles);
end

function edit_start_y_Callback(hObject, eventdata, handles)

y = check_input(1, handles.y_size, 1, hObject);

handles = guidata(hObject);
handles.start_y = y;
guidata(hObject, handles);
end

%Scale index fields

function edit_index1_Callback(hObject, eventdata, handles)

x = check_input(1, inf, 1, hObject); %Inf should be replaced with handles.x/y_size in the future
uicontrol(handles.edit_index2)

if isempty(x)
    handles.scale_indices(1) = NaN;
end
guidata(hObject, handles);
refresh_preview(hObject, eventdata, handles)
end

function edit_index2_Callback(hObject, eventdata, handles)

x = check_input(1, inf, 1, hObject);

if isempty(x)
    handles.scale_indices(2) = NaN;
end
guidata(hObject, handles);
refresh_preview(hObject, eventdata, handles)
end

function edit_index3_Callback(hObject, eventdata, handles)

x = check_input(1, inf, 1, hObject);
uicontrol(handles.edit_index4)

if isempty(x)
    handles.scale_indices(3) = NaN;
end
guidata(hObject, handles);

guidata(hObject, handles)
refresh_preview(hObject, eventdata, handles)
end

function edit_index4_Callback(hObject, eventdata, handles)

x = check_input(1, inf, 1, hObject);

if isempty(x)
    handles.scale_indices(4) = NaN;
end
guidata(hObject, handles);
refresh_preview(hObject, eventdata, handles)
end

%Scale value fields

function edit_value1_Callback(hObject, eventdata, handles)
x = check_input(-inf, inf, 0, hObject);
uicontrol(handles.edit_value2)

if isempty(x)
    handles.scale_values(1) = NaN;
else
    handles.scale_values(1) = x;
end

guidata(hObject, handles);
refresh_preview(hObject, eventdata, handles)
end

function edit_value2_Callback(hObject, eventdata, handles)

x = check_input(-inf, inf, 0, hObject);

if isempty(x)
    handles.scale_values(2) = NaN;
else
    handles.scale_values(2) = x;
end

guidata(hObject, handles);
refresh_preview(hObject, eventdata, handles)
end

function edit_value3_Callback(hObject, eventdata, handles)

x = check_input(-inf, inf, 0, hObject);
uicontrol(handles.edit_value4)

if isempty(x)
    handles.scale_values(3) = NaN;
else
    handles.scale_values(3) = x;
end

guidata(hObject, handles);
refresh_preview(hObject, eventdata, handles)
end

function edit_value4_Callback(hObject, eventdata, handles)

x = check_input(-inf, inf, 0, hObject);

if isempty(x)
    handles.scale_values(4) = NaN;
else
    handles.scale_values(4) = x;
end

guidata(hObject, handles)
refresh_preview(hObject, eventdata, handles)
end

%Save file

function edit_save_file_Callback(hObject, eventdata, handles)
handles.savefile = hObject.String;
guidata(hObject, handles)
end

%Utility functions

function [x] = check_input(min, max, force_integer, hObject)
in = hObject.String;
x = str2num(in);

if isempty(x)
    hObject.String = [];
    return
end

if force_integer
    x = round(x);
end
    
if ~isempty(min) && (x < min)
    x = min;
end

if ~isempty(max) && (x > max)
    x = max;
end

if min > max
    x = [];
end

hObject.String = x;
end

