function callbacks = imagenavigationcallbacks
  callbacks = struct(...
      'sliderX', @slider_x_Callback,...
      'sliderY', @slider_y_Callback,...
      'sliderZ', @slider_z_Callback,...
      'scrollWheel', @figure1_WindowScrollWheelFcn,...
      'keyPress', @figure1_WindowKeyPressFcn);
end

function slider_x_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles.zoom_x = handles.slider_x.Value;
guidata(hObject, handles);

refresh_img(hObject);

end

function slider_y_Callback(hObject, eventdata, handles)

handles.zoom_y = handles.slider_y.Value;
guidata(hObject, handles);

refresh_img(hObject);

end

function slider_z_Callback(hObject, eventdata, handles)

handles.zoom_level = handles.slider_z.Value;
guidata(hObject, handles);

refresh_img(hObject);

end

function figure1_WindowScrollWheelFcn(hObject, eventdata, handles)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE1)
%	VerticalScrollCount: signed integer indicating direction and number of clicks
%	VerticalScrollAmount: number of lines scrolled for each click

zoom_lv = handles.zoom_level;
dir = eventdata.VerticalScrollCount; %direction of scrolling (up or down), values +-1
step = zoom_lv * 0.5; % Edit this to adjust the speed of zooming

new_zoom_lv = zoom_lv - dir * step;

max = handles.slider_z.Max;
min = handles.slider_z.Min;

if new_zoom_lv > max
    new_zoom_lv = max;
end

if new_zoom_lv < min
    new_zoom_lv = min;
end

handles.zoom_level = new_zoom_lv;
handles.slider_z.Value = new_zoom_lv;

guidata(hObject, handles)
refresh_img(hObject)

end

function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed


key = eventdata.Key;
zoom_lv = handles.zoom_level;
x = handles.zoom_x;
y = handles.zoom_y;
step = 0.2 / zoom_lv; %Edit this to adjust the speed of movement

switch key
    case 'w'
        y = y + step;
    case 'a'
        x = x - step;
    case 's'
        y = y - step;
    case 'd'
        x = x + step;
    case 'uparrow'
        y = y + step;
    case 'leftarrow'
        x = x - step;
    case 'downarrow'
        y = y - step;
    case 'rightarrow'
        x = x + step;
    otherwise
        return
end

if x > 1
    x = 1;
end

if y > 1
    y = 1;
end

if x < 0
    x = 0;
end

if y < 0
    y = 0;
end

handles.zoom_x = x;
handles.zoom_y = y;
handles.slider_x.Value = x;
handles.slider_y.Value = y;

guidata(hObject, handles)
refresh_img(hObject)

end