function varargout = Test(varargin)
% TEST MATLAB code for Test.fig
%      TEST, by itself, creates a new TEST or raises the existing
%      singleton*.
%
%      H = TEST returns the handle to a new TEST or the handle to
%      the existing singleton*.
%
%      TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST.M with the given input arguments.
%
%      TEST('Property','Value',...) creates a new TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Test

% Last Modified by GUIDE v2.5 30-Jun-2015 14:15:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Test_OpeningFcn, ...
                   'gui_OutputFcn',  @Test_OutputFcn, ...
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


% --- Executes just before Test is made visible.
function Test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Test (see VARARGIN)

% Choose default command line output for Test
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Test wait for user response (see UIRESUME)
% uiwait(handles.figure_testbed);
global color;
color=[1.0 0.6 0];


% --- Outputs from this function are returned to the command line.
function varargout = Test_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2



function edt_input_Callback(hObject, eventdata, handles)
% hObject    handle to edt_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_input as text
%        str2double(get(hObject,'String')) returns contents of edt_input as a double


% --- Executes during object creation, after setting all properties.
function edt_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_load.
function btn_load_Callback(hObject, eventdata, handles)
% hObject    handle to btn_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global color;
data=get(handles.edt_input,'String');
if isempty(data)
    [FileName,PathName,FilterIndex] = uigetfile({'*.txt','text files'});
end
data=str2num(data);
handles.data=fliplr(data);
guidata(handles.figure_testbed,handles);

disLength=50;
meandr=zeros(1,length(data)*disLength);
for i=1:length(data)
    meandr((i-1)*disLength+1:(i-1)*disLength+disLength)=data(i);
end

axes(handles.axes1);
plot(meandr,'color',color);
set(handles.axes1,'YLimMode','manual');
set(handles.axes1,'YLim',[-2 2]);
set(handles.axes1,'XTick',[]);


% --- Executes on button press in btn_channel1.
function btn_channel1_Callback(hObject, eventdata, handles)
% hObject    handle to btn_channel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
color=[1.0 0.6 0];
inactiveColor=get(handles.btn_channel1,'ForegroundColor');
if color~=inactiveColor
    backColor=get(handles.btn_channel1,'BackgroundColor');
    set(handles.btn_channel1,'ForegroundColor',color);
    set(handles.btn_channel2,'ForegroundColor',inactiveColor);
    set(handles.btn_channel3,'ForegroundColor',inactiveColor);
    set(handles.btn_channel4,'ForegroundColor',inactiveColor);
    set(handles.btn_channel1,'BackgroundColor','white');
    set(handles.btn_channel2,'BackgroundColor',backColor);
    set(handles.btn_channel3,'BackgroundColor',backColor);
    set(handles.btn_channel4,'BackgroundColor',backColor);
end

% --- Executes on button press in btn_channel2.
function btn_channel2_Callback(hObject, eventdata, handles)
% hObject    handle to btn_channel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
color=[1.0 0.6 0];
inactiveColor=get(handles.btn_channel2,'ForegroundColor');
if color~=inactiveColor
    backColor=get(handles.btn_channel2,'BackgroundColor');
    set(handles.btn_channel2,'ForegroundColor',color);
    set(handles.btn_channel3,'ForegroundColor',inactiveColor);
    set(handles.btn_channel4,'ForegroundColor',inactiveColor);
    set(handles.btn_channel1,'ForegroundColor',inactiveColor);
    set(handles.btn_channel2,'BackgroundColor','white');
    set(handles.btn_channel3,'BackgroundColor',backColor);
    set(handles.btn_channel4,'BackgroundColor',backColor);
    set(handles.btn_channel1,'BackgroundColor',backColor);
end


% --- Executes on button press in btn_channel4.
function btn_channel4_Callback(hObject, eventdata, handles)
% hObject    handle to btn_channel4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
color=[1.0 0.6 0];
inactiveColor=get(handles.btn_channel4,'ForegroundColor');
if color~=inactiveColor
    backColor=get(handles.btn_channel4,'BackgroundColor');
    set(handles.btn_channel4,'ForegroundColor',color);
    set(handles.btn_channel3,'ForegroundColor',inactiveColor);
    set(handles.btn_channel2,'ForegroundColor',inactiveColor);
    set(handles.btn_channel1,'ForegroundColor',inactiveColor);
    set(handles.btn_channel4,'BackgroundColor','white');
    set(handles.btn_channel3,'BackgroundColor',backColor);
    set(handles.btn_channel2,'BackgroundColor',backColor);
    set(handles.btn_channel1,'BackgroundColor',backColor);
end


