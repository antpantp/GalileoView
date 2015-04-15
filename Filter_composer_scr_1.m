%script #1 for FilterComposer
% called after slider on the plot is moved
% 15.08.2005 20-02

fbeg=round(get(fs,'value')*totpts)+1;
fen=fbeg+5;% 5 samples of FR to see per window
if fen>totpts
   fen=totpts;
   fbeg=fen-5;
end
set(l,'ydata',wave(fbeg:fen),...
   'xdata',fbeg:fen);
set(a,'xtick',[fbeg:fen],...
    'xlim',round([fbeg fen]),...
   'xticklabel',[fbeg-1:fen]*inc);
%     
% 