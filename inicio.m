function varargout = inicio(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @inicio_OpeningFcn, ...
                   'gui_OutputFcn',  @inicio_OutputFcn, ...
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


% --- Executes just before inicio is made visible.
function inicio_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

function varargout = inicio_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


% --- Executes on button press in btnRegresionL.
function btnRegresionL_Callback(hObject, eventdata, handles)
cd linear-regression/
clear all;
close all;
clc;
linearregression';


% --- Executes on button press in btnRegresionLogic.
function btnRegresionLogic_Callback(hObject, eventdata, handles)
cd logistic-regression/
clear all;
close all;
clc;
seleccionalgoritmo';


% --- Executes on button press in btnDeteccionAnoma.
function btnDeteccionAnoma_Callback(hObject, eventdata, handles)
cd anomaly-detection/
clear all;
close all;
clc;
anomalydetection';


% --- Executes on button press in btnRedNeuro.
function btnRedNeuro_Callback(hObject, eventdata, handles)
cd neural-network/
clear all;
close all;
clc;
RedNeuronal';


% --- Executes on button press in btnKMeans.
function btnKMeans_Callback(hObject, eventdata, handles)
cd k-means/
clear all;
close all;
clc;
kmeans';
