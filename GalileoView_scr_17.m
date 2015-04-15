%script #17 for GalileoView
% 
% called from GalileoView,
% custom filtering of the SEGMENT of the signal
  
% opens new figure for filename with 
% desired Frequency Response
% then performs filtering of the signal (entire!!!)
% 24.08.2005 11-56

figure('Name','Desired Frequency Response', ...
        'NumberTitle','off','units','normalized',...
        'position',[0.15    0.6    0.25    0.2],...
        'color',[0.803    0.5485    0.2618]);
% edit for frequency input
newscale=uicontrol('style','edit','units','normalized',...
   'position',[.1 .7 .4 .2],'FontWeight','normal','fontsize',12,...
   'TooltipString','Type the name of the file with frequency  resconse to filter the current signal and press "Filter It!" button.',...
   'callback','',...
   'string','');


% button for filtering
% and closing the figure
uicontrol('Style','pushbutton','Units','normalized',...
   'Position',[.1 .45 .4 .2],'String','Filter It!',...
   'FontWeight','light','fontsize',12,...
   'Callback',...
   ['load(get(newscale,''string''));'...
       'b_smp=size(B,2);'...
       'cor=zeros(size(B));'...
       'cor=((B(:,b_smp)-B(:,1))/(b_smp-1))*[0:b_smp-1];'...
       'y=zeros([b_smp ch_num]);'...
       'y=fft(transpose(B-cor));'...
       'spf=zeros(b_smp,1);'...
       'sp=interp1([0:length(wave)-1]*inc,wave,(0:b_smp-1)*SampleRate/b_smp,''nearest'');'...
       'spf(1:round((b_smp-1)/2))=sp(1:round((b_smp-1)/2));'...
       'spf(b_smp:-1:b_smp-round((b_smp-1)/2)+2)=sp(2:round((b_smp-1)/2));'...
       'galileoview_scr_12;'...
       'B=real(ifft(y)'');'...
       'A(:,s_beg:s_end)=B;'...
       'GalileoView_scr_9;'...
       'clear cor y spf sp inc b_smp;'...
       'close(gcf);']);

% for using with MatLAB 6, INTERP1 sould be:
% 'sp=interp1([0:length(wave)-1]*inc,wave,(0:smp_num-1)*SampleRate/smp_num,''nearest'',''extrap'');'...

%       'rt=12%spf(smp_num:-1:smp_num-round((smp_num-1)/2)+2)=sp(2:round((smp_num-1)/2));'...