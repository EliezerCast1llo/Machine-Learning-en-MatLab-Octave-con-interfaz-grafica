function varargout = kmeans(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @kmeans_OpeningFcn, ...
                   'gui_OutputFcn',  @kmeans_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before kmeans is made visible.
function kmeans_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

% Update handles structure
set(handles.btnCalcular,'enable','off');
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = kmeans_OutputFcn(hObject, eventdata, handles)

varargout{1} = handles.output;


% --- Executes on button press in btnImprimir.
function btnImprimir_Callback(hObject, eventdata, handles)
estado = get(handles.rbPDF,'Value');
if estado==1
opciones = struct('catchError',true,'showCode',false,'evalCode',true,...
'useNewFigure',false,'format','pdf','outputDir','C:\Matlab\PDF',...
'createThumbnail',false, 'figureSnapMethod', 'print');
publish('printKM.m',opciones)
end  

estado = get(handles.rbDOC,'Value');
if estado==1
opciones = struct('catchError',true,'showCode',false,'evalCode',true,...
'useNewFigure',false,'format','doc','outputDir','C:\Matlab\DOC',...
'createThumbnail',false, 'figureSnapMethod', 'print');
publish('printKM.m',opciones)
end

% --- Executes on button press in btnCalcular.
function btnCalcular_Callback(hObject, eventdata, handles)
% Clustering Set #1 ---------------------------------------------------------------------

global nombre1;
global carpeta1; 

% Loading the data.
fprintf('Loading the data set #1...\n');
load(strcat(carpeta1,nombre1));

% Plotting the data.
fprintf('Plotting the data set #1...\n');
subplot(2, 3, 1);
plot(X(:, 1), X(:, 2), 'k+','LineWidth', 1, 'MarkerSize', 7);
title('Training Set #1');

% Training K-Means.
fprintf('Training K-Means for data set #1...\n');
K = 3; % Number of centroids.
max_iterations = 20; % How many iterations we will do to find optimal centroids positions.
[centroids, closest_centroids_ids] = k_means_train(X, K, max_iterations);

% Plotting clustered data.
fprintf('Plotting clustered data for data set #1...\n');
subplot(2, 3, 2);
for k=1:K
    % Plotting the cluster.
    cluster_x = X(closest_centroids_ids == k, :);
    plot(cluster_x(:, 1), cluster_x(:, 2), '+');
    hold on;

    % Plotting centroid.
    centroid = centroids(k, :);
    plot(centroid(:, 1), centroid(:, 2), 'ko', 'MarkerFaceColor', 'r', 'MarkerSize', 8);
    hold on;
end
title('Clustered Set #1');
hold off;

% Clustering Set #2 ---------------------------------------------------------------------

global nombre2;
global carpeta2;

% Loading the data.
fprintf('Loading the data set #2...\n');
load(strcat(carpeta2,nombre2));

% Plotting the data.
fprintf('Plotting the data set #2...\n');
subplot(2, 3, 4);
plot(X(:, 1), X(:, 2), 'k+','LineWidth', 1, 'MarkerSize', 7);
title('Training Set #2');

% Training K-Means.
fprintf('Training K-Means for data set #2...\n');
K = 3; % Number of centroids.
max_iterations = 20; % How many iterations we will do to find optimal centroids positions.
[centroids, closest_centroids_ids] = k_means_train(X, K, max_iterations);

% Plotting clustered data.
fprintf('Plotting clustered data for data set #2...\n');
subplot(2, 3, 5);
for k=1:K
    % Plotting the cluster.
    cluster_x = X(closest_centroids_ids == k, :);
    plot(cluster_x(:, 1), cluster_x(:, 2), '+');
    hold on;

    % Plotting centroid.
    centroid = centroids(k, :);
    plot(centroid(:, 1), centroid(:, 2), 'ko', 'MarkerFaceColor', 'r', 'MarkerSize', 8);
    hold on;
end
title('Clustered Set #2');
hold off;
set(handles.btnCalcular,'enable','off');

% --- Executes on button press in btnAbrir.
function btnAbrir_Callback(hObject, eventdata, handles)
global nombre1;
global carpeta1;
global nombre2;
global carpeta2;

[nombre1,carpeta1]=uigetfile('*.mat');
if isequal(nombre1,0)|| isequal(carpeta1,0)
    return;
else
    helpdlg(strcat(carpeta1,nombre1),'Primer segmento de archivos cargado');
    [nombre2,carpeta2]=uigetfile('*.mat');
if isequal(nombre2,0)|| isequal(carpeta2,0)
    return;
else
    helpdlg(strcat(carpeta2,nombre2),'Segundo segmento de archivos cargado');
    set(handles.btnCalcular,'enable','on');
end
  
end

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
kmeans';
