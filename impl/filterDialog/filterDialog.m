function varargout = filterDialog(varargin)
% FILTERDIALOG MATLAB code for filterDialog.fig
%      FILTERDIALOG, by itself, creates a new FILTERDIALOG or raises the existing
%      singleton*.
%
%      H = FILTERDIALOG returns the handle to a new FILTERDIALOG or the handle to
%      the existing singleton*.
%
%      FILTERDIALOG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FILTERDIALOG.M with the given input arguments.
%
%      FILTERDIALOG('Property','Value',...) creates a new FILTERDIALOG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before filterDialog_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to filterDialog_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help filterDialog

% Last Modified by GUIDE v2.5 02-May-2018 15:35:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @filterDialog_OpeningFcn, ...
                   'gui_OutputFcn',  @filterDialog_OutputFcn, ...
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


% --- Executes just before filterDialog is made visible.
function filterDialog_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to filterDialog (see VARARGIN)

outStruct = struct;
outStruct.undo = false;

outStruct.useX = false;
outStruct.useY = false;
outStruct.useM = false;
outStruct.useT = false;

outStruct.minX = 0;
outStruct.minY = 0;
outStruct.minM = 0;
outStruct.minT = 0;

outStruct.maxX = 100;
outStruct.maxY = 100;
outStruct.maxM = 100;
outStruct.maxT = 100;

% Choose default command line output for filterDialog
%handles.output = "EpicWinLol";
handles.output = outStruct;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes filterDialog wait for user response (see UIRESUME)
uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = filterDialog_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% The figure can be deleted now
delete(handles.figure1);



function figure1_CloseRequestFcn(hObject, eventdata, handles)

if isequal(get(hObject,'waitstatus'),'waiting')
    uiresume(hObject);
else
    delete(hObject);
end


% --- Executes on button press in filterApplyButton.
function filterApplyButton_Callback(hObject, eventdata, handles)
handles.output.useX = get(handles.filterXThresholdCheckBox, 'Value');
handles.output.useY = get(handles.filterYThresholdCheckBox, 'Value');
handles.output.useM = get(handles.filterMThresholdCheckBox, 'Value');
handles.output.useT = get(handles.filterTThresholdCheckBox, 'Value');

handles.output.minX = fix(str2double(get(handles.filterXMinEdit, 'String')));
handles.output.minY = fix(str2double(get(handles.filterYMinEdit, 'String')));
handles.output.minM = fix(str2double(get(handles.filterMMinEdit, 'String')));
handles.output.minT = fix(str2double(get(handles.filterTMinEdit, 'String')));

handles.output.maxX = fix(str2double(get(handles.filterXMaxEdit, 'String')));
handles.output.maxY = fix(str2double(get(handles.filterYMaxEdit, 'String')));
handles.output.maxM = fix(str2double(get(handles.filterMMaxEdit, 'String')));
handles.output.maxT = fix(str2double(get(handles.filterTMaxEdit, 'String')));

handles.output.filterType = get(handles.filterTypePopupMenu, 'Value');

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);




% --- Executes on button press in filterXThresholdCheckBox.
function filterXThresholdCheckBox_Callback(hObject, eventdata, handles)
% hObject    handle to filterXThresholdCheckBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of filterXThresholdCheckBox


% --- Executes on button press in filterYThresholdCheckBox.
function filterYThresholdCheckBox_Callback(hObject, eventdata, handles)
% hObject    handle to filterYThresholdCheckBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of filterYThresholdCheckBox


% --- Executes on button press in filterMThresholdCheckBox.
function filterMThresholdCheckBox_Callback(hObject, eventdata, handles)
% hObject    handle to filterMThresholdCheckBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of filterMThresholdCheckBox


% --- Executes on button press in filterTThresholdCheckBox.
function filterTThresholdCheckBox_Callback(hObject, eventdata, handles)
% hObject    handle to filterTThresholdCheckBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of filterTThresholdCheckBox



function filterXMinEdit_Callback(hObject, eventdata, handles)
% hObject    handle to filterXMinEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filterXMinEdit as text
%        str2double(get(hObject,'String')) returns contents of filterXMinEdit as a double


% --- Executes during object creation, after setting all properties.
function filterXMinEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filterXMinEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function filterYMinEdit_Callback(hObject, eventdata, handles)
% hObject    handle to filterYMinEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filterYMinEdit as text
%        str2double(get(hObject,'String')) returns contents of filterYMinEdit as a double


% --- Executes during object creation, after setting all properties.
function filterYMinEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filterYMinEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function filterMMinEdit_Callback(hObject, eventdata, handles)
% hObject    handle to filterMMinEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filterMMinEdit as text
%        str2double(get(hObject,'String')) returns contents of filterMMinEdit as a double


% --- Executes during object creation, after setting all properties.
function filterMMinEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filterMMinEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function filterTMinEdit_Callback(hObject, eventdata, handles)
% hObject    handle to filterTMinEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filterTMinEdit as text
%        str2double(get(hObject,'String')) returns contents of filterTMinEdit as a double


% --- Executes during object creation, after setting all properties.
function filterTMinEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filterTMinEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function filterXMaxEdit_Callback(hObject, eventdata, handles)
% hObject    handle to filterXMaxEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filterXMaxEdit as text
%        str2double(get(hObject,'String')) returns contents of filterXMaxEdit as a double


% --- Executes during object creation, after setting all properties.
function filterXMaxEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filterXMaxEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function filterYMaxEdit_Callback(hObject, eventdata, handles)
% hObject    handle to filterYMaxEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filterYMaxEdit as text
%        str2double(get(hObject,'String')) returns contents of filterYMaxEdit as a double


% --- Executes during object creation, after setting all properties.
function filterYMaxEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filterYMaxEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function filterMMaxEdit_Callback(hObject, eventdata, handles)
% hObject    handle to filterMMaxEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filterMMaxEdit as text
%        str2double(get(hObject,'String')) returns contents of filterMMaxEdit as a double


% --- Executes during object creation, after setting all properties.
function filterMMaxEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filterMMaxEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function filterTMaxEdit_Callback(hObject, eventdata, handles)
% hObject    handle to filterTMaxEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filterTMaxEdit as text
%        str2double(get(hObject,'String')) returns contents of filterTMaxEdit as a double


% --- Executes during object creation, after setting all properties.
function filterTMaxEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filterTMaxEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in undoLastFilterButton.
function undoLastFilterButton_Callback(hObject, eventdata, handles)

handles.output.undo = true;
handles.output.filterType = get(handles.filterTypePopupMenu, 'Value');

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);


% --- Executes during object creation, after setting all properties.
function filterTypePopupMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filterTypePopupMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function filterTypePopupMenu_Callback(hObject, eventdata, handles)
% hObject    handle to filterTypePopupMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filterTypePopupMenu as text
%        str2double(get(hObject,'String')) returns contents of filterTypePopupMenu as a double
