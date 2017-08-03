function callbacks = slidercallbacks
  callbacks = struct(...
      'sliderX', @slider_x_Callback,...
      'sliderY', @slider_y_Callback,...
      'sliderZ', @slider_z_Callback,...
      'sliderSmooth', @slider_smoothing_Callback);

end

function slider_x_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% handles.zoom_x = handles.slider_x.Value;
% guidata(hObject, handles);
% 
% refresh_img(hObject);
handles.PreviewImageController.xPosition = hObject.Value;

end

function slider_y_Callback(hObject, eventdata, handles)

% handles.zoom_y = handles.slider_y.Value;
% guidata(hObject, handles);
% 
% refresh_img(hObject);
handles.PreviewImageController.yPosition = hObject.Value;
end

function slider_z_Callback(hObject, eventdata, handles)

% handles.zoom_level = handles.slider_z.Value;
% guidata(hObject, handles);
% 
% refresh_img(hObject);
handles.PreviewImageController.zoomLevel = hObject.Value;


end

function slider_smoothing_Callback(hObject, eventdata, handles)
value = handles.slider_smoothing.Value;
handles.smoothing = value;
handles.text_smoothing.String = sprintf('Smoothing: %.2f %%', value);
guidata(hObject, handles);

refresh_preview(hObject, eventdata, handles);

end