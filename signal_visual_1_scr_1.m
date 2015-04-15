%script #1 for signal_visualization program
% plots the multichannel signal on the existing axis
% called from signal_visual_scr_1

delete(get(a1,'children'));
dsr=1;% downsampling opened signal
A=ds_1(A,dsr); %!!!!!!!!!!!!!
clear l_hnd;
% time step (sec)
%time_step=.003 ;% eeg1_full
%time_step=.0029;% eeg2_full
time_step=.005;% eeg3_full;
time_step=1/128;
sec_to_see=10;
sig_show_step=floor(sec_to_see/(time_step*dsr));% samples number to see 1,5 sec of recordings

[ch_num,smp_num]=size(A);
l_hnd=zeros(1,ch_num);% handles for lines on the large plot
%slider for signal
sss=uicontrol('Style','slider','parent',f1,'Units','normalized', ...
   'Position',[.055 .017 0.8 0.04],'max',1,'min',0, ...
   'Callback','signal_visual_1_scr_9;  ',...
   'SliderStep',[0.01 0.1]);
signal_visual_1_scr_9;