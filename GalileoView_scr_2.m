%script #2 for GalileoView
% 
% called from GalileoView
%  
% plots the SELECTED LEAD of EEG signal in the new figure
% detailed plot + selecting waveform for further processing

% 25.05.2005 17-57

fd1=figure('Name',...
   [' Detailed plot of ', char(get(sn1,'string')), '-th lead.',...
    '                 Laboratory of Diagnostic Devices, PhBME Dept., NTUU "KPI"'],...
        'NumberTitle','off','Visible','on');
     set(fd1,'units','normalized');
set(fd1,'position',[.05 .08 .9 .8]);
set(fd1,'doublebuffer','on');
set(fd1,'renderer','painters');
set(fd1,'color',[.5  .7 .6]);

% close button creation
uicontrol('Style','pushbutton','Units','normalized',...
   'Position',[.9 .005 .09 .07],'String','Close',...
   'FontWeight','bold','fontsize',10,'Callback','close(gcf)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% line for detailed plot
sig=A(ln,:);
ax_lims=[min(sig)-10 max(sig)+10];% limits for y-axis on the plots of detailed signal and for label

%!!!!!!!
%SIG=sig;% the variable for storing the whole lead, chosen from
% first window % for returning after set forming

ax_len_d=320; % my home PC 210
%ax_len_d=202; % for P3
%ax_len_d=231.5; % notebook

sec_to_see_d=ax_len_d/60; %initial time scale for 60 mm/sec
sig_show_step_d=floor(sec_to_see_d/time_step);% samples number 

%axis for detailed signal plot
ad1=axes('parent',fd1);
set(ad1,'box','on','linewidth',2,'tickdir','in','ticklength',[.01 0.025]...
    ,'units','normalized','position',[0.05 0.55 0.95 0.44]);
set(ad1,'GridLineStyle',':','xgrid','on','ygrid','on',...
    'fontname','courier','fontsize',8,'FontWeight','bold',...
    'color',[.9 .9 1],'xcolor','black','ycolor','black',...
    'buttondownfcn', 'C=get(ad1,''currentpoint'');set(snd1,''string'',num2str(round(C(1,1))) );');

% left axis for label plot 
ad1_l=axes('parent',gcf);
set(ad1_l,'box','on','linewidth',1,'tickdir','in','ticklength',[.01 0.025],...
       'ytick',[],'xtick',[],'ylim',ax_lims,...
   'xticklabel',[],'color','none',...
   'units','normalized','visible','off');
set(ad1_l,'position',[.05 .55 .02 .44]);

% label with 50 uV
labelline=line('parent',ad1_l,'linewidth',5,...
       'ydata',-20+Lab,...
   'xdata',[1:15],'color','red');

% SLIDER for detailed plot
ssd1=uicontrol('Style','slider','Units','normalized', ...
   'Position',[.02 .45 0.6 0.04],'max',get(sss,'max'),'min',get(sss,'min'), ...
   'Callback','GalileoView_scr_3',...
   'SliderStep',...
   [.5/round((smp_num+1)*time_step) 3/round((smp_num+1)*time_step)]);

% textbox containing the coordinates of current cursor
% position
snd1=uicontrol('style','text','string',...
   int2str(0),'units','normalized','position',[.67 .47 .09 .03]);

% buttons for selecting begin and end of waveform
wf_beg=1;
wf_end=2;
bbd1=uicontrol('Style','pushbutton','Units','normalized',...
   'Position',[.77 .47 .09 .04],'String','Begin',...
   'FontWeight','bold','fontsize',8,...
   'Callback','wf_beg=str2num(get(snd1,''string'')); s=sig(wf_beg:wf_end); ');

ebd1=uicontrol('Style','pushbutton','Units','normalized',...
   'Position',[.87 .47 .09 .04],'String','End',...
   'FontWeight','bold','fontsize',8,...
   'Callback','wf_end=str2num(get(snd1,''string'')); s=sig(wf_beg:wf_end);');

% the button for further processing chosen waveform
fpbd1=uicontrol('Style','pushbutton','Units','normalized',...
   'Position',[.67 .4 .3 .05],'String','Process',...
   'FontWeight','bold','fontsize',10,...
   'Callback','GalileoView_scr_5');

% the button for further creating the adapted waveform
fpbd1=uicontrol('Style','pushbutton','Units','normalized',...
   'Position',[.67 .33 .3 .05],'String','Add to adaptive',...
   'FontWeight','bold','fontsize',12,'Callback',' adapted_func_1; ');

% the button for using the adapted waveform, obtained
% from waveset matrix

fpbd1=uicontrol('Style','pushbutton','Units','normalized',...
   'Position',[.67 .26 .3 .05],'String','Use adaptive',...
   'FontWeight','bold','fontsize',12,'Callback',' adapted_func_1; ');


GalileoView_scr_3;
