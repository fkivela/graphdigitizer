
function varargout = graphdigitizer(varargin)
% GRAPHDIGITIZER A GUI that allows the user to semi-automatically extract data from a
% graph in an image file.
%      GRAPHDIGITIZER opens the GUI. Extracted data can be saved in a text
%      file.
%
%      [x, y] = GRAPHDIGITIZER opens the GUI and returns values of x and y as MATLAB vectors upon closing the program.
%
%      For instructions in using the program, open the GUI and click on the 'help' button 
%
% See also: DIGITIZErasolaras

% Last Modified by GUIDE v2.5 25-Jul-2017 14:59:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @graphdigitizer_OpeningFcn, ...
                   'gui_OutputFcn',  @graphdigitizer_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end % End initialization code - DO NOT EDIT

function graphdigitizer_OpeningFcn(hObject, eventdata, handles, varargin)
% Executes just before graphdigitizer is made visible.

% Determine where this m-file's folder is
folder = fileparts(which(mfilename)); 
% Add that folder plus all subfolders to MATLAB path
addpath(genpath(folder));

%Add callback function handles to handles.callbacks
names = [
    fieldnames(slidercallbacks); ...
    fieldnames(editfieldcallbacks); ...
    fieldnames(buttoncallbacks); ...
    fieldnames(togglebuttoncallbacks); ...
    fieldnames(figurecallbacks)];

callbacks = cell2struct([
    struct2cell(slidercallbacks); ...
    struct2cell(editfieldcallbacks); ...
    struct2cell(buttoncallbacks); ...
    struct2cell(togglebuttoncallbacks)
    struct2cell(figurecallbacks)
    ], names, 1);

handles.callbacks = callbacks;

handles.GraphFinder = GraphFinder();
handles.GraphFinderController = GraphFinderController(handles.figure1, handles.GraphFinder);

handles.PreviewImage = PreviewImage(handles.slider_z.Min, handles.slider_z.Max);
handles.PreviewImageController = PreviewImageController(handles.axes_img, handles.PreviewImage);

handles.ImageClicker = ImageClicker(handles.figure1);

handles.Coordinator = Coordinator(handles.GraphFinderController, handles.PreviewImageController, handles.ImageClicker);

%Initialize data
handles.button_test.Visible = 'on';

handles.img = [];
handles.img_object = [];
handles.x_size = 0;
handles.y_size = 0;

handles.y_data = [];
handles.plot_object = [];
handles.savefile = handles.edit_save_file.String;

handles.mode = 'none';
handles.clicks = 0;
handles.mouse_button_down = 0;

handles.start_x = [];
handles.start_y = [];
handles.color_diff_param = str2double(handles.edit_color_diff.String);
handles.distance_diff_param = str2double(handles.edit_distance_diff.String);
handles.graphfinding_color_param = str2double(handles.edit_graphfinding1.String);


handles.zoom_level = handles.slider_z.Value;
handles.zoom_x = handles.slider_x.Value;
handles.zoom_y = handles.slider_y.Value;

value = handles.slider_smoothing.Value;
handles.smoothing = value;
handles.text_smoothing.String = sprintf('Smoothing: %.2f %%', value);


handles.scale_indices = [NaN NaN NaN NaN]; %[j1 i1 j2 i2]
handles.scale_values = [NaN NaN NaN NaN]; %[x1 y1 x2 y2]

guidata(hObject, handles)
switch 1
    case handles.radiobutton_mode1.Value
        set_scale_mode('axes', hObject, eventdata, handles);

    case handles.radiobutton_mode2.Value
        set_scale_mode('points', hObject, eventdata, handles);

    case handles.radiobutton_mode3.Value
        set_scale_mode('axis points', hObject, eventdata, handles);        
end
handles = guidata(hObject);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes graphdigitizer wait for user response (see UIRESUME)
uiwait(handles.figure1);

function varargout = graphdigitizer_OutputFcn(hObject, eventdata, handles) 
[x, y] = output_data(hObject, eventdata, handles);
varargout{1} = x;
varargout{2} = y;
delete(hObject); %closes the program

function figure1_CloseRequestFcn(hObject, eventdata, handles)
% Executes when user attempts to close figure1.
if isequal(get(hObject, 'waitstatus'), 'waiting')
    uiresume(hObject)
else
     delete(hObject); %Closes the figure
end

%Sliders

function slider_x_Callback(hObject, eventdata, handles)
feval(handles.callbacks.sliderX, hObject, eventdata, handles);

function slider_x_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_y_Callback(hObject, eventdata, handles)
feval(handles.callbacks.sliderY, hObject, eventdata, handles);

function slider_y_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_z_Callback(hObject, eventdata, handles)
feval(handles.callbacks.sliderZ, hObject, eventdata, handles);

function slider_z_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_smoothing_Callback(hObject, eventdata, handles)
feval(handles.callbacks.sliderSmooth, hObject, eventdata, handles);

function slider_smoothing_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%Figure Callbacks

function figure1_WindowScrollWheelFcn(hObject, eventdata, handles)
feval(handles.callbacks.scrollWheel, hObject, eventdata, handles);

function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
feval(handles.callbacks.keyPress, hObject, eventdata, handles)

function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
feval(handles.callbacks.mousedown, hObject, eventdata, handles)

function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
feval(handles.callbacks.mousemove, hObject, eventdata, handles)

function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
feval(handles.callbacks.mouseup, hObject, eventdata, handles)

%Buttons

