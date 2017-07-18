function img_click_Callback(hObject, eventdata, handles)
handles = guidata(hObject);

axes_handle  = hObject.Parent;
coordinates = axes_handle.CurrentPoint; 
coordinates = coordinates(1,1:2);
x = round(coordinates(1));
y = round(coordinates(2));

persistent x1;
persistent y1;
persistent x2
persistent y2;

%double-click
% persistent chk
% if isempty(chk)
%       chk = 1;
%       pause(0.5); %Add a delay to distinguish single click from a double click
%       if chk == 1
%           fprintf(1,'\nI am doing a single-click.\n\n');
%           chk = [];
%       end
% else
%       chk = [];
%       fprintf(1,'\nI am doing a double-click.\n\n');
% end

switch handles.mode
    case 'select start point'
        handles.start_x = x;
        handles.start_y = y;
    
        handles.edit_start_x.String = x;
        handles.edit_start_y.String = y;
        
        guidata(hObject, handles)
        set_mode('none', hObject, eventdata, handles)
        handles = guidata(hObject);
        
    case 'delete points'
        if handles.y_data(x) == y
            handles.y_data(x) = NaN;
        end
        
        guidata(hObject, handles)
        refresh_preview(hObject, eventdata, handles);
        handles = guidata(hObject);
        
    case 'area delete'
        
        if handles.clicks == 0
            
            x1 = x;
            y1 = y;
            handles.clicks = 1;
            handles.figure1.Pointer = 'cross';
                    
        else
            x2 = x;
            y2 = y;
            
            data = handles.y_data;
            for i = 1:handles.x_size
                if inarea([i, data(i)], [x1 y1 x2 y2])
                    data(i) = NaN;
                end     
            end
            handles.y_data = data;
            handles.clicks = 0;
            handles.figure1.Pointer = 'hand';
            
            guidata(hObject, handles)
            refresh_preview(hObject, eventdata, handles);
            handles = guidata(hObject);
        end
        
        
        
    case 'overwrite points'
        handles.y_data(x) = y;
        
        guidata(hObject, handles)
        refresh_preview(hObject, eventdata, handles);
        handles = guidata(hObject);

    case 'select scale 1'
        
        switch handles.scale_mode
            
            case 'axes'
                
                x = rind(x, handles.x_size);
                y = rind(y, handles.y_size);
                
                if handles.clicks == 0
                    
                    handles.scale_indices(1) = x;
                    handles.scale_indices(2) = y;
                    
                    handles.edit_index1.String = x;
                    handles.edit_index2.String = y;
                    
                    handles.clicks = 1;
                    
                else
                    
                    handles.scale_indices(3) = x;
                    handles.scale_indices(4) = y;
                    
                    handles.edit_index3.String = x;
                    handles.edit_index4.String = y;
                    
                    uicontrol(handles.edit_value1)
                    
                    guidata(hObject, handles)
                    set_mode('none', hObject, eventdata, handles)
                    handles = guidata(hObject);
                    
                end
                
            case 'points'
                
                x = rind(x, handles.x_size);
                y = rind(y, handles.y_size);

                handles.scale_indices(1) = x;
                handles.scale_indices(2) = y;

                handles.edit_index1.String = x;
                handles.edit_index2.String = y;
                
                uicontrol(handles.edit_value1)

                guidata(hObject, handles)
                set_mode('none', hObject, eventdata, handles)
                handles = guidata(hObject);
                
            case 'axis points'
                
                x = rind(x, handles.x_size);
                
                if handles.clicks == 0

                    handles.index1 = x;
                    handles.scale_indices(1) = x;
                    handles.edit_index1.String = x;
                    handles.clicks = 1;
                else
                    handles.index2 = x;
                    handles.scale_indices(2) = x;
                    handles.edit_index2.String = x;
                    uicontrol(handles.edit_value1)
                    
                    guidata(hObject, handles)
                    set_mode('none', hObject, eventdata, handles)
                    handles = guidata(hObject);
                    
                end
                
        end
 
    case 'select scale 2'
        
        switch handles.scale_mode
                
            case 'points'
                
        
                x = rind(x, handles.x_size);
                y = rind(y, handles.y_size);

                handles.scale_indices(3) = x;
                handles.scale_indices(4) = y;

                handles.edit_index3.String = x;
                handles.edit_index4.String = y;
                
                uicontrol(handles.edit_value3)

                guidata(hObject, handles)
                set_mode('none', hObject, eventdata, handles)
                handles = guidata(hObject);
                
            case 'axis points'
                
                if handles.clicks == 0

                    handles.index3 = y;
                    handles.scale_indices(3) = y;
                    handles.edit_index3.String = y;
                    handles.clicks = 1;
                else
                    handles.index4 = y;
                    handles.scale_indices(4) = y;
                    handles.edit_index4.String = y;
                    uicontrol(handles.edit_value3)
                    
                    guidata(hObject, handles)
                    set_mode('none', hObject, eventdata, handles)
                    handles = guidata(hObject);
                end
                
        end
        
end

guidata(hObject, handles);