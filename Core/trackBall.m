function varargout = trackBall(varargin)
% TRACKBALL MATLAB code for trackBall.fig
%      TRACKBALL, by itself, creates a new TRACKBALL or raises the existing
%      singleton*.
%
%      H = TRACKBALL returns the handle to a new TRACKBALL or the handle to
%      the existing singleton*.
%
%      TRACKBALL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRACKBALL.M with the given input arguments.
%
%      TRACKBALL('Property','Value',...) creates a new TRACKBALL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before trackBall_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to trackBall_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help trackBall

% Last Modified by GUIDE v2.5 04-Jan-2020 23:18:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @trackBall_OpeningFcn, ...
                   'gui_OutputFcn',  @trackBall_OutputFcn, ...
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


% --- Executes just before trackBall is made visible.
function trackBall_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to trackBall (see VARARGIN)


set(hObject,'WindowButtonDownFcn',{@my_MouseClickFcn,handles.axes1});
set(hObject,'WindowButtonUpFcn',{@my_MouseReleaseFcn,handles.axes1});
axes(handles.axes1);

handles.Cube=DrawCube(eye(3));

set(handles.axes1,'CameraPosition',...
    [0 0 5],'CameraTarget',...
    [0 0 -5],'CameraUpVector',...
    [0 1 0],'DataAspectRatio',...
    [1 1 1]);

set(handles.axes1,'xlim',[-3 3],'ylim',[-3 3],'visible','off','color','none');

% Choose default command line output for trackBall
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes trackBall wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = trackBall_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function my_MouseClickFcn(obj,event,hObject)

handles=guidata(obj);
xlim = get(handles.axes1,'xlim');
ylim = get(handles.axes1,'ylim');
mousepos=get(handles.axes1,'CurrentPoint');
xmouse = mousepos(1,1);
ymouse = mousepos(1,2);

if xmouse > xlim(1) && xmouse < xlim(2) && ymouse > ylim(1) && ymouse < ylim(2)

    set(handles.figure1,'WindowButtonMotionFcn',{@my_MouseMoveFcn,hObject});
end
guidata(hObject,handles)

function my_MouseReleaseFcn(obj,event,hObject)
handles=guidata(hObject);
set(handles.figure1,'WindowButtonMotionFcn','');
guidata(hObject,handles);

function my_MouseMoveFcn(obj,event,hObject)

handles=guidata(obj);
xlim = get(handles.axes1,'xlim');
ylim = get(handles.axes1,'ylim');
mousepos=get(handles.axes1,'CurrentPoint');
xmouse = mousepos(1,1);
ymouse = mousepos(1,2);

if xmouse > xlim(1) && xmouse < xlim(2) && ymouse > ylim(1) && ymouse < ylim(2)

    %%% DO things
    % use with the proper R matrix to rotate the cube
    R = [1 0 0; 0 -1 0;0 0 -1];
    handles.Cube = RedrawCube(R,handles.Cube);
    
end
guidata(hObject,handles);

function h = DrawCube(R)

M0 = [    -1  -1 1;   %Node 1
    -1   1 1;   %Node 2
    1   1 1;   %Node 3
    1  -1 1;   %Node 4
    -1  -1 -1;  %Node 5
    -1   1 -1;  %Node 6
    1   1 -1;  %Node 7
    1  -1 -1]; %Node 8

