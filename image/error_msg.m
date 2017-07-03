function error_msg(str, hObject, eventdata, handles)
handles = guidata(hObject);

handles.text_error.String = str;
handles.text_error.Visible = 'on';
handles.button_continue.Visible = 'on';

guidata(hObject, handles)
