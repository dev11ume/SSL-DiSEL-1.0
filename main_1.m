% CALLS FUNCTION TO PLOT SSL/DiSEL AND DISPLAY SEQUENCES ON CLICKS
function main_1(inp,inp2,op,motif,l_l,sm,sel,...
    ring_start,ring_stop,BarPlot,n_pt,column,disel,...
    MismPeakDiffPerc,FlankPeakDiffPerc)

h_msgbox=msgbox('SSL/DiSEL in creation. Please Wait.');
child = get(h_msgbox,'Children');
delete(child(2));

% CREATE FIGURE ACCORDING TO SCREEN SIZE WITH UI CONTROL
scr=get(0,'ScreenSize' );
N=scr(3);
M=scr(4);
handles.fig = figure('Name','SSL/DiSEL',...
    'NumberTitle','off',...
    'Units', 'Pixels', ...
    'OuterPosition', [0 0 N M], ...
    'Color', [1 1 1],'toolbar','figure');
handles.button1 = uicontrol('Units', 'pixels', ...
    'Position', [450 50 150 100], ...
    'String', 'Sequences From','FontSize',10, ...
    'Style', 'togglebutton');

hText = uicontrol('Style', 'text','FontSize',10);
st=['Please select a start sequence on SSL for MEME by' ...
    ' first clicking a point on SSL then click Sequences From button'];
set(hText, 'Position', [0 50 450 100], 'String',st);
hText1 = uicontrol('Style', 'text');
set(hText1, 'Position', [0 0 200 50],'FontSize',20,'BackgroundColor','g' );
hText2 = uicontrol('Style', 'text');
set(hText2, 'Position', [200 0 200 50],'FontSize',20,'BackgroundColor','r' );
hText3 = uicontrol('Style', 'text');
set(hText3, 'Position', [400 0 200 50 ],'FontSize',20,'BackgroundColor','g' );
subplot('Position', [0 0 1 1]);
fig1= gcf;

if disel==0
    [op,f,Intx,Us3,Ucode3,l,ln,lm,ls2,X,Y,Z,comm_str] =...
        ssl_1(inp,motif,...
        'OutputFile',op,...
        'Thickness',l_l,...
        'Smoothening',sm,...
        'MismPeakDiffPerc',MismPeakDiffPerc,...
        'FlankPeakDiffPerc',FlankPeakDiffPerc,...
        'order',sel,...
        'ring_start',ring_start,...
        'ring_stop',ring_stop,...
        'BarPlot',BarPlot,...
        'n_pt',n_pt,...
        'column',column,...
        'full_op',1,...
        'from_gui',fig1,...
        'h_msgbox',h_msgbox);
    handles.textbox1 = uicontrol('Units', 'pixels', ...
        'Position', [700 0 1000 80],'style','text',...
        'FontSize',10, ...
        'String',comm_str);
    delete(h_msgbox);
else
    [op,f,Intx,Us3,Ucode3,l,ln,lm,ls2,X,Y,Z,comm_str] =...
        disel_1(inp,inp2,motif,...
        'OutputFile',op,...
        'Thickness',l_l,...
        'Smoothening',sm,...
        'MismPeakDiffPerc',MismPeakDiffPerc,...
        'FlankPeakDiffPerc',FlankPeakDiffPerc,...
        'order',sel,...
        'ring_start',ring_start,...
        'ring_stop',ring_stop,...
        'BarPlot',BarPlot,...
        'n_pt',n_pt,...
        'column',column,...
        'full_op',1,...
        'from_gui',fig1,...
        'h_msgbox',h_msgbox);
    handles.textbox1 = uicontrol('Units', 'pixels', ...
        'Position', [700 0 1000 80],'style','text',...
        'FontSize',10, ...
        'String',comm_str);
    delete(h_msgbox);
end

if BarPlot==0
    % INITIALIZING VARIABLES FOR MEME RUNS
    k=1;strt=1;
    save('temp_var.mat','k','strt');
    
    datacursormode on;
    
    % FUNCTION TO GET SEQUENCE AT PARTICULAR POINT ON SSL
    set(handles.fig, 'WindowButtonMotionFcn',...
        {@hFigure_MotionFcn,fig1,hText1,hText2,hText3,...
        op,f,Intx,Us3,Ucode3,l,ln,lm,ls2,X,Y,Z});
    
    % FUNCTION TO GET SEQUENCES BETWEEN 2 POINTS ON SAME RING OF SSL TO RUN MEME
    set(handles.button1, 'callback',...
        {@start_meme_seq, handles,fig1,op,f,Intx,...
        Us3,Ucode3,l,ln,lm,ls2,X,Y,Z,hText});
