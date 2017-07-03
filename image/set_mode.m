function set_mode(mode, hObject, eventdata, handles)
handles = guidata(hObject);
handles.clicks = 0;

switch mode
    case 'none'
        handles.mode = 'none';
        handles.figure1.Pointer = 'arrow';
    case 'select start point'
        handles.figure1.Pointer = 'hand';
        handles.mode = 'select start point';
    case 'area delete'    
        handles.figure1.Pointer = 'hand';
        handles.mode = 'area delete';
    case 'delete points'
        handles.figure1.Pointer = 'cross';
        handles.mode = 'delete points';
    case 'overwrite points'
        handles.figure1.Pointer = 'crosshair';
        handles.mode = 'overwrite points';
    case 'select scale 1'
        handles.figure1.Pointer = 'crosshair';
        handles.mode = 'select scale 1';
    case 'select scale 2'
        handles.figure1.Pointer = 'crosshair';
        handles.mode = 'select scale 2';
    otherwise
        error('Unrecognized mode')
        
end   

guidata(hObject, handles);