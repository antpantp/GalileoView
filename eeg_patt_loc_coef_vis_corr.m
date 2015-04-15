% program for eeg_pattern_loc coefficients visualizing
% recalled from eeg_patt_loc
% plots obtained similarity coefficients

% 01.06.2005 19-06

figure('Name','Visualizing the coefficients for EEG pattern localization.', ...
        'NumberTitle','off', ...
        'Visible','off','units','pixels');
     s=get(0,'ScreenSize');
set(gcf,'position',[.01*s(3) .05*s(4) .98*s(3) .88*s(4)]);
set(gcf,'doublebuffer','on','renderer','painters','color',[.7  .65 .1]);
clear s;

% close button creation
uicontrol('Style','pushbutton','Units','normalized',...
   'Position',[.945 .002 .05 .03],'String','Close',...
   'FontWeight','light','fontsize',12,'Callback','close(gcf)');

% text for filename with coefficients to save
fn4=uicontrol('style','edit','units','normalized',...
   'position',[.1 .952 .1 .041],'FontWeight','normal','fontsize',12,...
   'createfcn','',...
   'callback','');

% button for saving coefficients
uicontrol('Style','pushbutton','Units','normalized',...
   'Position',[.32 .952 .1 .041],'String','Save',...
   'FontWeight','bold','fontsize',10,...
   'Callback','save(get(fn4,''string''), ''coef'');');

% button for loading existing coefficients
uicontrol('Style','pushbutton','Units','normalized',...
   'Position',[.21 .952 .1 .041],'String','Load',...
   'FontWeight','bold','fontsize',10,...
   'Callback',['load(get(fn4,''string''));'...
      'c_viz=coef; clll=length(c_viz);',...
      'set(l,''ydata'',c_viz,''xdata'',1:clll,''marker'',''.'',''LineStyle'',''none'');',...
      'set(a4,''ylim'',[-5 1.1*max(c_viz)],''xlim'',[1 clll]);']);

%text with sample number
uicontrol('Style','text','Units','normalized',...
   'Position',[.6 .952 .1 .042],'String','Sample number ========>',...
   'FontWeight','bold','fontsize',9,'buttondownfcn','');

%axis for coefficient plot
a4=axes('parent',gcf);
set(a4,'box','on','linewidth',2,'tickdir','in','ticklength',[.01 0.025]...
    ,'units','normalized','position',[.055 .5 .92 .45]);
set(a4,'GridLineStyle',':','xgrid','on','ygrid','on',...
    'fontname','courier','fontsize',8,'FontWeight','bold',...
    'color',[.9 .9 1],'xcolor','black','ycolor','black',...
    'createfcn','',...
    'buttondownfcn','B=get(a4,''currentpoint'');sn4=uicontrol(''style'',''text'',''string'',num2str(round(B(1,1))),''units'',''normalized'',''FontWeight'',''bold'',''fontsize'',12,''position'',[.71 .952 .1 .03]   );       ');
 
l=line('parent',a4,'linewidth',1,'buttondownfcn',...
   'B=get(a4,''currentpoint'');sn=uicontrol(''style'',''text'',''string'',num2str(round(B(1,1))),''units'',''normalized'',''FontWeight'',''bold'',''fontsize'',12,''position'',[.71 .952 .1 .03]   );       ');
c_viz=coef;
clll=length(c_viz);
set(l,'ydata',c_viz,'xdata',1:clll,'marker','.',...
   'LineStyle','none');
set(a4,'ylim',[-2 1.1*max(c_viz)],'xlim',[1 clll+1]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% text for tip to threshold input
uicontrol('Style','text','Units','normalized',...
   'Position',[.112 .43 .12 .042],'String','Input the threshold =====>',...
   'FontWeight','bold','fontsize',8,'buttondownfcn','');

% text for threshold
uicontrol('style','edit','units','normalized',...
   'position',[.242 .43 .1 .041],'FontWeight','normal','fontsize',12,...
   'createfcn','',...
   'callback','thr=str2num(get(gco,''string''));');

% button for plotting detailed coefficients
uicontrol('Style','pushbutton','Units','normalized',...
   'Position',[.35 .43 .06 .041],'String','Plot!',...
   'FontWeight','bold','fontsize',10,...
   'Callback','g=gcbo; eeg_patt_loc_coef_vis_scr_1_corr');

% button for plotting detailed graph
uicontrol('Style','pushbutton','Units','normalized',...
   'Position',[.42 .43 .15 .041],'String','Find in signal',...
   'FontWeight','bold','fontsize',10,...
   'Callback','eeg_patt_loc_coef_vis_scr_2;');


%text with sample number
uicontrol('Style','text','Units','normalized',...
   'Position',[.6 .43 .1 .042],'String','Sample number ========>',...
   'FontWeight','bold','fontsize',9,'buttondownfcn','');

%axis for detailed plot
ad4=axes('parent',gcf);
set(ad4,'box','on','linewidth',2,'tickdir','in','ticklength',[.01 0.025]...
   ,'units','normalized','position',[.055 .069 .92 .357]);
set(ad4,'ylimmode','manual','ylim',[-.001 .05*abs(mean(c_viz))]);
set(ad4,'GridLineStyle',':','xgrid','on','ygrid','on',...
    'fontname','courier','fontsize',8,'FontWeight','bold',...
    'color',[.9 .9 1],'xcolor','black','ycolor','black',...
    'buttondownfcn','C=get(ad4,''currentpoint'');sd=uicontrol(''style'',''text'',''string'',num2str(round(C(1,1))),''units'',''normalized'',''FontWeight'',''bold'',''fontsize'',12,''position'',[.71 .43 .05 .03]   );       ');

 
 %%%%%%%%%%%%
set(gcf,'visible','on');
figure(gcf);