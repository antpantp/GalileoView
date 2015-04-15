%script #19 for GalileoView
% 
% called from GalileoView main window,
% evaluating the periodogram of the SEGMENT of selected lead using the Welch method
%(power spectral density)
  
% 25.11.2006 11-46
figure;
[bbb,fff]=pwelch(B,[],256,[],[],[],'half','squared');
plot(fff(1:40),bbb(1:40));grid on;

clear bbb %fff;
