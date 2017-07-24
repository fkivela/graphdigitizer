%#ok<*INUSL>

function callbacks = mousecallbacks
  callbacks = struct(...
      'mousedown', @figure1_WindowButtonDownFcn,...
      'mousemove', @figure1_WindowButtonMotionFcn,...
      'mouseup', @figure1_WindowButtonUpFcn);
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