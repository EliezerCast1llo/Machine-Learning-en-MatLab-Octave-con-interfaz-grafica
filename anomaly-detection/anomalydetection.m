function varargout = anomalydetection(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @anomalydetection_OpeningFcn, ...
                   'gui_OutputFcn',  @anomalydetection_OutputFcn, ...
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


% --- Executes just before anomalydetection is made visible.
function anomalydetection_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% Update handles structure

set(handles.btnCalcular,'enable','off');
set(handles.btnImprimir,'enable','off');
guidata(hObject, handles);

% UIWAIT makes anomalydetection wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = anomalydetection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function etRuta_Callback(hObject, eventdata, handles)
% hObject    handle to etRuta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of etRuta as text
%        str2double(get(hObject,'String')) returns contents of etRuta as a double


% --- Executes during object creation, after setting all properties.
function etRuta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to etRuta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnAbrir.
function btnAbrir_Callback(hObject, eventdata, handles)
global nombre;
global carpeta;
[nombre,carpeta]=uigetfile('*.mat');
if isequal(nombre,0)|| isequal(carpeta,0)
    return;
else
    helpdlg(strcat(carpeta,nombre),'Archivos cargado correctamente');
    set(handles.btnCalcular,'enable','on');
end


% --- Executes on button press in btnImprimir.
function btnImprimir_Callback(hObject, eventdata, handles)
estado = get(handles.rbPDF,'Value');
if estado==1
opciones = struct('catchError',true,'showCode',false,'evalCode',true,...
'useNewFigure',false,'format','pdf','outputDir','C:\Matlab\PDF',...
'createThumbnail',false, 'figureSnapMethod', 'print');
publish('printAD.m',opciones)
end  

estado = get(handles.rbDOC,'Value');
if estado==1
opciones = struct('catchError',true,'showCode',false,'evalCode',true,...
'useNewFigure',false,'format','doc','outputDir','C:\Matlab\DOC',...
'createThumbnail',false, 'figureSnapMethod', 'print');
publish('printAD.m',opciones)
end

% --- Executes on button press in btnCalcular.
function btnCalcular_Callback(hObject, eventdata, handles)

fprintf('Loading data...\n');
%Carga de datos desde variable local 
global nombre;
global carpeta;
load(strcat(carpeta,nombre),'X','Xval','yval');

% Estimate mu and sigma2.
fprintf('Estimating mu and sigma2...\n');
[mu sigma2] = estimate_gaussian(X);

% Visualize the fit.
fprintf('Visualizing data and Gaussian distribution...\n');
visualize_fit(X,  mu, sigma2);
xlabel('Latency (ms)');
ylabel('Throughput (mb/s)');
title('Servers Parameters');

% Returns the density of the multivariate normal at each data point (row) of X.
probabilities = multivariate_gaussian(X, mu, sigma2);

% Select best threshold.
fprintf('Selecting a best threshold...\n');
[epsilon F1] = select_threshold(yval, probabilities);
fprintf('Best epsilon found using cross-validation: %e\n', epsilon);
fprintf('Best F1 on Cross Validation Set:  %f\n', F1);

%Cambio repositorio original
%Llenando labels de GUI 
set(handles.lblEpsilon,'String',epsilon);
set(handles.lblF1,'String',F1);

% Plottin outliers.
fprintf('Plottin outliers...\n');

%  Find the outliers in the training set and plot them.
outliers = find(probabilities < epsilon);

%  Draw a red circle around those outliers
hold on;
plot(X(outliers, 1), X(outliers, 2), 'ro', 'LineWidth', 2, 'MarkerSize', 10);
legend('Training set', 'Gaussian contour', 'Anomalies');
set(handles.btnCalcular,'enable','off');
set(handles.btnImprimir,'enable','on');
save C:\Matlab\Data\VarAnomalyDetection.mat X Xval yval epsilon F1



% --- Executes on button press in btnAtras.
function btnAtras_Callback(hObject, eventdata, handles)
cd ../
clear all;
close all;
clc;
inicio';


% --- Executes on button press in btnReset.
function btnReset_Callback(hObject, eventdata, handles)
clear all;
close all;
clc;
anomalydetection';
