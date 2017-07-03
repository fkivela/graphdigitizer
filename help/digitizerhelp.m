function varargout = digitizerhelp(varargin)
% DIGITIZERHELP A GUI for displaying instructions in the use of
% GRAPHDIGITIZER
%
% See also: GRAPHDIGITIZER
%
% Last Modified by GUIDE v2.5 26-Jun-2017 12:22:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @digitizerhelp_OpeningFcn, ...
                   'gui_OutputFcn',  @digitizerhelp_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


function digitizerhelp_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for digitizerhelp
%handles.output = hObject;
% Update handles structure

handles.listbox.String = fileread('help.txt');

guidata(hObject, handles);
% UIWAIT makes digitizerhelp wait for user response (see UIRESUME)
% uiwait(handles.figure1)

% --- Outputs from this function are returned to the command line.
function varargout = digitizerhelp_OutputFcn(hObject, eventdata, handles)  
%varargout{1} = handles.output;

function listbox_Callback(hObject, eventdata, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox

function listbox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%#ok<*ST2NM>
%#ok<*DEFNU>
%#ok<*INUSL>
%#ok<*STOUT>