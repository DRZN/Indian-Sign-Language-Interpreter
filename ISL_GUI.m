function varargout = Deeksha_try2(varargin)
% DEEKSHA_TRY2 MATLAB code for Deeksha_try2.fig
%      DEEKSHA_TRY2, by itself, creates a new DEEKSHA_TRY2 or raises the existing
%      singleton*.
%
%      H = DEEKSHA_TRY2 returns the handle to a new DEEKSHA_TRY2 or the handle to
%      the existing singleton*.
%
%      DEEKSHA_TRY2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEEKSHA_TRY2.M with the given input arguments.
%
%      DEEKSHA_TRY2('Property','Value',...) creates a new DEEKSHA_TRY2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Deeksha_try2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Deeksha_try2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Deeksha_try2

% Last Modified by GUIDE v2.5 05-Apr-2017 16:20:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Deeksha_try2_OpeningFcn, ...
                   'gui_OutputFcn',  @Deeksha_try2_OutputFcn, ...
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


% --- Executes just before Deeksha_try2 is made visible.
function Deeksha_try2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Deeksha_try2 (see VARARGIN)

% Choose default command line output for Deeksha_try2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Deeksha_try2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Deeksha_try2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
left=get(hObject,'Value');

if(left)
image_new=flip(handles.input_I,2);
axes(handles.ImagePreview);
imshow(image_new);
guidata(hObject,handles);
end



% --- Executes on button press in startPython.
function startPython_Callback(hObject, eventdata, handles)
% hObject    handle to startPython (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 commandStr = 'python C:\Users\hp\Desktop\Deeksha\BE_ISL\deeeksha\camera_final.py 2';
 [status, commandOut] = system(commandStr);
 %input=imread('\images\.png');
 I=imread('C:\Users\hp\Documents\MATLAB\BE_project\Akshara\images\input.png');
 handles.input_I=I;
 axes(handles.ImagePreview);
 imshow(I);
 guidata(hObject,handles);
 


% --- Executes on button press in okDone.
function okDone_Callback(hObject, eventdata, handles)
% hObject    handle to okDone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c=load('net_fitnet_1.mat');
t=load('haus_template_target.mat');
ann=All_in_one_ann(handles.input_I,c.net);

[h_class, c_class]=all_template(t.template_haus);

output1=strcat('C:\Users\hp\Desktop\Deeksha\BE_ISL\deeeksha\images\IMAGES\',num2str(ann),'.png');
output_image1=imread(output1);

output2=strcat('C:\Users\hp\Desktop\Deeksha\BE_ISL\deeeksha\images\IMAGES\',num2str(h_class),'.png');
output_image2=imread(output2);

output3=strcat('C:\Users\hp\Desktop\Deeksha\BE_ISL\deeeksha\images\IMAGES\',num2str(c_class),'.png');
output_image3=imread(output3);

axes(handles.ann_output);
imshow(output_image1);
guidata(hObject,handles);
 
axes(handles.template_output);
imshow(output_image2);
guidata(hObject,handles);
 
axes(handles.cross_output);
imshow(output_image3);
guidata(hObject,handles);

% disp(ann)
% disp(h_class)
% disp(c_class)

guidata(hObject,handles);
