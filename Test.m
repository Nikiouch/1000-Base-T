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

% Last Modified by GUIDE v2.5 06-Jul-2015 16:03:10

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
% Начальное состояние
initialvalues(handles);



function initialvalues(handles)
% Объявление глобальных переменных
global color;
global codingState;
global inactiveColor; 
global backColor;
global scramblerState;
global decodeState;
global descramblerState;
global currentChannel;
global samples
global fs

fs=125e6;
currentChannel=1;
backColor=[0.9412    0.9412    0.9412];
inactiveColor=[0.5020 0.5020 0.5020];
color=[1.0 0.6 0];
scramblerState=false;
decodeState=false;
descramblerState=false;
codingState=false;
samples=100;
%очистка графиков
 
cla(handles.ax_transmit);
axes(handles.ax_transmit);
set(handles.ax_transmit,'YTick',[]);
set(handles.ax_transmit,'XTick',[]);

cla(handles.ax_transmitSpectrum);
axes(handles.ax_transmitSpectrum);
set(handles.ax_transmit,'YTick',[]);
set(handles.ax_transmit,'XTick',[]);

%Отключение кнопок
set(handles.btn_scrambler,'enable','off');
set(handles.btn_descrambler,'enable','off');
set(handles.btn_coding,'enable','off');
set(handles.btn_decoding,'enable','off');
set(handles.btn_applyTransmit,'enable','off');
set(handles.btn_applyRecieve,'enable','off');
enableaddparams(handles,'off');
enablechannels(handles,'off')
set(handles.chbox_equalizer,'enable','off');
set(handles.btn_equalizer,'enable','off');

%Выделение первой кнопки 
set(handles.btn_channel1,'ForegroundColor',color);
set(handles.btn_channel2,'ForegroundColor',inactiveColor);
set(handles.btn_channel3,'ForegroundColor',inactiveColor);
set(handles.btn_channel4,'ForegroundColor',inactiveColor);
set(handles.btn_channel1,'BackgroundColor','white');
set(handles.btn_channel2,'BackgroundColor',backColor);
set(handles.btn_channel3,'BackgroundColor',backColor);
set(handles.btn_channel4,'BackgroundColor',backColor);



function enablechannels(handles,status)
if isequal(status,'on')
    set(handles.btn_channel1,'String','1 канал');
    set(handles.btn_channel2,'String','2 канал');
    set(handles.btn_channel3,'String','3 канал');
    set(handles.btn_channel4,'String','4 канал');
else
    set(handles.btn_channel1,'String','График');
    set(handles.btn_channel2,'String','');
    set(handles.btn_channel3,'String','');
    set(handles.btn_channel4,'String','');
end
set(handles.btn_channel1,'enable',status);
set(handles.btn_channel2,'enable',status);
set(handles.btn_channel3,'enable',status);
set(handles.btn_channel4,'enable',status);
set(handles.ax_transmitSpectrum,'visible',status);

function enableaddparams(handles,status)
    set(handles.chbox_pulseShaping,'enable',status);
    set(handles.chbox_noise,'enable',status);
    set(handles.chbox_phase,'enable',status);
    set(handles.btn_pulseShaping,'enable',status);
    set(handles.btn_noise,'enable',status);
    set(handles.btn_phase,'enable',status);
% --- Outputs from this function are returned to the command line.

function drawspectrum(handles)
global currentChannel color fs samples;

[f, Y, NFFT]=spectrumest(handles.sampledSignal(currentChannel,:),fs*samples);
axes(handles.ax_transmitSpectrum);
plot(f, 2*abs(Y(1:NFFT/2+1)),'color',color);
set(handles.ax_transmitSpectrum,'YLimMode','manual');
set(handles.ax_transmitSpectrum,'YLim',[min(Y)-1 max(Y)+1]);

function drawgraphic(handles)
global currentChannel color;

y=handles.sampledSignal(currentChannel,:);
x=handles.time;
axes(handles.ax_transmit);
plot(x, y,'color',color);
set(handles.edt_input,'String',num2str(handles.signal(currentChannel,:)));
set(handles.ax_transmit,'YLimMode','manual');
set(handles.ax_transmit,'YLim',[-3 3]); 

function meandr=createsamples(handles)
global samples;
data=handles.data;
meandr=zeros(1,length(data)*samples);
for i=1:length(data)
    meandr((i-1)*samples+1:(i-1)*samples+samples)=data(i);
end

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

%Глобальные переменные
global color ;