M = (R*M0')';


x = M(:,1);
y = M(:,2);
z = M(:,3);


con = [1 2 3 4;
    5 6 7 8;
    4 3 7 8;
    1 2 6 5;
    1 4 8 5;
    2 3 7 6]';

x = reshape(x(con(:)),[4,6]);
y = reshape(y(con(:)),[4,6]);
z = reshape(z(con(:)),[4,6]);

c = 1/255*[255 248 88;
    0 0 0;
    57 183 225;
    57 183 0;
    255 178 0;
    255 0 0];

h = fill3(x,y,z, 1:6);

for q = 1:length(c)
    h(q).FaceColor = c(q,:);
end

function h = RedrawCube(R,hin)

h = hin;
c = 1/255*[255 248 88;
    0 0 0;
    57 183 225;
    57 183 0;
    255 178 0;
    255 0 0];

M0 = [    -1  -1 1;   %Node 1
    -1   1 1;   %Node 2
    1   1 1;   %Node 3
    1  -1 1;   %Node 4
    -1  -1 -1;  %Node 5
    -1   1 -1;  %Node 6
    1   1 -1;  %Node 7
    1  -1 -1]; %Node 8

M = (R*M0')';


x = M(:,1);
y = M(:,2);
z = M(:,3);


con = [1 2 3 4;
    5 6 7 8;
    4 3 7 8;
    1 2 6 5;
    1 4 8 5;
    2 3 7 6]';

x = reshape(x(con(:)),[4,6]);
y = reshape(y(con(:)),[4,6]);
z = reshape(z(con(:)),[4,6]);

for q = 1:6
    h(q).Vertices = [x(:,q) y(:,q) z(:,q)];
    h(q).FaceColor = c(q,:);
end


% --- Executes on button press in QuaternionUpdateButton.
function QuaternionUpdateButton_Callback(hObject, eventdata, handles)
% hObject    handle to QuaternionUpdateButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
q=[0;0;0;0];
q(1)=str2double(get(handles.q0Edit,'String'));
q(2)=str2double(get(handles.q1Edit,'String'));
q(3)=str2double(get(handles.q2Edit,'String'));
q(4)=str2double(get(handles.q3Edit,'String'));
[axis,angle]=QuaternionToEulerAxis(q);
rotvec=EulerAxisToRotationVector(axis,angle);
R=EulerAxisToRotationMatrix(axis,angle);
[roll,pitch,yaw]=RotationMatrixToEulerAngles(R);
set(handles.RVvxEdit, 'String', num2str(rotvec(1)));
set(handles.RVvyEdit, 'String', num2str(rotvec(2)));
set(handles.RVvzEdit, 'String', num2str(rotvec(3)));
set(handles.EArollEdit, 'String', num2str(roll));
set(handles.EApitchEdit, 'String', num2str(pitch));
set(handles.EAyawEdit, 'String', num2str(yaw));
set(handles.EPAngleEdit, 'String', num2str(angle));
set(handles.EPvxEdit, 'String', num2str(axis(1)));
set(handles.EPvyEdit, 'String', num2str(axis(2)));
set(handles.EPvzEdit, 'String', num2str(axis(3)));
set(handles.RM11, 'String', num2str(R(1,1)));
set(handles.RM12, 'String', num2str(R(1,2)));
set(handles.RM13, 'String', num2str(R(1,3)));
set(handles.RM21, 'String', num2str(R(2,1)));
set(handles.RM22, 'String', num2str(R(2,2)));
set(handles.RM23, 'String', num2str(R(2,3)));
set(handles.RM31, 'String', num2str(R(3,1)));
set(handles.RM32, 'String', num2str(R(3,2)));
set(handles.RM33, 'String', num2str(R(3,3)));
handles.Cube = RedrawCube(R,handles.Cube);



function q0Edit_Callback(hObject, eventdata, handles)
% hObject    handle to q0Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q0Edit as text
%        str2double(get(hObject,'String')) returns contents of q0Edit as a double


% --- Executes during object creation, after setting all properties.
function q0Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q0Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q1Edit_Callback(hObject, eventdata, handles)
% hObject    handle to q1Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q1Edit as text
%        str2double(get(hObject,'String')) returns contents of q1Edit as a double


% --- Executes during object creation, after setting all properties.
function q1Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q1Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q2Edit_Callback(hObject, eventdata, handles)
% hObject    handle to q2Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q2Edit as text
%        str2double(get(hObject,'String')) returns contents of q2Edit as a double


% --- Executes during object creation, after setting all properties.
function q2Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q2Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q3Edit_Callback(hObject, eventdata, handles)
% hObject    handle to q3Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q3Edit as text
%        str2double(get(hObject,'String')) returns contents of q3Edit as a double


% --- Executes during object creation, after setting all properties.
function q3Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q3Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ResetButton.
function ResetButton_Callback(hObject, eventdata, handles)
% hObject    handle to ResetButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
q=[0;0;0;0];
rotvec=[0;0;0];
roll=0;
pitch=0;
yaw=0;
set(handles.q0Edit, 'String', num2str(q(1)));
set(handles.q1Edit, 'String', num2str(q(2)));
set(handles.q2Edit, 'String', num2str(q(3)));
set(handles.q3Edit, 'String', num2str(q(4)));
set(handles.RVvxEdit, 'String', num2str(rotvec(1)));
set(handles.RVvyEdit, 'String', num2str(rotvec(2)));
set(handles.RVvzEdit, 'String', num2str(rotvec(3)));
set(handles.EArollEdit, 'String', num2str(roll));
set(handles.EApitchEdit, 'String', num2str(pitch));
set(handles.EAyawEdit, 'String', num2str(yaw));
angle=0;
axis=[0;0;0];
set(handles.EPAngleEdit, 'String', num2str(angle));
set(handles.EPvxEdit, 'String', num2str(axis(1)));
set(handles.EPvyEdit, 'String', num2str(axis(2)));
set(handles.EPvzEdit, 'String', num2str(axis(3)));
R=eye(3);
set(handles.RM11, 'String', num2str(R(1,1)));
set(handles.RM12, 'String', num2str(R(1,2)));
set(handles.RM13, 'String', num2str(R(1,3)));
set(handles.RM21, 'String', num2str(R(2,1)));
set(handles.RM22, 'String', num2str(R(2,2)));
set(handles.RM23, 'String', num2str(R(2,3)));
set(handles.RM31, 'String', num2str(R(3,1)));
set(handles.RM32, 'String', num2str(R(3,2)));
set(handles.RM33, 'String', num2str(R(3,3)));
handles.Cube=RedrawCube(R, handles.Cube);



% --- Executes on button press in RotationVectorUpdateButton.
function RotationVectorUpdateButton_Callback(hObject, eventdata, handles)
% hObject    handle to RotationVectorUpdateButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rotvec=[0;0;0];
rotvec(1)=str2double(get(handles.RVvxEdit,'String'));
rotvec(2)=str2double(get(handles.RVvyEdit,'String'));
rotvec(3)=str2double(get(handles.RVvzEdit,'String'));
[axis,angle]=RotationVectorToEulerAxis(rotvec);
q=EulerAxisToQuaternion(axis,angle);
R=EulerAxisToRotationMatrix(axis,angle);
[roll,pitch,yaw]=RotationMatrixToEulerAngles(R);
set(handles.q0Edit, 'String', num2str(q(1)));
set(handles.q1Edit, 'String', num2str(q(2)));
set(handles.q2Edit, 'String', num2str(q(3)));
set(handles.q3Edit, 'String', num2str(q(4)));
set(handles.EArollEdit, 'String', num2str(roll));
set(handles.EApitchEdit, 'String', num2str(pitch));
set(handles.EAyawEdit, 'String', num2str(yaw));
set(handles.EPAngleEdit, 'String', num2str(angle));
set(handles.EPvxEdit, 'String', num2str(axis(1)));
set(handles.EPvyEdit, 'String', num2str(axis(2)));
set(handles.EPvzEdit, 'String', num2str(axis(3)));
set(handles.RM11, 'String', num2str(R(1,1)));
set(handles.RM12, 'String', num2str(R(1,2)));
set(handles.RM13, 'String', num2str(R(1,3)));
set(handles.RM21, 'String', num2str(R(2,1)));
set(handles.RM22, 'String', num2str(R(2,2)));
set(handles.RM23, 'String', num2str(R(2,3)));
set(handles.RM31, 'String', num2str(R(3,1)));
set(handles.RM32, 'String', num2str(R(3,2)));
set(handles.RM33, 'String', num2str(R(3,3)));
handles.Cube = RedrawCube(R,handles.Cube);


function RVvxEdit_Callback(hObject, eventdata, handles)
% hObject    handle to RVvxEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RVvxEdit as text
%        str2double(get(hObject,'String')) returns contents of RVvxEdit as a double


% --- Executes during object creation, after setting all properties.
function RVvxEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RVvxEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RVvyEdit_Callback(hObject, eventdata, handles)
% hObject    handle to RVvyEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RVvyEdit as text
%        str2double(get(hObject,'String')) returns contents of RVvyEdit as a double


% --- Executes during object creation, after setting all properties.
function RVvyEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RVvyEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RVvzEdit_Callback(hObject, eventdata, handles)
% hObject    handle to RVvzEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RVvzEdit as text
%        str2double(get(hObject,'String')) returns contents of RVvzEdit as a double


% --- Executes during object creation, after setting all properties.
function RVvzEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RVvzEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in EulerPrincipalUpdateButton.
function EulerPrincipalUpdateButton_Callback(hObject, eventdata, handles)
% hObject    handle to EulerPrincipalUpdateButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axis=[0;0;0];
angle=str2double(get(handles.EPAngleEdit,'String'));
axis(1)=str2double(get(handles.EPvxEdit,'String'));
axis(2)=str2double(get(handles.EPvyEdit,'String'));
axis(3)=str2double(get(handles.EPvzEdit,'String'));
q=EulerAxisToQuaternion(axis,angle);
rotvec=EulerAxisToRotationVector(axis,angle);
R=EulerAxisToRotationMatrix(axis,angle);
[roll,pitch,yaw]=RotationMatrixToEulerAngles(R);
set(handles.q0Edit, 'String', num2str(q(1)));
set(handles.q1Edit, 'String', num2str(q(2)));
set(handles.q2Edit, 'String', num2str(q(3)));
set(handles.q3Edit, 'String', num2str(q(4)));
set(handles.RVvxEdit, 'String', num2str(rotvec(1)));
set(handles.RVvyEdit, 'String', num2str(rotvec(2)));
set(handles.RVvzEdit, 'String', num2str(rotvec(3)));
set(handles.EArollEdit, 'String', num2str(roll));
set(handles.EApitchEdit, 'String', num2str(pitch));
set(handles.EAyawEdit, 'String', num2str(yaw));
set(handles.EPAngleEdit, 'String', num2str(angle));
set(handles.EPvxEdit, 'String', num2str(axis(1)));
set(handles.EPvyEdit, 'String', num2str(axis(2)));
set(handles.EPvzEdit, 'String', num2str(axis(3)));
set(handles.RM11, 'String', num2str(R(1,1)));
set(handles.RM12, 'String', num2str(R(1,2)));
set(handles.RM13, 'String', num2str(R(1,3)));
set(handles.RM21, 'String', num2str(R(2,1)));
set(handles.RM22, 'String', num2str(R(2,2)));
set(handles.RM23, 'String', num2str(R(2,3)));
set(handles.RM31, 'String', num2str(R(3,1)));
set(handles.RM32, 'String', num2str(R(3,2)));
set(handles.RM33, 'String', num2str(R(3,3)));
handles.Cube = RedrawCube(R,handles.Cube);


function EPAngleEdit_Callback(hObject, eventdata, handles)
% hObject    handle to EPAngleEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EPAngleEdit as text
%        str2double(get(hObject,'String')) returns contents of EPAngleEdit as a double


% --- Executes during object creation, after setting all properties.
function EPAngleEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EPAngleEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EPvxEdit_Callback(hObject, eventdata, handles)
% hObject    handle to EPvxEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EPvxEdit as text
%        str2double(get(hObject,'String')) returns contents of EPvxEdit as a double


% --- Executes during object creation, after setting all properties.
function EPvxEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EPvxEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EPvyEdit_Callback(hObject, eventdata, handles)
% hObject    handle to EPvyEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EPvyEdit as text
%        str2double(get(hObject,'String')) returns contents of EPvyEdit as a double


% --- Executes during object creation, after setting all properties.
function EPvyEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EPvyEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EPvzEdit_Callback(hObject, eventdata, handles)
% hObject    handle to EPvzEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EPvzEdit as text
%        str2double(get(hObject,'String')) returns contents of EPvzEdit as a double


% --- Executes during object creation, after setting all properties.
function EPvzEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EPvzEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EArollEdit_Callback(hObject, eventdata, handles)
% hObject    handle to EArollEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EArollEdit as text
%        str2double(get(hObject,'String')) returns contents of EArollEdit as a double


% --- Executes during object creation, after setting all properties.
function EArollEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EArollEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EApitchEdit_Callback(hObject, eventdata, handles)
% hObject    handle to EApitchEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EApitchEdit as text
%        str2double(get(hObject,'String')) returns contents of EApitchEdit as a double


% --- Executes during object creation, after setting all properties.
function EApitchEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EApitchEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EAyawEdit_Callback(hObject, eventdata, handles)
% hObject    handle to EAyawEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EAyawEdit as text
%        str2double(get(hObject,'String')) returns contents of EAyawEdit as a double


% --- Executes during object creation, after setting all properties.
function EAyawEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EAyawEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in EulerAnglesUpdateButton.
function EulerAnglesUpdateButton_Callback(hObject, eventdata, handles)
% hObject    handle to EulerAnglesUpdateButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
roll=str2double(get(handles.EArollEdit,'String'));
pitch=str2double(get(handles.EApitchEdit,'String'));
yaw=str2double(get(handles.EAyawEdit,'String'));
R=EulerAnglesToRotationMatrix(roll,pitch,yaw);
[axis,angle]=RotationMatrixToEulerAxis(R);
rotvec=EulerAxisToRotationVector(axis,angle);
q=EulerAxisToQuaternion(axis,angle);
set(handles.q0Edit, 'String', num2str(q(1)));
set(handles.q1Edit, 'String', num2str(q(2)));
set(handles.q2Edit, 'String', num2str(q(3)));
set(handles.q3Edit, 'String', num2str(q(4)));
set(handles.RVvxEdit, 'String', num2str(rotvec(1)));
set(handles.RVvyEdit, 'String', num2str(rotvec(2)));
set(handles.RVvzEdit, 'String', num2str(rotvec(3)));
set(handles.EPAngleEdit, 'String', num2str(angle));
set(handles.EPvxEdit, 'String', num2str(axis(1)));
set(handles.EPvyEdit, 'String', num2str(axis(2)));
set(handles.EPvzEdit, 'String', num2str(axis(3)));
set(handles.RM11, 'String', num2str(R(1,1)));
set(handles.RM12, 'String', num2str(R(1,2)));
set(handles.RM13, 'String', num2str(R(1,3)));
set(handles.RM21, 'String', num2str(R(2,1)));
set(handles.RM22, 'String', num2str(R(2,2)));
set(handles.RM23, 'String', num2str(R(2,3)));
set(handles.RM31, 'String', num2str(R(3,1)));
set(handles.RM32, 'String', num2str(R(3,2)));
set(handles.RM33, 'String', num2str(R(3,3)));
handles.Cube = RedrawCube(R,handles.Cube);
