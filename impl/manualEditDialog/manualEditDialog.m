function varargout = manualEditDialog(varargin)
% MANUALEDITDIALOG MATLAB code for manualEditDialog.fig
%      MANUALEDITDIALOG, by itself, creates a new MANUALEDITDIALOG or raises the existing
%      singleton*.
%
%      H = MANUALEDITDIALOG returns the handle to a new MANUALEDITDIALOG or the handle to
%      the existing singleton*.
%
%      MANUALEDITDIALOG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MANUALEDITDIALOG.M with the given input arguments.
%
%      MANUALEDITDIALOG('Property','Value',...) creates a new MANUALEDITDIALOG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before manualEditDialog_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to manualEditDialog_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help manualEditDialog

% Last Modified by GUIDE v2.5 03-May-2018 13:44:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @manualEditDialog_OpeningFcn, ...
                   'gui_OutputFcn',  @manualEditDialog_OutputFcn, ...
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

% --- Executes just before manualEditDialog is made visible.
function manualEditDialog_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to manualEditDialog (see VARARGIN)

% Get variables from parent GUI
handles.totalframes = varargin{1}.totalframes;
handles.regioncount = varargin{1}.regioncount;
handles.processedFrameList = varargin{1}.processedFrameList;
handles.ProcessedXList = varargin{1}.ProcessedXList;
handles.ProcessedYList = varargin{1}.ProcessedYList;
handles.ProcessedMList = varargin{1}.ProcessedMList;

% Obtain first frame for reference
v = VideoReader(varargin{1}.pathfilename);
handles.firstFrame = readFrame(v);

% Choose plot type, plot, and get handles to the plots
handles.haveTimeMerge = 0;
handles.plotHandles = plotChooseTracesROI(handles);

% Choose default command line output for manualEditDialog
% handles.output = hObject;
handles.output = "Traces GUI finished";

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes manualEditDialog wait for user response (see UIRESUME)
uiwait(handles.manualEditDialog1);
%uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = manualEditDialog_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% The figure can be deleted now
%delete(handles.figure1);
delete(handles.manualEditDialog1);


% function figure1_CloseRequestFcn(hObject, eventdata, handles)
% 
% if isequal(get(hObject,'waitstatus'),'waiting')
%     uiresume(hObject);
% else
%     delete(hObject);
% end


% --- Executes during object creation, after setting all properties.
function manualPlotTypePopupMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to manualPlotTypePopupMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

%set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});


% --- Executes when user attempts to close manualEditDialog1.
function manualEditDialog1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to manualEditDialog1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
% delete(hObject);

if isequal(get(hObject,'waitstatus'),'waiting')
    uiresume(hObject);
else
    delete(hObject);
end