end

function start_meme_seq(hObject, event_data, handles,...
    fig1,op,f,Uint3,Us3,Ucode3,l,ln,lm,ls2,X,Y,Z,hText)

dcm_obj = datacursormode(fig1);
set(dcm_obj,'DisplayStyle','window');
info_struct = getCursorInfo(dcm_obj);
if ~isempty(info_struct)
    te=info_struct.Position;
    
    m=round(sqrt(te(1)^2+te(2)^2)/10);
    theta=atan(te(2)/te(1));
    if te(1)<0 && te(2)<0
        theta=theta-pi;
    elseif te(1)<0 && te(2)>0
        theta=theta+pi;
    end
    theta=-theta+pi;
    n=round(theta*(l(m)-1)/(2*pi))+ln(m,1);
end

load('temp_var.mat','strt','k');
if strt==1
    strt=0;
    save('temp_var.mat','n','strt','k');
    st=['Sequence ' char(Us3(n,lm:ls2-lm+1)) ...
        ' has been selected as start, now select the stop sequence' ...
        ' on SSL and press Sequence To button'];
    set(hText, 'String',st);
    set(handles.button1, 'String','Sequence To');
else
    n2=n;
    load('temp_var.mat');
    if Ucode3(n,1)==Ucode3(n2,1)
        mi=min(n,n2);
        ma=max(n,n2);
        opp1=[op '_meme' int2str(k) '.txt'];
        opp2=[op '_' int2str(k) '.txt'];
        fd1= fopen(opp1,'w');
        fd2= fopen(opp2,'w');
        for i=mi:ma
            fprintf(fd1,'>%d\n%s\n',i,char(Us3(i,lm:ls2-lm+1)));
            fprintf(fd2,'%8.4f\t %8.4f\t %8.4f\t %s\t %d\n',...
                X(i),Y(i),Uint3(i),char(Us3(i,lm:ls2-lm+1)),Ucode3(i,1));
        end
        fclose(fd1);
        fclose(fd2);
        strt=1;
        k=k+1;
        st=['The sequence file ' opp1 ' and ' opp2 ...
            ' are created. Please select another start sequence on SSL for MEME'];
        set(hText, 'String',st);
        set(handles.button1, 'String','Sequence From');
    else
        strt=1;
        st=['Start and stop Sequences are in different ring ' ...
            'please select sequences in the same ring-' ...
            ' Please select a start sequence on SSL for MEME'];
        set(hText, 'String',st);
        set(handles.button1, 'String','Sequence From');
    end
    save('temp_var.mat','k','strt');
end


function hFigure_MotionFcn(hFigure, event_data,fig1,...
    hText1,hText2,hText3,op,f,Intx,Us3,Ucode3,l,ln,lm,ls2,X,Y,Z)

dcm_obj = datacursormode(fig1);
set(dcm_obj,'DisplayStyle','window');
info_struct = getCursorInfo(dcm_obj);
if ~isempty(info_struct)
    te=info_struct.Position;
    
    m=round(sqrt(te(1)^2+te(2)^2)/10);
    theta=atan(te(2)/te(1));
    if te(1)<0 && te(2)<0
        theta=theta-pi;
    elseif te(1)<0 && te(2)>0
        theta=theta+pi;
    end
    theta=-theta+pi;
    n=round(theta*(l(m)-1)/(2*pi))+ln(m,1);
    
    pos=Ucode3(n,end);
    if lm~=Ucode3(n,1)
        st1=char(Us3(n,lm:pos-1));
        st2=char(Us3(n,pos:pos+lm-1));
        st3=char(Us3(n,pos+lm:ls2-lm+1));
    elseif pos==1
        st1='';
        st2=['X' char(Us3(n,pos:pos+lm-1))];
        st3=char(Us3(n,pos+lm:ls2-lm+1));
    else
        st1=char(Us3(n,lm:pos-1));
        st2=char(Us3(n,pos:pos+lm-1));
        st3=char(Us3(n,pos+lm:ls2-lm+1));
    end
    set(hText1, 'String',st1);
    set(hText2, 'String',st2);
    set(hText3, 'String',st3);
end

