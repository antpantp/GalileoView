% detailed plot of the signal with marked places of 
% fund waveforms (after detailed coefficients plot)
% called from eeg_patt_loc_coef_vis_scr_2;
%1.06.2005, 19-39

be=round( get(f6ssd1,'value')/time_step+1);
en=be+sig_show_step_v;
if en>smp_num
   en=smp_num;
   be=en-sig_show_step_v;
end
%%%%%%%%%%%%%%% added on 18.02.2005
set(und,'ydata',undln(be:en),...
   'xdata',be:en,...
   'color',[1 0 0],'linewidth',7);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f6ld1=line('parent',f6ad1,'linewidth',2,...
   'ydata',signn(be:en),...
   'xdata',be:en);
set(f6ad1,'xtickmode','manual',...
   'xlim',[be en],'xtick',be:1/time_step:en,...
   'xticklabel',[be-1:1/time_step:en]*time_step);