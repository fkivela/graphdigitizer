function refresh_preview(hObject, eventdata, handles)
handles = guidata(hObject);

y = handles.y_data;
img = handles.img;

if isempty(img) || isempty(handles.y_data)
    return
end

preview = generatePreview(img, y);
handles.img_object.CData = preview;

[x_out, y_out] = output_data(hObject, eventdata, handles);
handles.plot_object.XData = x_out;
handles.plot_object.YData = y_out;

guidata(hObject, handles)