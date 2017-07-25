%#ok<*INUSL>

function callbacks = figurecallbacks
  callbacks = struct(...
      'mousedown', @figure1_WindowButtonDownFcn,...
      'mousemove', @figure1_WindowButtonMotionFcn,...
      'mouseup', @figure1_WindowButtonUpFcn,...
      'scrollWheel', @figure1_WindowScrollWheelFcn,...
      'keyPress', @figure1_WindowKeyPressFcn);
end

function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
handles.mouse_button_down = 1;
guidata(hObject, handles)
end

function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)

if handles.mouse_button_down == 0
    return
end

if ~strcmp(handles.mode, 'delete points')
    return
end

coordinates = get(handles.axes_img,'CurrentPoint');
coordinates = coordinates(1, 1:2);
x = round(coordinates(1));
y = round(coordinates(2));

if inarea([x, y], [1,1,handles.x_size,handles.y_size])
    deletepoints([x, y], hObject, eventdata, handles)
    handles = guidata(hObject);
end

guidata(hObject, handles)
end

function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
handles.mouse_button_down = 0;
guidata(hObject, handles)
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