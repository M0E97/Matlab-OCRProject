function varargout = OCR(varargin)
% OCR MATLAB code for OCR.fig
%      OCR, by itself, creates a new OCR or raises the existing
%      singleton*.
%
%      H = OCR returns the handle to a new OCR or the handle to
%      the existing singleton*.
%
%      OCR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OCR.M with the given input arguments.
%
%      OCR('Property','Value',...) creates a new OCR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OCR_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OCR_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OCR

% Last Modified by GUIDE v2.5 03-Mar-2018 23:58:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OCR_OpeningFcn, ...
                   'gui_OutputFcn',  @OCR_OutputFcn, ...
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


% --- Executes just before OCR is made visible.
function OCR_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OCR (see VARARGIN)

% Choose default command line output for OCR
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OCR wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = OCR_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Match.
function Match_Callback(hObject, eventdata, handles)
% hObject    handle to Match (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp
global tar
[rtar,ctar]=size(tar);
[rtemp,ctemp]=size(temp);


corrMat=[];
for i=1: (rtar-rtemp+1)
    for s=1:(ctar-ctemp+1)
        x=tar(i:i+rtemp-1,s:s+ctemp-1);
        corrMat(i,s)=corr2(x,temp);
    end
end
if max(max(corrMat))>0.9
    [rnum,r]=max(corrMat)
    [cnum,col]=max(max(corrMat))
    v=r(col);
    rectangle('position',[col,v,ctemp,rtemp],'Edgecolor','r');
end
axes(handles.axes2)
imshow(imcrop(tar,[col,v,ctemp,rtemp]));


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
startingFolder = pwd;

defaultFileName = fullfile(startingFolder, '*.*');
[baseFileName, folder] = uigetfile(defaultFileName, 'Select Image');
if baseFileName == 0
	return;
end
fullFileName = fullfile(folder, baseFileName)
t=imread(fullFileName);
global temp
temp=rgb2gray(t);
axes(handles.axes1)
imshow(temp);






% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
startingFolder = pwd;

defaultFileName = fullfile(startingFolder, '*.*');
[baseFileName, folder] = uigetfile(defaultFileName, 'Select Image');
if baseFileName == 0
	return;
end
fullFileName = fullfile(folder, baseFileName)
u=imread(fullFileName);
global tar
tar=rgb2gray(u);
axes(handles.axes3)
imshow(tar);
