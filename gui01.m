function varargout = main(varargin)
% GUI01 MATLAB code for main.fig
%      GUI01, by itself, creates a new GUI01 or raises the existing
%      singleton*.
%
%      H = GUI01 returns the handle to a new GUI01 or the handle to
%      the existing singleton*.
%
%      GUI01('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI01.M with the given input arguments.
%
%      GUI01('Property','Value',...) creates a new GUI01 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui01_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui01_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui01

% Last Modified by GUIDE v2.5 20-May-2022 00:13:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui01_OpeningFcn, ...
                   'gui_OutputFcn',  @gui01_OutputFcn, ...
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


% --- Executes just before gui01 is made visible.
function gui01_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui01 (see VARARGIN)


% Choose default command line output for gui01
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui01 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui01_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on pushbutton1 press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
recObj = audiorecorder
disp('Start speaking.')
recordblocking(recObj, 5);
disp('End of Recording.');
y = getaudiodata(recObj);
filename='myspeech.wav';
audiowrite(filename,y,8000);

% --- Executes on pushbutton1 press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[y, fs]=audioread('myspeech.wav');
sound(y, fs);
axes(handles.axes1)
plot(y);
xlabel('Time (s)')
ylabel('Magnitude')


% --- Executes on mouse press over axes background.
function axes2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[y, fs]=audioread('myspeech.wav');
ffty= fftshift(fft(y));
fs = 50;
f = (0:length(ffty)-1)*fs/length(ffty);
n = length(y);  
fshift = (-n/2:n/2-1)*(fs/n);
axes(handles.axes2)
plot(fshift,abs(ffty));
xlabel('Frequency (Hz)')
ylabel('Magnitude')
axis([-inf,inf, 0 300])


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rng('default')
[y, fs]=audioread('myspeech.wav');
ynoise = real(y+1.75*randn(1));
axes(handles.axes3)
plot(ynoise);
xlabel('Time (s)')
ylabel('Magnitude')
filename='noise.wav';
audiowrite(filename,ynoise,8000);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ynoise, fs]= audioread('noise.wav');
sound(ynoise,fs);

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ynoise, fs]=audioread('noise.wav');
fftynoise= real(fftshift(fft(ynoise)));
fs = 50;
n = length(ynoise);  
fshift = (-n/2:n/2-1)*(fs/n);
axes(handles.axes4);
plot(fshift,abs(fftynoise));
xlabel('Frequency (Hz)')
ylabel('Magnitude')
axis([-inf,inf, 0 300])



% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global GetN;%定义全局变量，用于存储可编程文本框获得的文本数据。；
global GetN_data;
GetN_data = get(handles.edit1,'String'); %获得数据
GetN= str2double(GetN_data);

[ynoise, fs]=audioread('noise.wav');
yideal=lowpass(ynoise,GetN);
axes(handles.axes5)
plot(yideal);
xlabel('Time (s)')
ylabel('Magnitude')

fftyideal= real(fftshift(fft(yideal)));
fs = 50;
n = length(yideal);  
fshift = (-n/2:n/2-1)*(fs/n);
axes(handles.axes6);
plot(fshift,abs(fftyideal));
xlabel('Frequency (Hz)')
ylabel('Magnitude')
axis([-inf,inf, 0 300])

filename='ideal.wav';
audiowrite(filename,yideal,8000);

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[yideal, fs]= audioread('ideal.wav');
sound(yideal,fs);

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double



% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A=1;                %amplify
f=1;               %Hz
w=f;           %rad/s
p=0;                %rad
%采样
T=1;                %s        %观测时间
fs=f;            %Hz       %采样频率
d=1/fs;             %s        %采样间隔
t=-T/2:d:T/2;       %离散时间t
s1=A*sin(w*t+p);    %正弦信号


[ynoise, fs]=audioread('noise.wav');
ynoisefft=fft(ynoise);
ynonidealfft=ynoisefft*s1;
%傅里叶谱

ynonideal = ifft(ynonidealfft)
fs = 50;
n = length(ynonideal);  
fshift = (-n/2:n/2-1)*(fs/n);
axes(handles.axes8);
plot(fshift,abs(fftynonideal));
xlabel('Frequency (Hz)')
ylabel('Magnitude')
axis([-inf,inf, 0 300])

%声音谱
axes(handles.axes7)
plot(abs(ynonideal));
xlabel('Time (s)')
ylabel('Magnitude')

filename='nonideal.wav';
audiowrite(filename,ynonideal,8000);

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ynonideal, fs]= audioread('nonideal.wav');
sound(ynonideal,fs);

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[y, fs]=audioread('myspeech.wav');
[ynoise, fs]=audioread('noise.wav');
ynoisefft=abs(fft(ynoise));
ynoisem=ynoisefft.^2;
sum=0;
yphase=real(angle(ynoise));

for j=0:1:99
    nn=real(1.75.*randn(1));
    nnfft=abs(fft(nn));
    nnfftm=nnfft.^2;
    sum=sum+nnfftm;
end
average=sum/100;
y2=ynoisem-average;
y1=real(sqrt(y2));
ynonlinearfft=y1.*exp(yphase*1i);
ynonlinear=ifft(ynonlinearfft);

axes(handles.axes9)
plot(ynonlinear);
xlabel('Time (s)')
ylabel('Magnitude')

fftynonlinear= real(fftshift(ynonlinearfft));
fs = 50;
n = length(ynonlinear);  
fshift = (-n/2:n/2-1)*(fs/n);
axes(handles.axes10);
plot(fshift,abs(fftynonlinear));
xlabel('Frequency (Hz)')
ylabel('Magnitude')
axis([-inf,inf, 0 300])

filename='nonlinear.wav';
audiowrite(filename,ynonlinear,8000);

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ynonlinear, fs]= audioread('nonlinear.wav');
sound(ynonlinear,fs);
