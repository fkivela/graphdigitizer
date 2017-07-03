%#ok<*INUSL>

function callbacks = buttoncallbacks
  callbacks = struct(...
      'browse', @button_browse_Callback,...
      'start', @button_start_select_Callback,...
      'delete', @button_delete_points_Callback,...
      'area', @button_area_Callback,...
      'overwrite', @button_overwrite_points_Callback,...
      'findgraph', @button_find_graph_Callback,...
      'selectindex1', @button_index1_Callback,...
      'selectindex2', @button_index2_Callback,...
      'continue', @button_continue_Callback,...
      'save', @button_save_Callback,...
      'help', @button_help_Callback);
end

function button_browse_Callback(hObject, eventdata, handles)

[file, dir] = uigetfile({'*.*';'*.jpg';'*.png';'*.gif'});
filename = [dir file];

if (isa(file,'double')) && (file == 0) %uigetfile returns 0 if browsing is interrupted
    return
end
    
guidata(hObject, handles)
create_img(filename, hObject, eventdata, handles);
handles = guidata(hObject);

guidata(hObject, handles)
refresh_img(hObject, eventdata, handles)
end

function button_start_select_Callback(hObject, eventdata, handles)

guidata(hObject, handles)
if strcmp(handles.mode, 'select start point')
    set_mode('none', hObject, eventdata, handles)
else
    set_mode('select start point', hObject, eventdata, handles)
end
handles = guidata(hObject);

guidata(hObject, handles);
end

function button_delete_points_Callback(hObject, eventdata, handles)

guidata(hObject, handles)
if strcmp(handles.mode, 'delete points')
    set_mode('none', hObject, eventdata, handles)
else
    set_mode('delete points', hObject, eventdata, handles)
end
handles = guidata(hObject);

guidata(hObject, handles);
end

function button_area_Callback(hObject, eventdata, handles)

guidata(hObject, handles)
if strcmp(handles.mode, 'area delete')
    set_mode('none', hObject, eventdata, handles)
else
    set_mode('area delete', hObject, eventdata, handles)
end
handles = guidata(hObject);

guidata(hObject, handles);
end

function button_overwrite_points_Callback(hObject, eventdata, handles)
guidata(hObject, handles)
if strcmp(handles.mode, 'overwrite points')
    set_mode('none', hObject, eventdata, handles)
else
    set_mode('overwrite points', hObject, eventdata, handles)
end
handles = guidata(hObject);

guidata(hObject, handles);
end

function button_find_graph_Callback(hObject, eventdata, handles)

color_param = handles.color_param;
diff_param = handles.diff_param;
start_x = handles.start_x;
start_y = handles.start_y;
start = [start_x, start_y];
img = handles.img;

if isempty(img)
    error_msg('The graph cannot be computed before an image is selected', hObject);
    return
end

if isempty(start_x) || isempty(start_y)
    error_msg('The graph cannot be computed before a starting point is selected', hObject);
    return
end

handles = guidata(hObject);

[x, y] = findgraph(img, start, diff_param, color_param);
handles.y_data = y;
handles.plot_object = plot(handles.axes_plot, x, y);

guidata(hObject, handles)
refresh_preview(hObject, eventdata, handles)
handles = guidata(hObject);

guidata(hObject, handles);
end

function button_index1_Callback(hObject, eventdata, handles)

guidata(hObject, handles)
if strcmp(handles.mode, 'select scale 1')
    set_mode('none', hObject, eventdata, handles)
else
    set_mode('select scale 1', hObject, eventdata, handles)
end
handles = guidata(hObject);

guidata(hObject, handles);
end

function button_index2_Callback(hObject, eventdata, handles)

guidata(hObject, handles)
if strcmp(handles.mode, 'select scale 2')
    set_mode('none', hObject, eventdata, handles)
else
    set_mode('select scale 2', hObject, eventdata, handles)
end
handles = guidata(hObject);

guidata(hObject, handles);
end

function button_continue_Callback(hObject, eventdata, handles)

hObject.Visible = 'off';
handles.text_error.Visible = 'off';
guidata(hObject, handles)
end

function button_save_Callback(hObject, eventdata, handles)
[x, y] = output_data(hObject);

data(:,1) = x;
data(:,2) = y;
file = handles.savefile;
headers = '';

savedata(file, data, headers)
end

function button_help_Callback(hObject, eventdata, handles)
digitizerhelp()
end

