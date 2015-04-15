% script for GalileoView
% plots the part of multichannel signal 
% when the slider is moved
% called from GalileoView_scr_1
% 29.04.2005

delete(get(a1,'children'));
delete(get(al_l,'children'))
delete(get(al_r,'children'))

begs=round(get(sss,'value')/time_step+1);
ens=begs+sig_show_step;
if ens>smp_num
   ens=smp_num;
   begs=ens-sig_show_step;
end

Yticks=zeros(ch_num,1);
wwYmarks={ 'X5'; 'X4'; 'X3';'X2'; 'X1'; 'O2';'O1' ;...
      'T6' ;'P4'; 'Pz' ; 'P3'  ;'T5';'T4' ;'C4';...
      'Cz';'C3'; 'T3'; 'F8'; 'F4';'Fz' ; 'F3'; ...
      'F7';  'F2' ;'F1'};

Ymarks={ 'F1';'F2';'F7';'F3';'Fz';'F4';'F8';...
        'T3';'C3';'Cz';'C4';'T4';'T5';...
        'P3';'Pz';'P4';'T6';'O1';'O2';...
        'X1';'X2';'X3';'X4';'X5'};

%%%%%%%%%%%%%%%%%%%%%5
%for montages!!!
% permutation of indicies for Ymarks

% mont. #1 -- initial placement of Galileo
%indss=rot90(diag(ones(1,ch_num),0))*[1:ch_num]';

% mont. #2
indss_m=zeros(ch_num,ch_num);
places=[1 2 3 7 4 6 5 9 11 10 8 12 14 16 15 13 17 18 19];
for i=1:ch_num
    indss_m(i,places(i))=1;
end
indss=indss_m*[1:ch_num]';
%rot90(diag(ones(1,ch_num),0))*
%%%%%%%%%%%%%
for i=1:ch_num
   l_hnd(indss(i))=line('parent',a1,'linewidth',1,...
       'ydata',scale*A(indss(i),begs:ens)+70*(ch_num-i+1),...
       'xdata',[begs:ens],'buttondownfcn',...
       'l=gco; ln=find(l_hnd==l); set(sn1,''string'',get(gco,''userdata''));',...
       'userdata',Ymarks(indss(i)),'visible','off');% take marks for 19 channel variant!!!!!
Yticks(i)=70*(i);% i
end

%%%%%%
% setting the colors

% permutation for proper lead marks placement!
indss=rot90(diag(ones(1,ch_num),0))*indss;


% to show all leads (with X5-X1) we need to remove the line "ch_num=19" in scr_1
set(a1,'ytick',Yticks,'yticklabel',Ymarks(indss),...
    'ylim',[-70 70*(ch_num+1) ],...
    'xtick',begs:SampleRate:ens,...
   'xticklabel',[begs-1:SampleRate:ens]*time_step,...
  'xlim',[begs ens]);
%Ymarks(6:24)
set(l_hnd,'visible','on');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% labels with 50uV :

for i=1:3:ch_num
   l_lab_l(i)=line('parent',al_l,'linewidth',2,...
       'ydata',scale*Lab+70*(ch_num-i+1),...
   'xdata',[1:15],'color','red');
   l_lab_r(i)=line('parent',al_r,'linewidth',2,...
       'ydata',scale*Lab+70*(ch_num-i+1),...
   'xdata',[1:15],'color','red');
end
set([al_l al_r],'ytick',[],'xtick',[],'TickLength',[0 0],'ylim',[-70 70*(ch_num+1)]);

