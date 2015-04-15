% script #1 for eeg_pattern_loc_coef_visual
% creating the DETALED plot of coefficients
% 01.06.2005

delete(get(ad4,'children'));
ld4=line('parent',ad4,'linewidth',.5,'buttondownfcn',...
   'C=get(ad4,''currentpoint'');sd=uicontrol(''style'',''text'',''string'',num2str(round(C(1,1))),''units'',''normalized'',''FontWeight'',''bold'',''fontsize'',12,''position'',[.71 .43 .1 .03]   );       ');
%selecting :0)
dcoef=2*max(coef)*ones(1,clll);
ind=find(coef<=thr);
dcoef(ind)=coef(ind);
set(ld4,'ydata',dcoef,'xdata',1:clll,...
   'MarkerSize',16,'marker','.','LineStyle','none');
set(ad4,'ylim',[-1 1.1*thr],'xlim',[1 clll]);
%clear dcoef 
