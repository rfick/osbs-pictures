function varargout = Sliders(varargin)
% SLIDERS MATLAB code for Sliders.fig
%      SLIDERS, by itself, creates a new SLIDERS or raises the existing
%      singleton*.
%
%      H = SLIDERS returns the handle to a new SLIDERS or the handle to
%      the existing singleton*.
%
%      SLIDERS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SLIDERS.M with the given input arguments.
%
%      SLIDERS('Property','Value',...) creates a new SLIDERS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Sliders_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Sliders_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Sliders

% Last Modified by GUIDE v2.5 11-Jan-2017 17:22:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Sliders_OpeningFcn, ...
                   'gui_OutputFcn',  @Sliders_OutputFcn, ...
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

end


% --- Executes just before Sliders is made visible.
function Sliders_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Sliders (see VARARGIN)


handles.dirprefix = 'FrameRemovedImages/';
listing = dir('FrameRemovedImages');

if ~exist('ControlFiles', 'dir')
    % Folder does not exist so create it.
    mkdir('ControlFiles');
end
handles.controlprefix = 'ControlFiles/';

if ~exist('ResultFiles', 'dir')
    % Folder does not exist so create it.
    mkdir('ResultFiles');
end
handles.resultprefix = 'ResultFiles/';

for i=size(listing):-1:1
    name = listing(i).name;
    if(size(name, 2)>3)
        if(strcmp(name(end-3:end), '.jpg')==1)
        else
            listing(i) = [];
        end
    else
        listing(i) = [];
    end
end

reloadstate = 0;

% Reload past state
if(exist(strcat(handles.controlprefix, 'permutation.txt'), 'file') == 2)
    reloadstate = 1;
end

% Reload past state
if(reloadstate == 1)
    fname = strcat(handles.controlprefix, 'permutation.txt');
    fileID = fopen(fname, 'r');
    p = fread(fileID);
    fclose(fileID);
end

if(reloadstate == 0)
    s = RandStream.getGlobalStream;
    p = randperm(s, length(listing));

    fname = strcat(handles.controlprefix, 'permutation.txt');
    fileID = fopen(fname, 'w');
    fwrite(fileID, p);
    fclose(fileID);
end

handles.listing = listing(p);

if(reloadstate == 0)
    handles.listingind = 1;
    currentimage = 0;
    for i=1:size(handles.listing)
        name = handles.listing(i).name;
        if(size(name, 2)>3)
            if(strcmp(name(end-3:end), '.jpg')==1)
                handles.listingind = i;
                currentimage = currentimage + 1;
                break;
            end
        end
    end
else
    fname = strcat(handles.controlprefix, 'listingind.txt');
    handles.listingind = str2double(textread(fname, '%s'));
    
    fname = strcat(handles.controlprefix, 'currentimage.txt');
    currentimage = str2double(textread(fname, '%s'));
end

numimages = 0;
for i=1:size(handles.listing)
    name = handles.listing(i).name;
    if(size(name, 2)>3)
        if(strcmp(name(end-3:end), '.jpg')==1)
            numimages = numimages + 1;
        end
    end
end

fname = strcat(handles.controlprefix, 'numimages.txt');
fileID = fopen(fname, 'w');
fprintf(fileID, '%d', numimages);
fclose(fileID);

fname = strcat(handles.controlprefix, 'currentimage.txt');
fileID = fopen(fname, 'w');
fprintf(fileID, '%d', currentimage);
fclose(fileID);

outputstring = sprintf('Image %d of %d', currentimage, numimages);

set(handles.edit10, 'String', outputstring);

fname = strcat(handles.controlprefix, 'listingind.txt');
fileID = fopen(fname, 'w');
fprintf(fileID, '%d', handles.listingind);
fclose(fileID);

filename = handles.listing(handles.listingind).name;

filename = strcat(handles.dirprefix, filename);

imshow(filename);

% Choose default command line output for Sliders
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Sliders wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end


% --- Outputs from this function are returned to the command line.
function varargout = Sliders_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end


%Turkey Oak
function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double

end


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

end

%Wiregrass
function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double

end


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end


%Litter
function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


end

% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end

%Submit
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

turkeyoak = get(handles.edit2, 'String');
turkeyoak = str2double(turkeyoak);
wiregrass = get(handles.edit4, 'String');
wiregrass = str2double(wiregrass);
litter = get(handles.edit5, 'String');
litter = str2double(litter);
sand = get(handles.edit6, 'String');
sand = str2double(sand);
other = get(handles.edit7, 'String');
other = str2double(other);

