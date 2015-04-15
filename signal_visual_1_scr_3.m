%script # 3 for signal_visualization program
% plots the selected lead signal in the new figure
% detailed plot + selecting waveform for further processing

% updated 05.10.2004-- button for creating the adapted waveforms

fd1=figure('Name',strcat(' Detailed plot of `',get(sn1,'string'),' -th lead.' ), ...
        'NumberTitle','off', ...
        'Visible','on');
     set(fd1,'units','pixels');
     s=get(0,'ScreenSize');
set(fd1,'position',[.1*s(3) .07*s(4) .8*s(3) .8*s(4)]);
set(fd1,'doublebuffer','on');
set(fd1,'renderer','painters');
set(fd1,'color',[.5  .7 .6]);
clear s;

% close button creation
uicontrol('Style','pushbutton','Units','normalized',...
   'Position',[.9 .005 .09 .07],'String','Close',...
   'FontWeight','bold','fontsize',10,'Callback','close(gcf)');

%axis for signal plot
ad1=axes('parent',fd1);
set(ad1,'box','on','linewidth',2,'tickdir','in','ticklength',[.01 0.025]...
    ,'units','normalized','position',[0.05 0.11 0.6 0.8]);
set(ad1,'GridLineStyle',':','xgrid','on','ygrid','on',...
    'fontname','courier','fontsize',8,'FontWeight','bold',...
    'color',[.9 .9 1],'xcolor','black','ycolor','black',...
    'buttondownfcn','');

set(ad1,'buttondownfcn',...
   'C=get(ad1,''currentpoint'');set(snd1,''string'',num2str(round(C(1,1))) );');
 
% SLIDER for detailed plot
ssd1=uicontrol('Style','slider','Units','normalized', ...
   'Position',[.02 .03 0.7 0.04],'max',1,'min',0, ...
   'Callback','signal_visual_1_scr_4',...
   'SliderStep',[0.001 0.005]);

% text with TIP for using the buttons
ttbd1=uicontrol('style','text',...
   'units','normalized','position',[.67 .62 .3 .37],...
   'fontsize',10,'visible','off',...
   'string','Use slider below the graph and the mouse left button to indicate the limits of waveform of interest in this lead. Press appropriate buttons for beginning and end of waveform and then "OK" for further work with this waveform only, or press "Add to adaptive" to collect chosen waveform in the matrix.');

% textbox containing the coordinates of current cursor
% position
snd1=uicontrol('style','text','string',...
   int2str(0),'units','normalized','position',[.67 .57 .09 .03]);

% buttons for selecting begin and end of waveform
wf_beg=1;
wf_end=2;
bbd1=uicontrol('Style','pushbutton','Units','normalized',...
   'Position',[.77 .57 .09 .04],'String','Begin',...
   'FontWeight','bold','fontsize',8,'Callback','wf_beg=str2num(get(snd1,''string'')); s=sig(wf_beg:wf_end); ');

ebd1=uicontrol('Style','pushbutton','Units','normalized',...
   'Position',[.87 .57 .09 .04],'String','End',...
   'FontWeight','bold','fontsize',8,'Callback','wf_end=str2num(get(snd1,''string'')); s=sig(wf_beg:wf_end);');

% the button for further processing chosen waveform
fpbd1=uicontrol('Style','pushbutton','Units','normalized',...
   'Position',[.67 .5 .3 .05],'String','Process',...
   'FontWeight','bold','fontsize',10,'Callback','signal_visual_1_scr_5');

% line for detailed plot
sig=A(str2num(get(sn1,'string')),:)/max(abs(A(str2num(get(sn1,'string')),:)));
%sig=sig-mean(sig);

SIG=sig;% the variable for storing the whole lead, chosen from
% first window

siglen=length(sig);
%show_step=floor(siglen/15);
show_step=floor(sig_show_step/13);
signal_visual_1_scr_4;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% added 5.10.2004
%%%%%%%%%%%%%%%%%%%%%%

% the button for further creating the adapted waveform
fpbd1=uicontrol('Style','pushbutton','Units','normalized',...
   'Position',[.67 .43 .3 .05],'String','Add to adaptive',...
   'FontWeight','bold','fontsize',12,'Callback',' adapted_func_1; ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% added 4.12.2004
%%%%%%%%%%%%%%%%%%%%%%

% the button for using the adapted waveform, obtained
% from waveset matrix

fpbd1=uicontrol('Style','pushbutton','Units','normalized',...
   'Position',[.67 .36 .3 .05],'String','Use adaptive',...
   'FontWeight','bold','fontsize',12,'Callback',' adapted_func_1; ');

