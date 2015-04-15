% script # 6 for signal_visualization program
% plots the obtained waveforms from the set in the existing axes

% recalled from _scr_5

set(itd2,'fontsize',10,'ForegroundColor',[0 0 1],...
   'string',strcat(num2str(str),' functions in the set.'));
   pause(0.01);

set(ad2,'xlim',[1 stb],'xtick',linspace(0,stb,5),'xticklabel',linspace(0,stb,5),...
   'ylim',[-1.5 1.5]);

for i=1:str
   str_cntr=str_cntr+1;
   set(lchd2,'ydata',F(str_cntr,:),...
      'xdata',1:stb);
%   set(ad2,'xlim',[1 stb],'xtick',linspace(0,stb,5),'xticklabel',linspace(0,stb,5),...
%      'ylim',[-1.5 1.5]);
   pause(0.01);
   if str_cntr==str
      set(itd2,'fontsize',10,'ForegroundColor',[1 0 0],...
         'string','We have no more functions!!!');
      str_cntr=0;
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%
% part from _scr_5, that perofrms returning to the axis
% initial selected part of the lead instead of
% set functions were visualized
set(lchd2,'ydata',wf,...
   'xdata',1:wf_end-wf_beg+1,...
   'buttondownfcn','',...
   'userdata','');
set(ad2,'xlim',[1 wf_end-wf_beg+1],'xtick',linspace(0,(wf_end-wf_beg+1),5),...
   'ylim',[min(wf)-.1 max(wf)+.1],...
   'xticklabel',linspace(0,(wf_end-wf_beg+1),5),...
   'buttondownfcn','','userdata','');
%%%%%%%%%%%%%%%%%%%%%%%%