% --- Executes on button press in btn_channel3.
function btn_channel3_Callback(hObject, eventdata, handles)
% hObject    handle to btn_channel3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
color=[1.0 0.6 0];
inactiveColor=get(handles.btn_channel3,'ForegroundColor');
if color~=inactiveColor
    backColor=get(handles.btn_channel3,'BackgroundColor');
    set(handles.btn_channel3,'ForegroundColor',color);
    set(handles.btn_channel2,'ForegroundColor',inactiveColor);
    set(handles.btn_channel1,'ForegroundColor',inactiveColor);
    set(handles.btn_channel4,'ForegroundColor',inactiveColor);
    set(handles.btn_channel3,'BackgroundColor','white');
    set(handles.btn_channel2,'BackgroundColor',backColor);
    set(handles.btn_channel1,'BackgroundColor',backColor);
    set(handles.btn_channel4,'BackgroundColor',backColor);
end


% --- Executes on button press in btn_scrambler.
function btn_scrambler_Callback(hObject, eventdata, handles)
% hObject    handle to btn_scrambler (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'data')
    msgbox('��� ������!');
else
    if isempty(handles.data)
        msgbox('��� ������!');
    else
        global color;
        temp=handles.data;
        data=zeros(1,ceil(length(temp)/8)*8);
        data(1:length(temp))=temp;
        startIndex=1;
        endIndex=8;
        cs=[0 0 0];
        scr=[];
        for i=1:ceil(length(temp)/8)
            [scr sy sx sg]=wordgenerator(scr);
            sc=scramblerbitgenerator(sy,sx,'SEND',0,0,1,[0 0 0]);
            data(startIndex:endIndex)=datascrambler(data( startIndex:endIndex ),sc,1,0,cs,'OK',0);
            startIndex=(i*8)+1;
            endIndex=(i+1)*8;
        end
        str=num2str(data)
        disLength=50;
        meandr=zeros(1,length(data)*disLength);
        for i=1:length(data)
            meandr((i-1)*disLength+1:(i-1)*disLength+disLength)=data(i);
        end
        set(handles.edt_input,'String',str);
        axes(handles.axes1);
        plot(meandr,'color',color);
        set(handles.axes1,'YLimMode','manual');
        set(handles.axes1,'YLim',[-2 2]);
        set(handles.axes1,'XTick',[]);
    end
end


% --- Executes on button press in btn_applyTransmit.
function btn_applyTransmit_Callback(hObject, eventdata, handles)
% hObject    handle to btn_applyTransmit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_coding.
function btn_coding_Callback(hObject, eventdata, handles)
% hObject    handle to btn_coding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in chbox_pulseShaping.
function chbox_pulseShaping_Callback(hObject, eventdata, handles)
% hObject    handle to chbox_pulseShaping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chbox_pulseShaping


% --- Executes on button press in chbox_noise.
function chbox_noise_Callback(hObject, eventdata, handles)
% hObject    handle to chbox_noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chbox_noise


% --- Executes on button press in chbox_phase.
function chbox_phase_Callback(hObject, eventdata, handles)
% hObject    handle to chbox_phase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA) 
% Hint: get(hObject,'Value') returns toggle state of chbox_phase


% --- Executes on button press in btn_pulseShaping.
function btn_pulseShaping_Callback(hObject, eventdata, handles)
% hObject    handle to btn_pulseShaping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
H=open('pulseshaping.fig');


% --- Executes on button press in btn_noise.
function btn_noise_Callback(hObject, eventdata, handles)
% hObject    handle to btn_noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_phase.
function btn_phase_Callback(hObject, eventdata, handles)
% hObject    handle to btn_phase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_decoding.
function btn_decoding_Callback(hObject, eventdata, handles)
% hObject    handle to btn_decoding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_applyRecieve.
function btn_applyRecieve_Callback(hObject, eventdata, handles)
% hObject    handle to btn_applyRecieve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_descrambler.
function btn_descrambler_Callback(hObject, eventdata, handles)
% hObject    handle to btn_descrambler (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in chbox_equalizer.
function chbox_equalizer_Callback(hObject, eventdata, handles)
% hObject    handle to chbox_equalizer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chbox_equalizer


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6


% --- Executes on button press in btn_equalizer.
function btn_equalizer_Callback(hObject, eventdata, handles)
% hObject    handle to btn_equalizer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edt_output_Callback(hObject, eventdata, handles)
% hObject    handle to edt_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_output as text
%        str2double(get(hObject,'String')) returns contents of edt_output as a double


% --- Executes during object creation, after setting all properties.
function edt_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_save.
function btn_save_Callback(hObject, eventdata, handles)
% hObject    handle to btn_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edt_input.
function edt_input_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edt_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)