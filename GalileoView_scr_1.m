%script #1 for GalileoView
% 
% called from GalileoView
%  
% plots the multichannel signal in the existing axis
% 29.04.2005
% corrected 09.01.2010
% added "Events of Interest" on 15.04.2015

s_beg=1;
s_end=257;

delete(get(a1,'children'));

% time step (sec)
time_step=1/SampleRate; % sampling time step (from file)
%sec_to_see=tscale; % signal duration (seconds) to see on the screen
sig_show_step=floor(sec_to_see/time_step);% samples number 

%[ch_num,smp_num]=size(A);
smp_num=size(A,2);
ch_num=19;
l_hnd=zeros(1,ch_num);% handles for lines on the large plot
l_lab_l=zeros(1,ch_num);% handles for lines on the small plot with 50uV pulse
l_lab_r=zeros(1,ch_num);% handles for lines on the small plot with 50uV pulse


%%%%%
% added 17.01.2006
% line with marks for user labels
ul=-100*ones(1,size(A,2));% baseline for labels
if ~isempty(ff)
    ul(ff(:,1))=1365; % marks for the beginnings of user labels
end
ull=line('parent',a1,...
   'linestyle','none','marker','p','markersize',20,...
   'MarkerFaceColor','red',...
   'buttondownfcn',...
   ['c=get(a1,''currentpoint'');'...
      'mn=round(round(c(1,1))/SampleRate);'...
      '[ii,jj]=find(ff(:,1)/SampleRate==mn);'...
      'set(ulm,''string'',strcat(h.GTF.L2(ff(ii,2),:),''_'', num2str(ii)))']);%,...

%%%%%%
% added 10.02.2007 baseline for paroxismal activity highlightning
pl=-1000*ones(1,smp_num);
pll=line('parent',a1,'color','red',...
   'linestyle','none','marker','.','markersize',5,...
   'MarkerFaceColor','blue',...
   'buttondownfcn','');

%%%%%
% line for coeficients highlightning
cl=-100*ones(1,size(A,2));% baseline for labels
cll=line('parent',a1,'color','red',...
   'linestyle','none','marker','.','markersize',5,...
   'MarkerFaceColor','red',...
   'buttondownfcn','');%,...

%%%%%%
% added 04.02.2010 baseline for Epileptiform complexes highlightning
wl=-1000*ones(1,smp_num);
wll=line('parent',a1,'color','red',...
   'linestyle','none','marker','.','markersize',5,...
   'MarkerFaceColor','blue',...
   'buttondownfcn','');


%%%%%%
% added 15.04.2015 baseline for "Events of Interest" highlightning,
% Kharitonov
events_line_l=line('parent',a1,'color','red',...
   'linestyle','none','marker','.','markersize',300,...
   'MarkerFaceColor','blue',...
   'buttondownfcn','');



%slider for signal
sss=uicontrol('Style','slider','parent',f1,'Units','normalized', ...
   'Position',[.064 .01 0.8 0.04],...
   'max',round((smp_num+1)*time_step),'min',0, ...
   'SliderStep',[4/round((smp_num+1)*time_step) 8/round((smp_num+1)*time_step)],...
   'Callback','GalileoView_scr_9;  ');

%GalileoView_scr_9;
GalileoView_scr_15;

