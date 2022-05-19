function varargout = ssl_gui_1(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ssl_gui_1_OpeningFcn, ...
    'gui_OutputFcn',  @ssl_gui_1_OutputFcn, ...
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

% --- Executes just before ssl_gui_1 is made visible.
function ssl_gui_1_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
handles.data.inp='0';
handles.data.inp2='0';
handles.data.oup='0';
handles.data.motif='0';
handles.data.choose_ssl=0;
handles.data.sel=1;
handles.data.column=3;
handles.data.smooth=0.1;
handles.data.MismPeakDiffPerc=25;
handles.data.FlankPeakDiffPerc=50;
handles.data.ring_start=0;
handles.data.ring_stop=-1;
handles.data.disel=0;
set(handles.ssl_radio,'value',1)
set(handles.disel_radio,'value',0)
set(handles.inp2_push,'Enable','off')
set(handles.inp_text2,'Enable','off')
set(handles.fix_text_inp2,'Enable','off')

set(handles.fix_text_inp, 'Tooltipstring',...
    sprintf(['Input File 1\n' ...
    'Column 1: Sequence\nColumn 2:' ...
    ' Reverse complement\nColumn 3: Binding data']));
set(handles.fix_text_inp2, 'Tooltipstring',...
    sprintf(['Input File 2 for DiSEL (input file 1 over input file 2)']));
set(handles.fix_motif_text, 'Tooltipstring',...
    sprintf(['Enter seed sequence or seed motif here']));
set(handles.fix_colum_drop, 'Tooltipstring',...
    sprintf(['Number corresponding to the column\n' ...
    'to be plotted on the z-axis']));
set(handles.fix_MinMisRing, 'Tooltipstring',...
    sprintf('Lowest SEL mismatch ring to be plotted'));
set(handles.fix_MaxMisRing, 'Tooltipstring',...
    sprintf(['Highest SEL mismatch ring to be plotted.\n' ...
    'Default is highest possible']));
set(handles.fix_smoothn, 'Tooltipstring',...
    sprintf(['Smoothing s means - Ring with N sequenecs are\n' ...
    'smoothened with a moving window of N*s/100 width']));
set(handles.fix_MismPeakDiffPerc, 'Tooltipstring',...
    sprintf(['Minimum percentage difference to pick\n' ...
    'peaks in the form of mismatch sequence']));
set(handles.fix_FlankPeakDiffPerc, 'Tooltipstring',...
    sprintf(['Minimum percentage difference to pick\n' ...
    'peaks in the form of flanking sequence']));
set(handles.load_inp, 'Tooltipstring',...
    sprintf(['Press this button to load inputs that were\n' ...
    'used last time when the software ran']));
set(handles.ssl_radio, 'Tooltipstring',...
    sprintf('Select this to plot SEL for input file 1'));
set(handles.disel_radio, 'Tooltipstring',...
    sprintf(['Select this to plot DiSEL of\n' ...
    'input file 1 over input file 2']));

guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = ssl_gui_1_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

% --- Executes on button press in get_ssl_push.
function get_ssl_push_Callback(hObject, eventdata, handles)
if strcmp(handles.data.inp,'0')
    errordlg('Please select input file 1');
elseif handles.data.disel==1 && strcmp(handles.data.inp2,'0')
    errordlg('Please select input file 2 for DiSEL');
elseif strcmp(handles.data.motif,'0')
    errordlg('Please enter seed motif');
else
    SaveState(handles);
    main_1(handles.data.inp,handles.data.inp2,handles.data.oup,...
        handles.data.motif,1,handles.data.smooth,handles.data.sel,...
        handles.data.ring_start,handles.data.ring_stop,...
        handles.data.choose_ssl,0,handles.data.column,handles.data.disel,...
        handles.data.MismPeakDiffPerc,handles.data.FlankPeakDiffPerc)
end

function inp_text_Callback(hObject, eventdata, handles)
user_entry = get(hObject,'string');
handles.data.inp=user_entry;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function inp_text_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function oup_text_Callback(hObject, eventdata, handles)
user_entry = get(hObject,'string');
handles.data.oup=user_entry;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function oup_text_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function motif_text_Callback(hObject, eventdata, handles)
user_entry = get(hObject,'string');
handles.data.motif=user_entry;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function motif_text_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in ssl_drop.
function ssl_drop_Callback(hObject, eventdata, handles)
user_entry = get(hObject,'Value');
handles.data.choose_ssl=user_entry-1;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function ssl_drop_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in sel_drop.
function sel_drop_Callback(hObject, eventdata, handles)
user_entry = get(hObject,'Value');
handles.data.sel=user_entry;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function sel_drop_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in colum_drop.
function colum_drop_Callback(hObject, eventdata, handles)
user_entry = get(hObject,'Value');
handles.data.column=user_entry+2;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function colum_drop_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in inp_push.
function inp_push_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.*');
if FileName~=0
    handles.data.inp=[PathName FileName];
    set(handles.inp_text,'String',handles.data.inp)
end
guidata(hObject, handles);

% --- Executes on button press in oup_push.
function oup_push_Callback(hObject, eventdata, handles)
[FileName,PathName] = uiputfile('*.*');
if FileName~=0
    handles.data.oup=[PathName FileName];
    set(handles.oup_text,'String',handles.data.oup)
end
guidata(hObject, handles);

% --- Executes on selection change in MinMisRing.
function MinMisRing_Callback(hObject, eventdata, handles)
user_entry = get(hObject,'Value');
handles.data.ring_start=user_entry-1;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function MinMisRing_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in MaxMisRing.
function MaxMisRing_Callback(hObject, eventdata, handles)
user_entry = get(hObject,'Value');
handles.data.ring_stop=user_entry-2;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function MaxMisRing_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function smoothn_Callback(hObject, eventdata, handles)
user_entry = get(hObject,'string');
handles.data.smooth=str2double(user_entry);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function smoothn_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function SaveState(handles)
state=handles.data;
save('ssl_gui_1_state.mat','state');

% --- Executes on button press in load_inp.
function load_inp_Callback(hObject, eventdata, handles)
if exist('ssl_gui_1_state.mat','file')
    load('ssl_gui_1_state.mat','state');
    handles.data=state;
    if strcmp(handles.data.inp,'0')
        set(handles.inp_text,'String','Select File')
    else
        set(handles.inp_text,'String',handles.data.inp)
    end
    set(handles.inp_text2,'String',handles.data.inp2)
    if strcmp(handles.data.inp2,'0')
        set(handles.inp_text2,'String','Select File')
    else
        set(handles.inp_text2,'String',handles.data.inp2)
    end
    if strcmp(handles.data.oup,'0')
        set(handles.oup_text,'String','Select File')
    else
        set(handles.oup_text,'String',handles.data.oup)
    end
    set(handles.motif_text,'String',handles.data.motif)
    set(handles.ssl_drop,'Value',handles.data.choose_ssl+1)
    set(handles.sel_drop,'Value',handles.data.sel)
    set(handles.colum_drop,'Value',handles.data.column-2)
    set(handles.MinMisRing,'Value',handles.data.ring_start+1)
    set(handles.MaxMisRing,'Value',handles.data.ring_stop+2)
    set(handles.smoothn,'String',num2str(handles.data.smooth))
    set(handles.edit_MismPeakDiffPerc,'String',num2str(handles.data.MismPeakDiffPerc))
    set(handles.edit_FlankPeakDiffPerc,'String',num2str(handles.data.FlankPeakDiffPerc))
    if handles.data.disel==0
        set(handles.ssl_radio,'value',1)
        set(handles.disel_radio,'value',0)
        set(handles.inp2_push,'Enable','off')
        set(handles.inp_text2,'Enable','off')
        set(handles.fix_text_inp2,'Enable','off')
    else
        set(handles.ssl_radio,'value',0)
        set(handles.disel_radio,'value',1)
        set(handles.inp2_push,'Enable','on')
        set(handles.inp_text2,'Enable','on')
        set(handles.fix_text_inp2,'Enable','on')
    end
    
    guidata(hObject, handles);
end

function inp_text2_Callback(hObject, eventdata, handles)
user_entry = get(hObject,'string');
handles.data.inp2=user_entry;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function inp_text2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in inp2_push.
function inp2_push_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.*');
if FileName~=0
    handles.data.inp2=[PathName FileName];
    set(handles.inp_text2,'String',handles.data.inp2)
end
guidata(hObject, handles);

% --- Executes on button press in ssl_radio.
function ssl_radio_Callback(hObject, eventdata, handles)
set(handles.disel_radio,'value',0)
set(handles.ssl_radio,'value',1)
handles.data.disel=0;
set(handles.inp2_push,'Enable','off')
set(handles.inp_text2,'Enable','off')
set(handles.fix_text_inp2,'Enable','off')
guidata(hObject, handles);

% --- Executes on button press in disel_radio.
function disel_radio_Callback(hObject, eventdata, handles)
handles.data.disel=1;
set(handles.ssl_radio,'value',0)
set(handles.disel_radio,'value',1)
set(handles.inp2_push,'Enable','on')
set(handles.inp_text2,'Enable','on')
set(handles.fix_text_inp2,'Enable','on')
guidata(hObject, handles);


function figure1_CloseRequestFcn(hObject, eventdata, handles)
delete(hObject);


function edit_MismPeakDiffPerc_Callback(hObject, eventdata, handles)
user_entry = get(hObject,'string');
handles.data.MismPeakDiffPerc=str2double(user_entry);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_MismPeakDiffPerc_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_FlankPeakDiffPerc_Callback(hObject, eventdata, handles)
user_entry = get(hObject,'string');
handles.data.FlankPeakDiffPerc=str2double(user_entry);
guidata(hObject,handles);

function edit_FlankPeakDiffPerc_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
