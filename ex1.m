% Projet d'électronique: Traîtement du signal ING3 TD3
% Léandre LIXI
% Stéphane ROSENFELD
% Samuel THOMAS
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------
function varargout = ex1(varargin)
% EX1 MATLAB code for ex1.fig
%      EX1, by itself, creates a new EX1 or raises the existing
%      singleton*.
%
%      H = EX1 returns the handle to a new EX1 or the handle to
%      the existing singleton*.
%
%      EX1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EX1.M with the given input arguments.
%
%      EX1('Property','Value',...) creates a new EX1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ex1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ex1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
% Edit the above text to modify the response to help ex1
% Last Modified by GUIDE v2.5 11-Mar-2013 21:32:01
%------------------------------------------------------------------------------------------------------------------------------------------------------------
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ex1_OpeningFcn, ...
                   'gui_OutputFcn',  @ex1_OutputFcn, ...
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
%--------------------------------------------------------------------------------------------------------------------------------------------------------------------

% --- Executes just before ex1 is made visible.
function ex1_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to ex1 (see VARARGIN)

    % Declaration & Initialisation
    %[x,Fe,Nbits] = wavread('son_TP1.wav');
    [x,Fe,Nbits] = wavread('ProjetElec.wav');
    y = 0;
    handles.Nbits = Nbits;
    handles.x = x;
    handles.y = y;
    handles.Fe = Fe;
    handles.f = 1000*(0:256)/512;
    handles.t = (0 : 256)/512;
 
    % Choose default command line output for ex1
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes ex1 wait for user response (see UIRESUME)
    % uiwait(handles.figure1);
%____________________________________________________________________________________________________________________________________________________________________________

% --- Outputs from this function are returned to the command line.
function varargout = ex1_OutputFcn(hObject, eventdata, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;
%________________________________________________________________________________________________________________________________________________________________

% --- Executes on button press in pushbutton1: EFFET TEMPOREL
function pushbutton1_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbutton1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    % Declaration & Initialisation
    c = 0.7;
    D = 10000; % ecart entre le son et le son avec echo (en point echantillonage)
    b = zeros(1,10*D+1); % 10=N correspond au nombre d'echo souhaité
    b(1)= 1; % b est le numerateur
    b(end)= c;
    a = 1; % dénominateur
    handles.y = filter(b,a,handles.x); % permet de filtrer avec b ==> effectue l'echo   
   
    wavplay(handles.y,handles.Fe);
    


%___________________________________________________________________________________________________________________________________________________________________________

% --- Executes on button press in pushbutton2: EFFET FREQUENTIEL
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

infile = 'ProjetElec.wav';
% read in wav sample
[ x, Fs, N ] = wavread(infile);

% min and max centre cutoff frequency of variable bandpass filter
minf=500;
maxf=3000;

% wah frequency, how many Hz per second are cycled through
Fw = 2000;

% change in centre frequency per sample (Hz)
delta = Fw/Fs;

% create triangle wave of centre frequency values
Fc = minf:delta:maxf;
while(length(Fc) < length(x) )
Fc= [ Fc (maxf:-delta:minf) ];
Fc= [ Fc (minf:delta:maxf) ];
end
% trim tri wave to size of input
Fc = Fc(1:length(x));

% difference equation coefficients
% must be recalculated each time Fc changes
F1 = 2*sin((pi*Fc(1))/Fs);

% this dictates size of the pass bands
Q1 = 2*damp(2);
yh=zeros(size(x)); % create emptly out vectors
yb=zeros(size(x));
yl=zeros(size(x));

% first sample, to avoid referencing of negative signals
yh(1) = x(1);
yb(1) = F1*yh(1);
yl(1) = F1*yb(1);

% Apply difference equation to the sample
for n = 2:length(x),
yh(n) = x(n) - yl(n-1) - Q1*yb(n-1);

yb(n) = F1*yh(n) + yb(n-1);
yl(n) = F1*yb(n) + yl(n-1);
F1 = 2*sin((pi*Fc(n))/Fs);
end

% Normalise
maxyb = max(abs(yb));
yb = yb/maxyb;

% write output wav files
wavwrite(yb, Fs, N, 'out_wah.wav');
%figure(1)
%hold on
%plot(x,'r');
%plot(yb,'b');
%title('Wah-wah and original Signal');

wavplay(yb, Fs); % Lecture du signal

         % Create time plot in proper axes
    t=0 : 1/Fs : (length(yb)-1)/Fs; % and get sampling frequency
    plot(handles.time_axes, t, x, 'b', t, yb, 'm');
    grid on;

       % Plot in frequency domain add the followings:
    n = length(yb)-1;
    f = 0 : handles.Fe/n : handles.Fe;
    afft = abs(fft(x));
    bfft = abs(fft(yb)); % Transformée de Fourier
    plot(handles.frequency_axes, f, afft, 'b', f, bfft, 'm'); % plot Fourier Transform
    grid on;





%_________________________________________________________________________________________________________________________________________________________________________________
% --- Executes on button press in pushbutton3: EFFET DYNAMIQUE (MODULATION
% EN AMPLITUDE)
% 
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[x , Fs , N] = wavread('ProjetElec');
t = 500;
% fréquence
fc = 1000;
Am1 = 0.1;
z = Am1 * cos(2* pi * fc * t);
b = x .* z;

wavplay(b,Fs);

% Create time plot in proper axes
t=0:1/handles.Fe:(length(b)-1)/Fs; % and get sampling frequency
plot(handles.time_axes, t, b); % graph it – try zooming while its up…not much visible until you do*/
grid on

% Plot in frequency domain add the followings:
n = length(b)-1;
f = 0 : handles.Fe/n : handles.Fe;
bfft = abs(fft(b)); % Transformée de Fourier
plot(handles.frequency_axes, f, bfft); % plot Fourier Transform
grid on

%_____________________________________________________________________________________________________________________________________________________________________
% --- Executes on button press in pushbutton4: AUCUN EFFET SONORE
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    c = 0.7;
    D = 1; % ecart entre le son et le son avec echo (en point echantillonage)
    b = zeros(1,10*D+1); % 10=N correspond au nombre d'echo souhaité
    b(1)= 1; % b est le numerateur
    b(end)= c;
    a = 1; % dénominateur 
    t= 1000000;
    wavplay(handles.x,handles.Fe); % Lecture du signal modulé

% Create time plot in proper axes
t=0:1/handles.Fe:(length(handles.x)-1)/handles.Fe; % and get sampling frequency
plot(handles.time_axes, t, handles.x); % graph it – try zooming while its up…not much visible until you do*/
grid on;

% Plot in frequency domain add the followings:
n = length(handles.x)-1;
f = 0 : handles.Fe/n : handles.Fe;
xfft =abs(fft(handles.x)); % perform Fourier Transform
plot(handles.frequency_axes, f, xfft); % plot Fourier Transform
grid on;

%_________________________________________________________________________________________________________________________________________________________________________
% --- Executes on selection change in menu.
    function menu_Callback(hObject, eventdata, handles)
    % hObject    handle to menu (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: contents = cellstr(get(hObject,'String')) returns menu contents as cell array
    %        contents{get(hObject,'Value')} returns selected item from menu


% --- Executes during object creation, after setting all properties.
    function menu_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to menu (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: popupmenu controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