firstname = get(handles.edit8, 'String');
lastname = get(handles.edit9, 'String');

if(abs((turkeyoak+wiregrass+litter+sand+other) - 1) < 0.0001)
    userdata = [turkeyoak, wiregrass, litter, sand, other];
    fmt = '%f\t%f\t%f\t%f\t%f\t%s\n';

    fname = strcat(handles.controlprefix, 'listingind.txt');
    listingind = str2double(textread(fname, '%s'));

    listing = handles.listing;
    filename = listing(listingind).name;

    txtfilename = strcat(handles.resultprefix, firstname, '_', lastname, '.txt');

    fileID = fopen(txtfilename, 'a');
    fprintf(fileID, fmt, userdata, filename);

    fclose(fileID);
else
    h = msgbox('Proportions should sum to one. Please try again.', 'Error', 'error');
end

end

%Next
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fname = strcat(handles.controlprefix, 'listingind.txt');
listingind = str2double(textread(fname, '%s'));
fname = strcat(handles.controlprefix, 'numimages.txt');
numimages = str2double(textread(fname, '%s'));
fname = strcat(handles.controlprefix, 'currentimage.txt');
currentimage = str2double(textread(fname, '%s'));

listing = handles.listing;

if(listingind < length(listing))
    for i=listingind+1:length(listing)
        name = listing(i).name;
        if(size(name, 2)>3)
            if(strcmp(name(end-3:end), '.jpg')==1)
                listingind = i;
                currentimage = currentimage + 1;
                break;
            end
        end
    end
end

filename = listing(listingind).name;

filename = strcat(handles.dirprefix, filename);

imshow(filename);

outputstring = sprintf('Image %d of %d', currentimage, numimages);

set(handles.edit10, 'String', outputstring);

%Reset proportion inputs
set(handles.edit2, 'String', 'Please input');
set(handles.edit4, 'String', 'Please input');
set(handles.edit5, 'String', 'Please input');
set(handles.edit6, 'String', 'Please input');
set(handles.edit7, 'String', 'Please input');

fname = strcat(handles.controlprefix, 'listingind.txt');
fileID = fopen(fname, 'w');
fprintf(fileID, '%d', listingind);
fclose(fileID);

fname = strcat(handles.controlprefix, 'currentimage.txt');
fileID = fopen(fname, 'w');
fprintf(fileID, '%d', currentimage);
fclose(fileID);

end

%Prev
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fname = strcat(handles.controlprefix, 'listingind.txt');
listingind = str2double(textread(fname, '%s'));
fname = strcat(handles.controlprefix, 'numimages.txt');
numimages = str2double(textread(fname, '%s'));
fname = strcat(handles.controlprefix, 'currentimage.txt');
currentimage = str2double(textread(fname, '%s'));

listing = handles.listing;

if(listingind > 1)
    for i=listingind-1:-1:1
        name = listing(i).name;
        if(size(name, 2)>3)
            if(strcmp(name(end-3:end), '.jpg')==1)
                currentimage = currentimage - 1;
                listingind = i;
                break;
            end
        end
    end
end

filename = listing(listingind).name;

filename = strcat(handles.dirprefix, filename);

imshow(filename);

outputstring = sprintf('Image %d of %d', currentimage, numimages);

set(handles.edit10, 'String', outputstring);

%Reset proportion inputs
set(handles.edit2, 'String', 'Please input');
set(handles.edit4, 'String', 'Please input');
set(handles.edit5, 'String', 'Please input');
set(handles.edit6, 'String', 'Please input');
set(handles.edit7, 'String', 'Please input');

fname = strcat(handles.controlprefix, 'listingind.txt');
fileID = fopen(fname, 'w');
fprintf(fileID, '%d', listingind);
fclose(fileID);

fname = strcat(handles.controlprefix, 'currentimage.txt');
fileID = fopen(fname, 'w');
fprintf(fileID, '%d', currentimage);
fclose(fileID);

end


%Sand
function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double

end

% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end

%Other
function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double

end

% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end


%First Name
function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double

handles.firstname = get(hObject, 'String');

fname = strcat(handles.controlprefix, 'firstnamefile.txt');
fileID = fopen(fname, 'w');
fprintf(fileID, '%s', handles.firstname);

fclose(fileID);

end

% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end


%Last Name
function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double

handles.lastname = get(hObject, 'String');

fname = strcat(handles.controlprefix, 'lastnamefile.txt');
fileID = fopen(fname, 'w');
fprintf(fileID, '%s', handles.lastname);

fclose(fileID);

end

% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end


%Image Number
function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double



end


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end