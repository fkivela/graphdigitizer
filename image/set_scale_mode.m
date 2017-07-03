function set_scale_mode(mode, hObject, eventdata, handles)
handles = guidata(hObject);

switch mode
    case 'axes' 
        handles.scale_mode = 'axes';
        
        handles.text_index1.String = {'X-axis', 'X-index'};
        handles.text_index2.String = {'X-axis', 'Y-index'};
        
        handles.text_index3.String = {'Y-axis', 'X-index'};
        handles.text_index4.String = {'Y-axis', 'Y-index'};
        
        handles.text_value1.String = {'X-axis', 'X-value'};
        handles.text_value2.String = {'Y-axis', 'Y-value'};
        
        handles.text_value3.Visible = 'off';
        handles.text_value4.Visible = 'off';
        
        handles.edit_value3.Visible = 'off';
        handles.edit_value4.Visible = 'off';
        
        handles.button_index2.Visible = 'off';
        
    case 'points'
        handles.scale_mode = 'points';
        
        handles.text_index1.String = {'Point 1', 'X-coordinate'};
        handles.text_index2.String = {'Point 1', 'Y-coordinate'};
        handles.text_index3.String = {'Point 2', 'X-coordinate'};
        handles.text_index4.String = {'Point 2', 'Y-coordinate'};
        
        handles.text_value1.String = {'Point 1', 'X-value'};
        handles.text_value2.String = {'Point 1', 'Y-value'};
        handles.text_value3.String = {'Point 2', 'X-value'};
        handles.text_value4.String = {'Point 2', 'Y-value'};
        
        handles.text_value3.Visible = 'on';
        handles.text_value4.Visible = 'on';
        
        handles.edit_value3.Visible = 'on';
        handles.edit_value4.Visible = 'on';
        
        handles.button_index2.Visible = 'on';       

    case 'axis points'
        handles.scale_mode = 'axis points';
        
        handles.text_index1.String = {'X-axis', 'X-coordinate 1'};
        handles.text_index2.String = {'X-axis', 'X-coordinate 2'};
        handles.text_index3.String = {'Y-axis', 'Y-coordinate 1'};
        handles.text_index4.String = {'Y-axis', 'Y-coordinate 2'};
        
        handles.text_value1.String = {'X-axis', 'X-value 1'};
        handles.text_value2.String = {'X-axis', 'X-value 2'};
        handles.text_value3.String = {'Y-axis', 'Y-value 1'};
        handles.text_value4.String = {'Y-axis', 'Y-value 2'};
        
        handles.text_value3.Visible = 'on';
        handles.text_value4.Visible = 'on';
        
        handles.edit_value3.Visible = 'on';
        handles.edit_value4.Visible = 'on';
        
        handles.button_index2.Visible = 'on';       

end

guidata(hObject, handles);