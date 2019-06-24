function varargout = linearregression(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @linearregression_OpeningFcn, ...
                   'gui_OutputFcn',  @linearregression_OutputFcn, ...
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


% --- Executes just before linearregression is made visible.
function linearregression_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for linearregression
handles.output = hObject;

% Update handles structure
set(handles.btnCalcular,'enable','off');
guidata(hObject, handles);

% UIWAIT makes linearregression wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = linearregression_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnImprimir.
function btnImprimir_Callback(hObject, eventdata, handles)
estado = get(handles.rbPDF,'Value');
if estado==1
opciones = struct('catchError',true,'showCode',false,'evalCode',true,...
'useNewFigure',false,'format','pdf','outputDir','C:\Matlab\PDF',...
'createThumbnail',false, 'figureSnapMethod', 'print');
publish('printLR.m',opciones)
end  

estado = get(handles.rbDOC,'Value');
if estado==1
opciones = struct('catchError',true,'showCode',false,'evalCode',true,...
'useNewFigure',false,'format','doc','outputDir','C:\Matlab\DOC',...
'createThumbnail',false, 'figureSnapMethod', 'print');
publish('printLR.m',opciones)
end


% --- Executes on button press in btnCalcular.
function btnCalcular_Callback(hObject, eventdata, handles)
% Loading training data from file ----------------------------------------------
fprintf('Loading the training data from file...\n\n');

% Loading training data from file.

global carpeta;
global nombre;

data = load(strcat(carpeta,nombre));

% Loading training data from file ----------------------------------------------
fprintf('Loading the training data from file...\n\n');

% Split data into features and results.
X = data(:, 1:2);
y = data(:, 3);

% Plotting training data -------------------------------------------------------
fprintf('Plotting the training data...\n\n');

% Split the figure on 2x2 sectors.
% Start drawing in first sector.

hold on
subplot(2, 2, 1);
scatter3(X(:, 1), X(:, 2), y, [], y(:), 'o');
title('Training Set');
xlabel('Size');
ylabel('Rooms');
zlabel('Price');
hold off

% Running linear regression ----------------------------------------------------
fprintf('Running linear regression...\n');

% Setup regularization parameter.
lambda = 0;

alpha = 0.1;
num_iterations = 50;
[theta mu sigma X_normalized J_history] = linear_regression_train(X, y, alpha, lambda, num_iterations);

fprintf('- Initial cost: %f\n', J_history(1));
fprintf('- Optimized cost: %f\n', J_history(end));

fprintf('- Theta (with normalization):\n');
fprintf('-- %f\n', theta);
fprintf('\n');

% Calculate model parameters using normal equation -----------------------------
fprintf('Calculate model parameters using normal equation...\n');

X_normal = [ones(size(X, 1), 1) X];
theta_normal = normal_equation(X_normal, y);
normal_cost = cost_function(X_normal, y, theta_normal, lambda);

fprintf('- Normal function cost: %f\n', normal_cost);

fprintf('- Theta (without normalization):\n');
fprintf('-- %f\n', theta_normal);
fprintf('\n');

% Plotting normalized training data --------------------------------------------
fprintf('Plotting normalized training data...\n\n');

% Start drawing in second sector.

hold on
subplot(2, 2, 2);
scatter3(X_normalized(:, 2), X_normalized(:, 3), y, [], y(:), 'o');
title('Normalized Training Set');
xlabel('Normalized Size');
ylabel('Normalized Rooms');
zlabel('Price');
hold off

% Draw gradient descent progress ------------------------------------------------
fprintf('Plot gradient descent progress...\n\n');

% Continue plotting to the right area.

hold on
subplot(2, 2, 3);
plot(1:num_iterations, J_history);
xlabel('Iteration');
ylabel('J(\theta)');
title('Gradient Descent Progress');
hold off


% Plotting hypothesis plane on top of training set -----------------------------
fprintf('Plotting hypothesis plane on top of training set...\n\n');

% Get apartment size and rooms boundaries.
apt_sizes = X_normalized(:, 2);
apt_rooms = X_normalized(:, 3);
apt_size_range = linspace(min(apt_sizes), max(apt_sizes), 10);
apt_rooms_range = linspace(min(apt_rooms), max(apt_rooms), 10);

% Calculate predictions for each possible combination of rooms number and appartment size.
apt_prices = zeros(length(apt_size_range), length(apt_rooms_range));
for apt_size_index = 1:length(apt_size_range)
    for apt_room_index = 1:length(apt_rooms_range)
        X = [1, apt_size_range(apt_size_index), apt_rooms_range(apt_room_index)];
        apt_prices(apt_size_index, apt_room_index) = hypothesis(X, theta);
    end
end

% Plot the plane on top of training data to see how it feets them.

hold on
subplot(2, 2, 2);
mesh(apt_size_range, apt_rooms_range, apt_prices);
legend('Training Examples', 'Hypothesis Plane')
hold off;
set(handles.btnCalcular,'enable','off');
set(handles.lblInitialCost,'String',J_history(1));
set(handles.lblOptimized,'String',J_history(end));
set(handles.lblNormalFunction,'String',normal_cost);


% --- Executes on button press in btnAbrir.
function btnAbrir_Callback(hObject, eventdata, handles)
global nombre;
global carpeta;
[nombre,carpeta]=uigetfile('*.csv');
if isequal(nombre,0)|| isequal(carpeta,0)
    return;
else
    helpdlg(strcat(carpeta,nombre),'Archivos cargado correctamente');
    set(handles.btnCalcular,'enable','on');
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
linearregression';
