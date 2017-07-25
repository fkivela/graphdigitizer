function [x, y] = output_data(hObject, eventdata, handles)
handles = guidata(hObject);

if isempty(handles.y_data)
    x = [];
    y = [];
    return
end

y_indices = handles.y_data;

[x_scale, y_scale, x0_index, y0_index] = find_scale(handles.scale_indices, handles.scale_values, handles.scale_mode);
handles.text_default_coords.Visible = 'off';

if any(isnan([x_scale y_scale x0_index y0_index]))
    
    x0_index = 0;
    y0_index = handles.y_size;
    x_scale = 1;
    y_scale = 1;
    
    handles.text_default_coords.Visible = 'on';
end

x = 1:handles.x_size;
x = x - x0_index;

y = y0_index - y_indices + 1;
x = x * x_scale;
y = y * y_scale;

[x, y] = removeNaNs(x, y);
y = smooth(x,y,handles.smoothing);