function button_browse_Callback(hObject, eventdata, handles)
feval(handles.callbacks.browse, hObject, eventdata, handles)

function button_start_select_Callback(hObject, eventdata, handles)
feval(handles.callbacks.start, hObject, eventdata, handles)

function button_delete_points_Callback(hObject, eventdata, handles)
feval(handles.callbacks.delete, hObject, eventdata, handles)

function button_area_Callback(hObject, eventdata, handles)
feval(handles.callbacks.area, hObject, eventdata, handles)

function button_overwrite_points_Callback(hObject, eventdata, handles)
feval(handles.callbacks.overwrite, hObject, eventdata, handles)

function button_find_graph_Callback(hObject, eventdata, handles)
feval(handles.callbacks.findgraph, hObject, eventdata, handles)

function button_index1_Callback(hObject, eventdata, handles)
feval(handles.callbacks.selectindex1, hObject, eventdata, handles)

function button_index2_Callback(hObject, eventdata, handles)
feval(handles.callbacks.selectindex2, hObject, eventdata, handles)

function button_continue_Callback(hObject, eventdata, handles)
feval(handles.callbacks.continue, hObject, eventdata, handles)

function button_save_Callback(hObject, eventdata, handles)
feval(handles.callbacks.save, hObject, eventdata, handles)

function button_help_Callback(hObject, eventdata, handles)
feval(handles.callbacks.help, hObject, eventdata, handles)

%Toggle buttons (tabs)

function togglebutton_file_Callback(hObject, eventdata, handles)
feval(handles.callbacks.filetab, hObject, eventdata, handles)

function togglebutton_parameters_Callback(hObject, eventdata, handles)
feval(handles.callbacks.parameterstab, hObject, eventdata, handles)

function togglebutton_data_Callback(hObject, eventdata, handles)
feval(handles.callbacks.datatab, hObject, eventdata, handles)

function togglebutton_scale_Callback(hObject, eventdata, handles)
feval(handles.callbacks.scaletab, hObject, eventdata, handles)

%Edit fields

function edit_color_diff_Callback(hObject, eventdata, handles)
feval(handles.callbacks.colorDiff, hObject, eventdata, handles)

function edit_color_diff_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_distance_diff_Callback(hObject, eventdata, handles)
feval(handles.callbacks.distanceDiff, hObject, eventdata, handles)

function edit_distance_diff_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_graphfinding1_Callback(hObject, eventdata, handles)
feval(handles.callbacks.graphfinding1, hObject, eventdata, handles)

function edit_graphfinding1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_graphfinding2_Callback(hObject, eventdata, handles)
feval(handles.callbacks.graphfinding2, hObject, eventdata, handles)

function edit_graphfinding2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_start_x_Callback(hObject, eventdata, handles)
feval(handles.callbacks.startX, hObject, eventdata, handles)

function edit_start_x_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_start_y_Callback(hObject, eventdata, handles)
feval(handles.callbacks.startY, hObject, eventdata, handles)

function edit_start_y_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_filename_Callback(hObject, eventdata, handles)
feval(handles.callbacks.fileName, hObject, eventdata, handles)

function edit_filename_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_save_file_Callback(hObject, eventdata, handles)
feval(handles.callbacks.savefile, hObject, eventdata, handles)

function edit_save_file_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

    %Scale index edit fields

function edit_index1_Callback(hObject, eventdata, handles)
feval(handles.callbacks.index1, hObject, eventdata, handles)

function edit_index1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_index2_Callback(hObject, eventdata, handles)
feval(handles.callbacks.index2, hObject, eventdata, handles)

function edit_index2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_index3_Callback(hObject, eventdata, handles)
feval(handles.callbacks.index3, hObject, eventdata, handles)

function edit_index3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_index4_Callback(hObject, eventdata, handles)
feval(handles.callbacks.index4, hObject, eventdata, handles)

function edit_index4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

    %Scale value edit fields

function edit_value1_Callback(hObject, eventdata, handles)
feval(handles.callbacks.value1, hObject, eventdata, handles)

function edit_value1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_value2_Callback(hObject, eventdata, handles)
feval(handles.callbacks.value2, hObject, eventdata, handles)

function edit_value2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_value3_Callback(hObject, eventdata, handles)
feval(handles.callbacks.value3, hObject, eventdata, handles)

function edit_value3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_value4_Callback(hObject, eventdata, handles)
feval(handles.callbacks.value4, hObject, eventdata, handles)

function edit_value4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%Radio buttons

function radiobutton_mode1_Callback(hObject, eventdata, handles)

if hObject.Value
    set_scale_mode('axes', hObject, eventdata, handles)
end

function radiobutton_mode2_Callback(hObject, eventdata, handles)

if hObject.Value
    set_scale_mode('points', hObject, eventdata, handles)
end

function radiobutton_mode3_Callback(hObject, eventdata, handles)

if hObject.Value
    set_scale_mode('axis points', hObject, eventdata, handles)
end

%Debugging

function button_test_Callback(hObject, eventdata, handles)
disp(handles.GraphFinder)
disp(handles.GraphFinderController)



%Arguments used in callback functions:
% hObject    handle to active object (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Suppressed warnings:
%#ok<*ST2NM> str2num understands words such as 'pi'
%#ok<*DEFNU> MATLAB doesn't find calls to GUIDE Callback functions even when they exist
%#ok<*INUSL> Its easier to include arguments (hObject, eventdata, handles) in every 
%function than to keep track of which functions need all of them and which only some
