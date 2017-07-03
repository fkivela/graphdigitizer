function create_img(filename, hObject, eventdata, handles)
%#ok<*INUSL>

handles = guidata(hObject);

try
    [img, map] = imread(filename);
catch
    error(['File not found. Tried to access file ' filename])
end

if size(size(img), 2) < 3
    img = ind2rgb(img, map);
end

img_obj = image(handles.axes_img, img,'ButtonDownFcn',{@img_click_Callback});

handles.img = img;
handles.img_object = img_obj;
handles.x_size = size(img, 2);
handles.y_size = size(img, 1);
handles.text_not_found.Visible = 'off';
handles.edit_filename.String = filename;

guidata(hObject, handles)
refresh_img(hObject, eventdata, handles)
handles = guidata(hObject);

erasefields(hObject, eventdata, handles, 'value', 'index', 'start')
