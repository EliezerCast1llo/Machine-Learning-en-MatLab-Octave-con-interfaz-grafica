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

%dehabilitar boton calcular e imprimir
set(handles.btnCalcular,'enable','off');
set(handles.btnImprimir,'enable','off');
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = anomalydetection_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


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

%Carga de datos desde variable local 
global nombre;
global carpeta;
load(strcat(carpeta,nombre),'X','Xval','yval');

% Estimate mu and sigma2.
[mu sigma2] = estimate_gaussian(X);

% Visualize the fit.
visualize_fit(X,  mu, sigma2);
xlabel('Latency (ms)');
ylabel('Throughput (mb/s)');
title('Servers Parameters');

% Returns the density of the multivariate normal at each data point (row) of X.
probabilities = multivariate_gaussian(X, mu, sigma2);

% Select best threshold.
[epsilon F1] = select_threshold(yval, probabilities);

%Cambio repositorio original
%Llenando labels de GUI 
set(handles.lblEpsilon,'String',epsilon);
set(handles.lblF1,'String',F1);

% Plottin outliers.
%  Find the outliers in the training set and plot them.
outliers = find(probabilities < epsilon);

%  Draw a red circle around those outliers
hold on;
plot(X(outliers, 1), X(outliers, 2), 'ro', 'LineWidth', 2, 'MarkerSize', 10);
legend('Training set', 'Gaussian contour', 'Anomalies');

%habilitando boton imprimir y deshabilitando boton calcular
set(handles.btnCalcular,'enable','off');
set(handles.btnImprimir,'enable','on');

%guardando datos en archivo .mat para impresion de PFD o DOC
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
