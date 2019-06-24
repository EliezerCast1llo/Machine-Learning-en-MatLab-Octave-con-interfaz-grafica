function varargout = regresionlogistica2(varargin)
% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @regresionlogistica2_OpeningFcn, ...
                   'gui_OutputFcn',  @regresionlogistica2_OutputFcn, ...
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


% --- Executes just before regresionlogistica2 is made visible.
function regresionlogistica2_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

set(handles.btnCalcular,'enable','off');
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = regresionlogistica2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnCalcular.
function btnCalcular_Callback(hObject, eventdata, handles)
global nombre;
global carpeta;
load(strcat(carpeta,nombre));

% Plotting some training example ----------------------------------------------------
fprintf('Visualizing data...\n');

% Randomly select 100 data points to display
random_digits_indices = randperm(size(X, 1));
random_digits_indices = random_digits_indices(1:100);

display_data(X(random_digits_indices, :));

% Setup the parameters you will use for this part of the exercise
input_layer_size = 400;  % 20x20 input images of digits.
num_labels = 10; % 10 labels, from 1 to 10 (note that we have mapped "0" to label 10).

fprintf('Training One-vs-All Logistic Regression...\n')
lambda = 0.01;
num_iterations = 50;
[all_theta] = one_vs_all(X, y, num_labels, lambda, num_iterations);

fprintf('Predict for One-Vs-All...\n')
pred = one_vs_all_predict(all_theta, X);

fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);
set(handles.lblTraining,'String',mean(double(pred == y)) * 100);


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
clear all;
close all;
clc;
regresionlogistica2';
