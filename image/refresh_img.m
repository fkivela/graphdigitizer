function refresh_img(hObject, eventdata, handles)
handles = guidata(hObject);

x = handles.zoom_x;
y = handles.zoom_y;
zoom_lv = handles.zoom_level;
img = handles.img;

if isempty(img)
    return
end

lims = zoomed_img(img, zoom_lv, x, y);

x_start = lims(1,1);
x_end = lims(1,2);
y_start = lims(2,1);
y_end = lims(2,2);
handles.axes_img.XLim = [x_start x_end];
handles.axes_img.YLim = [y_start y_end];

guidata(hObject, handles);
