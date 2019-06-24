function varargout = RedNeuronal(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RedNeuronal_OpeningFcn, ...
                   'gui_OutputFcn',  @RedNeuronal_OutputFcn, ...
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


% --- Executes just before RedNeuronal is made visible.
function RedNeuronal_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

% Update handles structure

set(handles.btnCalcular,'enable','off');
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = RedNeuronal_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


% --- Executes on button press in btnCalcular.
function btnCalcular_Callback(hObject, eventdata, handles)
% Load training data ----------------------------------------------------------------
fprintf('Loading data...\n');

global carpeta
global nombre

load(strcat(carpeta,nombre));
m = size(X, 1);

% Plotting some training example ----------------------------------------------------
fprintf('Visualizing data...\n');

% Randomly select 100 data points to display
random_digits_indices = randperm(size(X, 1));
random_digits_indices = random_digits_indices(1:100);

display_data(X(random_digits_indices, :));

% Debug neural network --------------------------------------------------------------

% Check gradients with lambda = 0.
% lambda = 0;
% debug_nn_gradients(lambda);
% fprintf('\nProgram paused. Press enter to continue.\n');
% pause;

% Check gradients with lambda = 3.
% lambda = 3;
% debug_nn_gradients(lambda);
% fprintf('\nProgram paused. Press enter to continue.\n');
% pause;

% Initializing neural network parameters --------------------------------------------
fprintf('Initializing neural network parameters...\n');

% Setup neural network parameter.
layers = [
    400,    % Input layer - 20x20 Input images of digits.
    25,     % First hidden layer - 25 hidden units.
%   15,     % Second hidden layer - 10 hidden units.
    10      % Output layer - 10 labels, from 1 to 10 (note that we have mapped "0" to label 10).
];

% Training neural network -----------------------------------------------------------
fprintf('Training neural network...\n');

% Defines the range for initial theta values.
epsilon = 0.12;

% Regularization parameter.
lambda = 0.01;

% Number of iterations to perform for gradient descent.
max_iterations = 30;

% Train neural network.
[nn_params, cost] = neural_network_train(X, y, layers, lambda, epsilon, max_iterations);

% Calculate training set accuracy ---------------------------------------------------
fprintf('Calculate training set accuracy...\n');

% After training the neural network, we would like to use it to predict the labels.
predictions = neural_network_predict(X, nn_params, layers);

fprintf('Training Set Accuracy: %f\n', mean(double(predictions == y)) * 100);
set(handles.lblTraining,'String', mean(double(predictions == y)) * 100);



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

% --- Executes on button press in btnAtras.
function btnAtras_Callback(hObject, eventdata, handles)
cd ../
clear all;
close all;
clc;
inicio';


% --- Executes on button press in btnReset.
function btnReset_Callback(hObject, eventdata, handles)
cd ../
clear all;
close all;
clc;
RedNeuronal';