%Проверка поля edt_input, если пусто, то чтение из файла.
enablechannels(handles,'off');
data=[];
method=questdlg('Откуда загрузить данные?','Загрузка данных','File','Field','File');
if isequal(method,'File')
    data=choosefromfile(handles,data);
else
    data=get(handles.edt_input,'String');
    data=str2num(data);
end
initialvalues(handles);
%Операции над данными. И создание вектора для построение меандра.
handles.data=fliplr(data);
guidata(handles.figure_testbed,handles);

meandr=createsamples(handles);

%Построение графика меандра, а так же редактирование осей.
axes(handles.ax_transmit);
plot(meandr,'color',color);
set(handles.ax_transmit,'YLimMode','manual');
set(handles.ax_transmit,'YLim',[-2 2]);
set(handles.ax_transmit,'XTick',[]);
%Изменения свойств объектов программы. 
if ~isempty(data)
    set(handles.btn_scrambler,'enable','on');
    set(handles.btn_coding,'enable','on');
else
    initialvalues(handles);
end

function data=choosefromfile(handles,data)
[FileName,PathName] = uigetfile({'*.txt','text files'});
if ~isequal(FileName,0)
    file=fopen([PathName FileName],'r');
    data=fscanf(file,'%1d');
    fclose(file);
    set(handles.edt_input,'String',num2str(data'));
end

% --- Executes on button press in btn_channel1.
function btn_channel1_Callback(hObject, eventdata, handles)
% hObject    handle to btn_channel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global color inactiveColor backColor currentChannel;
currentChannel=1;
set(handles.btn_channel1,'ForegroundColor',color);
set(handles.btn_channel2,'ForegroundColor',inactiveColor);
set(handles.btn_channel3,'ForegroundColor',inactiveColor);
set(handles.btn_channel4,'ForegroundColor',inactiveColor);
set(handles.btn_channel1,'BackgroundColor','white');
set(handles.btn_channel2,'BackgroundColor',backColor);
set(handles.btn_channel3,'BackgroundColor',backColor);
set(handles.btn_channel4,'BackgroundColor',backColor);

drawgraphic(handles);
drawspectrum(handles);

% --- Executes on button press in btn_channel2.
function btn_channel2_Callback(hObject, eventdata, handles)
% hObject    handle to btn_channel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global color inactiveColor backColor currentChannel;
currentChannel=2;
set(handles.btn_channel2,'ForegroundColor',color);
set(handles.btn_channel3,'ForegroundColor',inactiveColor);
set(handles.btn_channel4,'ForegroundColor',inactiveColor);
set(handles.btn_channel1,'ForegroundColor',inactiveColor);
set(handles.btn_channel2,'BackgroundColor','white');
set(handles.btn_channel3,'BackgroundColor',backColor);
set(handles.btn_channel4,'BackgroundColor',backColor);
set(handles.btn_channel1,'BackgroundColor',backColor);

drawgraphic(handles);
drawspectrum(handles);

% --- Executes on button press in btn_channel4.
function btn_channel4_Callback(hObject, eventdata, handles)
% hObject    handle to btn_channel4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global color inactiveColor backColor currentChannel;
currentChannel=4;
set(handles.btn_channel4,'ForegroundColor',color);
set(handles.btn_channel3,'ForegroundColor',inactiveColor);
set(handles.btn_channel2,'ForegroundColor',inactiveColor);
set(handles.btn_channel1,'ForegroundColor',inactiveColor);
set(handles.btn_channel4,'BackgroundColor','white');
set(handles.btn_channel3,'BackgroundColor',backColor);
set(handles.btn_channel2,'BackgroundColor',backColor);
set(handles.btn_channel1,'BackgroundColor',backColor);

drawgraphic(handles);
drawspectrum(handles);

% --- Executes on button press in btn_channel3.
function btn_channel3_Callback(hObject, eventdata, handles)
% hObject    handle to btn_channel3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global color inactiveColor backColor currentChannel;
currentChannel=3;
set(handles.btn_channel3,'ForegroundColor',color);
set(handles.btn_channel2,'ForegroundColor',inactiveColor);
set(handles.btn_channel1,'ForegroundColor',inactiveColor);
set(handles.btn_channel4,'ForegroundColor',inactiveColor);
set(handles.btn_channel3,'BackgroundColor','white');
set(handles.btn_channel2,'BackgroundColor',backColor);
set(handles.btn_channel1,'BackgroundColor',backColor);
set(handles.btn_channel4,'BackgroundColor',backColor);

drawgraphic(handles);
drawspectrum(handles);
% --- Executes on button press in btn_scrambler.
function btn_scrambler_Callback(hObject, eventdata, handles)
% hObject    handle to btn_scrambler (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global color inactiveColor backColor scramblerState;
%Проверка существование данных, если их нет, то завершить выполнение
%функции.
%Назначение состояние кнопки на 'нажата' и создание переменных с их
%заполнением
scramblerState=true;
temp=handles.data;
data=zeros(1,ceil(length(temp)/8)*8);
data(1:length(temp))=temp;
startIndex=1;
endIndex=8;
cs=[0 0 0];
%Генерация scr и сохранение в handles
scr=round(random('uniform',zeros(1,33),ones(1,33)));
handles.scr=scr;
guidata(handles.figure_testbed,handles);
%Скремблирование информации
for i=1:ceil(length(temp)/8)
    [scr sy sx sg]=wordgenerator(scr);
    sc=scramblerbitgenerator(sy,sx,'SEND',0,0,1,[0 0 0]);
    data(startIndex:endIndex)=datascrambler(data( startIndex:endIndex ),sc,1,0,cs,'OK',0);
    startIndex=(i*8)+1;
    endIndex=(i+1)*8;
end
%Обновление поля data и откючение btn_scrambler
handles.data=data;
guidata(handles.figure_testbed,handles);
set(handles.btn_scrambler,'enable','off');
set(handles.btn_descrambler,'enable','on');
%Вывод информации в поле edt_input и создание вектора для постоения
%меандра.
str=num2str(data);
meandr=createsamples(handles);
%Построение графика меандра скремблированной информации.
set(handles.edt_input,'String',str);
axes(handles.ax_transmit);
plot(meandr,'color',color);        
set(handles.ax_transmit,'YLimMode','manual');
set(handles.ax_transmit,'YLim',[-2 2]);
set(handles.ax_transmit,'XTick',[]);


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
global codingState samples;
codingState=true;
enablechannels(handles,'on');
set(handles.btn_coding,'enable','off');
enableaddparams(handles,'on');


temp=handles.data;
data=zeros(1,ceil(length(temp)/8)*8);
data(1:length(temp))=temp;
cs=[0 0 0];
startIndex=1;
endIndex=8;
for i=1:ceil(length(data)/8)
    sd=data( startIndex:endIndex );
    [sd,cs]=convolutionalencoder(sd,cs,1);
    [table1,table2]=initializeLookupTables;
    if(sd(9)==1)
        index=bi2de(wrev(sd(7:8)));
        index=index*4+1;
        signal(1:4,i)=table2(bi2de(wrev(sd(1:6)))+1,index:index+3);
    else
        index=bi2de(wrev(sd(7:8)));
        index=index*4+1;
        signal(1:4,i)=table1(bi2de(wrev(sd(1:6)))+1,index:index+3);
    end
    startIndex=(i*8)+1;
    endIndex=(i+1)*8;
end
handles.signal=signal;
[signal, time]=sampling(signal,samples);
handles.sampledSignal=signal;
handles.time=time;
guidata(handles.figure_testbed,handles);

drawgraphic(handles);
drawspectrum(handles);


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
if ~isfield(handles,'data')
    msgbox('Нет данных!');
else
    if isempty(handles.data)
        msgbox('Нет данных!');
    else
        %Объявление переменных и их заполнение.
        temp=handles.data;
        data=zeros(1,ceil(length(temp)/8)*8);
        data(1:length(temp))=temp;
        startIndex=1;
        endIndex=8;
        cs=[0 0 0];
        scr=handles.scr;
        %Дескремблирование
        for i=1:ceil(length(temp)/8)
            [scr sy sx sg]=wordgenerator(scr);
            sc=scramblerbitgenerator(sy,sx,'SEND',0,0,1,[0 0 0]);
            data(startIndex:endIndex)=datascrambler(data( startIndex:endIndex ),sc,1,0,cs,'OK',0);
            startIndex=(i*8)+1;
            endIndex=(i+1)*8;
        end
        data=num2str(fliplr(data));
        set(handles.edt_output,'String',data);
        %Обновление поля data и откючение btn_descrambler.
        handles.data=data;
        guidata(handles.figure_testbed,handles);
        set(handles.btn_descrambler,'enable','off');
    end
end

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
data=get(handles.edt_output,'String');
if ~isempty(data)
    [FileName, DirName] = uiputfile({'*.txt','text file'},'Сохранить данные','output');
    if ~isequal(FileName,0)
        file=fopen([DirName FileName],'w+');
        fprintf(file,'%1d',str2num(data));
        fclose(file);
    end
end

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edt_input.
function edt_input_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edt_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
