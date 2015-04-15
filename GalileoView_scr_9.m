% script for GalileoView
% plots the part of multichannel signal 
% when the slider is moved
% called from GalileoView_scr_1
% 29.04.2005
% modified on 04.02.2010 with line for CWT-based localization of complexes

begs=round(get(sss,'value')/time_step+1);
ens=begs+sig_show_step;
if ens>smp_num
   ens=smp_num;
   begs=ens-sig_show_step;
end

%%%%%%%%%%
% line for CWT-based localization of complexes  called from _scr_24
% 04.02.2010
set(wll,'ydata',wl(begs:ens),...
        'xdata',[begs:ens]);


%%%%%%%%%
%modified with "if" statement on 28.04.2008 (for DX EEG using)
% added 17.01.2006 line with user marks
if ~isempty(ff)
    set(ull,'ydata',ul(begs:ens),...
        'xdata',[begs:ens]);
    set(cll,'ydata',cl(begs:ens),...
        'xdata',[begs:ens]);
    %%%%%%%%%
    % added 10.02.2007 Line to mark the paroxysmal activity. Called from _scr_20
    set(pll,'ydata',pl(begs:ens),...
        'xdata',[begs:ens]);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 15.04.2015 -- added line for "Events of Interest" marks
if ~isempty(events_line)
    set(events_line_l,'ydata',events_line(begs:ens),...
        'xdata',[begs:ens]);
end
%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:ch_num
set(l_hnd(indss(i)),...
    'ydata',scale*A(indss(i),begs:ens)+70*(ch_num-i+1),...
    'xdata',[begs:ens]);% take marks for 19 channel variant!
end

set(a1,'xtick',begs:SampleRate:ens,...
   'xticklabel',[begs-1:SampleRate:ens]*time_step,...
  'xlim',[begs ens]);

set(l_hnd,'visible','on');