function erasefields(varargin)
hObject = varargin{1};
eventdata = varargin{2};
handles = varargin{3};

if any(strcmp(varargin, 'value'))
    for n = 1:4
       handles.(sprintf('edit_index%d', n)).String = ''; 
       handles.scale_indices(n) = NaN;
    end
end

if any(strcmp(varargin, 'index'))
    for n = 1:4
        handles.(sprintf('edit_value%d', n)).String = ''; 
        handles.scale_values(n) = NaN;
    end
end

if any(strcmp(varargin, 'start'))
    handles.edit_start_x.String = '';
    handles.edit_start_y.String = '';
    handles.start_x = [];
    handles.start_y = [];
end

guidata(hObject, handles)