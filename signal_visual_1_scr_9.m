% script for signal_visual_1_scr_1
% plots the part of multichannel signal 
% when the slider is moved
% 22.11.2004
delete(get(a1,'children'));
begs=floor( get(sss,'value')*smp_num )+1;
ens=begs+sig_show_step;
if ens>smp_num
   ens=smp_num;
   begs=ens-sig_show_step;
end
for i=ch_num:-1:1
   l_hnd(i)=line('parent',a1,'linewidth',.5);
   set(l_hnd(i),'ydata',...
   A(i,begs:ens)/max(A(i,begs:ens))+1.2*i-1,...
   'xdata',[begs:ens],'buttondownfcn',...
   ' set(sn1,''string'',int2str(get(gco,''userdata''))); ',...
   'userdata',i,'visible','off');
end
set(l_hnd,'visible','on');

set(a1,'xtickmode','manual','ytickmode','manual',...
   'ytick',[],'xtick',linspace(begs,ens,7),...
   'xticklabel',(linspace(begs,ens,7)-1)*time_step*dsr,...
   'xlimmode','manual','xlim',[begs ens]);