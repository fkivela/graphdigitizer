function deletepoints(points, hObject, eventdata, handles)

if size(points, 2) == 2
    
    for n = 1:size(points, 1)
        x = points(n, 1);
        y = points(n, 2);

        if handles.y_data(x) == y
            handles.y_data(x) = NaN;
        end  
    end
    
elseif size(points, 2) == 4
    
    for n = 1:size(points, 1)
        
        data = handles.y_data;
        
        for i = 1:handles.x_size
           if inarea([i, data(i)], points(n, :))
               data(i) = NaN;
           end
        end
        
        handles.y_data = data;
        guidata(hObject, handles)
    end
    
end

guidata(hObject, handles)

handles = guidata(hObject);
refresh_preview(hObject, eventdata, handles);
guidata(hObject, handles)

end