% script #2 for eeg_patt_loc_coef_vis
% finds the selected waveforms in the signal lead
% coefficients are taken from the detailed plot,
% made by eeg_patt_loc_coef_vis_scr_1

% lead is taken from GalileoView (ln)
% 01.06.2005

f6=figure('Name','Locating the waveforms found in EEG signal.', ...
        'NumberTitle','off', ...
        'Visible','off');
     set(f6,'units','pixels');
     s=get(0,'ScreenSize');
set(f6,'position',[.1*s(3) .25*s(4) .8*s(3) .5*s(4)],...
'doublebuffer','off','renderer','painters',...
'color',[.5  .75 .5]);
clear s;

% close button creation
uicontrol('Style','pushbutton','Units','normalized',...
   'Position',[.9 .01 .09 .06],'String','Close',...
   'FontWeight','bold','fontsize',10,'Callback','clear sign; close(gcf)');

%signn=A(ln,:);% line for signal
%signn=signal;% !!!!!!!!!!

%%%%%%%%%
%
if sum(strcmp(who,'signal'))==1
   signn=signal;
else
   signn=A(ln,:);
   fun_len=SampleRate;
end
%%%%%%%%%


%axis for signal plot
f6ad1=axes('parent',f6);
set(f6ad1,'box','on','linewidth',2,'tickdir','in','ticklength',[.01 0.025]...
    ,'units','normalized','position',[0.05 0.44 0.9 0.55]);
set(f6ad1,'GridLineStyle',':','xgrid','on','ygrid','on',...
    'fontname','courier','fontsize',10,'FontWeight','bold',...
    'color',[.9 .9 1],'xcolor','white','ycolor','white',...
    'buttondownfcn','','ylim',[min(signn)-3 max(signn)+3]);

ax_len_v=261; % axis length on my home PC
sec_to_see_v=ax_len_v/60; %initial time scale for 60 mm/sec
sig_show_step_v=floor(sec_to_see_v/time_step);% samples number 

% SLIDER for detailed plot
f6ssd1=uicontrol('Style','slider','Units','normalized', ...
   'Position',[.05 .3 0.5 0.06],'max',round((smp_num+1)*time_step),'min',0, ...
   'Callback','eeg_patt_loc_coef_vis_scr_3',...
   'SliderStep',...
   [1/round((smp_num+1)*time_step) 4/round((smp_num+1)*time_step)]);

%%%%%%%%%%
% added 17.01.2006
% button for underliyng the complexes in the Main window
uicontrol('Style','pushbutton','Units','normalized',...
   'Position',[.56 .3 0.4 0.08],'String','Locate in the Main Window',...
   'FontWeight','bold','fontsize',10,...
   'Callback',...
   ['close(gcf);'...
      '[iii,jjj]=find(places==ln);'...
      'cl=undln*(ch_num-jjj-1)*70+20;'...
      'GalileoView_scr_9;'...
      '']);

%%%%%%%%%%%%%%%
% underlines of comlexes \m/
undln=-1000*ones(1,smp_num);
for i=1:length(ind)
    undln(ind(i):ind(i)+fun_len)=1;
end

und=line('parent',f6ad1,'linestyle','none',...
   'marker','.','markersize',10);% underlying line for complexes found



eeg_patt_loc_coef_vis_scr_3;

%==================
set(f6,'visible','on')