
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
% See also: DIGITIZE

% Last Modified by GUIDE v2.5 26-Jun-2017 10:11:12

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

names = [fieldnames(imagenavigationcallbacks); fieldnames(editfieldcallbacks); fieldnames(buttoncallbacks)];
callbacks = cell2struct([struct2cell(imagenavigationcallbacks); struct2cell(editfieldcallbacks); struct2cell(buttoncallbacks)], names, 1);
handles.callbacks = callbacks;

handles.img = [];
handles.img_object = [];
handles.x_size = 0;
handles.y_size = 0;

handles.y_data = [];
handles.plot_object = [];
handles.savefile = handles.edit_save_file.String;

handles.mode = 'none';
handles.clicks = 0;

handles.start_x = [];
handles.start_y = [];
handles.color_param = str2double(handles.edit_color.String);
handles.diff_param = str2double(handles.edit_diff.String);

handles.zoom_level = handles.slider_z.Value;
handles.zoom_x = handles.slider_x.Value;
handles.zoom_y = handles.slider_y.Value;

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

% Choose default command line output for graphdigitizer
% handles.output = hObject;

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

%Image navigation

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

function figure1_WindowScrollWheelFcn(hObject, eventdata, handles)
feval(handles.callbacks.scrollWheel, hObject, eventdata, handles);

function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
feval(handles.callbacks.keyPress, hObject, eventdata, handles);

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

%Edit fields

function edit_color_Callback(hObject, eventdata, handles)
feval(handles.callbacks.editColor, hObject, eventdata, handles)

function edit_color_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_diff_Callback(hObject, eventdata, handles)
feval(handles.callbacks.editDiff, hObject, eventdata, handles)

function edit_diff_CreateFcn(hObject, eventdata, handles)
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
disp(handles)

%TO DO:
%This is a list of features that should be made available in upcoming
%versions of this program. Also includes a list of known bugs.
%
% PRIORITY I
% - - -
%
% PRIORITY II
% - delete several data points by pressing down mouse button 1 and moving the mouse over them 
% - 'are you sure?' -question before refreshing the graph and overwriting all user-made changes
% - forbid wasd key activity when an edit field is active
% - create algorithm to reduce static in the graph
%
%PRIORITY III
% - set index value edit field maximum values depending on size of picture and scale mode
% - improve graph-finding algorithm
% - improve the behavior of the parameters
% - indicate which mode is active
% - functionality to remove all data points withing a specified distance of the edges of the picture
% - check the validity of output file name
% - option to specify save file data format and headers
% - expand the help GUI

%Arguments used in callback functions:
% hObject    handle to active object (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Suppressed warnings:
%#ok<*ST2NM> str2num understans words such as 'pi'
%#ok<*DEFNU> MATLAB doesn't find calls to GUIDE Callback functions even when they exist
%#ok<*INUSL> Its easier to include arguments (hObject, eventdata, handles) in every 
%function than to keep track of which functions need all of them and which only some
