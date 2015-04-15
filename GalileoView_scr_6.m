% script # 6 for GalileoView program
% plots the obtained waveforms from the set in the existing axes

% recalled from GalileoView_scr_5

%wf=mean(F,1);

%size(wf)

set(itd2,'fontsize',10,'ForegroundColor',[0 0 1],...
   'string',strcat(num2str(str),' functions in the set.'));
   pause(0.1);

set(ad2,'xlim',[1 stb],'xtick',linspace(1,stb,5),...
   'xticklabel',linspace(1,stb,5),...
   'ylim',[min(min(F))-5 max(max(F))+5]);
%   'ylim',[1.2*min(wf)-5 1.2*max(wf)+5]);

for i=1:str
   str_cntr=str_cntr+1;
   set(lchd2,'ydata',F(str_cntr,:),...
      'xdata',1:stb);
   pause(0.05);
   if str_cntr==str
      set(itd2,'fontsize',10,'ForegroundColor',[1 0 0],...
         'string','We have no more functions');
      str_cntr=0;
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%
% part from _scr_5, that perofrms returning to the axis
% initial selected part of the lead instead of
% set functions were visualized
set(lchd2,'visible','on');
set(lchd2,'ydata',wf,...
   'xdata',1:wf_end-wf_beg+1,...
   'buttondownfcn','',...
   'userdata','');
set(ad2,'xlim',[1 wf_end-wf_beg+1],...
    'xtick',linspace(0,(wf_end-wf_beg+1),5),...
   'ylim',[min(wf)-1 max(wf)+1],...
   'xticklabel',linspace(0,(wf_end-wf_beg+1),5),...
   'buttondownfcn','','userdata','');
%%%%%%%%%%%%%%%%%%%%%%%

