%#ok<*INUSL>

function callbacks = togglebuttoncallbacks
  callbacks = struct(...
      'filetab', @togglebutton_file_Callback,...
      'parameterstab', @togglebutton_parameters_Callback,...
      'datatab', @togglebutton_data_Callback,...
      'scaletab', @togglebutton_scale_Callback);
end

function togglebutton_file_Callback(hObject, eventdata, handles)
settab(hObject, eventdata, handles, 'file')
end

function togglebutton_parameters_Callback(hObject, eventdata, handles)
settab(hObject, eventdata, handles, 'parameters')
end

function togglebutton_data_Callback(hObject, eventdata, handles)
settab(hObject, eventdata, handles, 'data')
end

function togglebutton_scale_Callback(hObject, eventdata, handles)
settab(hObject, eventdata, handles, 'scale')
end


function settab(hObject, eventdata, handles, tab)
handles.togglebutton_file.Value = 0;
handles.togglebutton_parameters.Value = 0;
handles.togglebutton_data.Value = 0;
handles.togglebutton_scale.Value = 0;

handles.file_panel.Visible = 'off';
handles.start_panel.Visible = 'off';
handles.param_panel.Visible = 'off';
handles.data_panel.Visible = 'off';
handles.scale_panel.Visible = 'off';

switch tab
    case 'file'
        handles.togglebutton_file.Value = 1;
        handles.file_panel.Visible = 'on';
    case 'parameters'
        handles.togglebutton_parameters.Value = 0;
        handles.param_panel.Visible = 'on';
    case 'data'
        handles.togglebutton_data.Value = 0;
        handles.data_panel.Visible = 'on';
    case 'scale'
        handles.togglebutton_scale.Value = 0;
        handles.scale_panel.Visible = 'on';
end

hObject.Value = 1;
%guidata(hObject, handles)
end