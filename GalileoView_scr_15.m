% script for GalileoView
% preliminary settings for 
% ploting the part of multichannel signal 
% when the slider is moved

% sets montages!!

% called from GalileoView_scr_1 after

% 08.08.2005
%28.04.2008



Yticks=70*[1:ch_num];% i
% Marks of Galileo
% Ymarks={ 'F1';'F2';'F7';'F3';'Fz';'F4';'F8';...
%         'T3';'C3';'Cz';'C4';'T4';'T5';...
%         'P3';'Pz';'P4';'T6';'O1';'O2';...
%         'X1';'X2';'X3';'X4';'X5'};
% Marks of DX System    
% Ymarks={ 'Fp1';'Fp2';'F7';'F3';'Fz';'F4';'F8';...
%         'T3';'C3';'Cz';'C4';'T4';'T5';...
%         'P3';'Pz';'P4';'T6';'O1';'O2';...
%         'none';'none';'none';'none';'none'};

% Marks for Kharitonov    
Ymarks={'Fp1-A1','Fp2-A2','F7-A1','F3-A1',...
'Fz-A1','F4-A2','F8-A2','T3-A1',...
'C3-A1','Cz-A2','C4-A2','T4-A2',...
'T5-A1','P3-A1','Pz-A1','P4-A2',...
'T6-A2','O1-A1','O2-A2'};


   
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for montages!!!
% To create custom montage use PLACES=[...]
% with the desired arrangement of lead occurences
% from Ymarks

indss_m=zeros(ch_num,ch_num);

% mont. #1 -- initial placement of Galileo
%places=[1:19];
% mont. #2
% places=[1 2 3 7 4 6 5 9 11 10 8 12 14 16 15 13 17 18 19];

% mont. #3 -- Kharitonov
places=[1:19];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



for i=1:ch_num
    indss_m(i,places(i))=1;
end
indss=indss_m*[1:ch_num]';

% permutation for proper lead marks placement!
% to show all leads (with X5-X1) we need to remove the line "ch_num=19" in scr_1
set(a1,'ytick',Yticks,...
    'yticklabel',Ymarks(rot90(diag(ones(1,ch_num),0))*indss),...
    'ylim',[-70 70*(ch_num+1) ]);

%%%%%%%%%%%%%
%
for i=1:ch_num
   l_hnd(indss(i))=line('parent',a1,'linewidth',1,...
       'buttondownfcn',...
       'l=gco; ln=find(l_hnd==l); set(plb,''enable'',''on'');set(sn1,''string'',get(gco,''userdata'')); c=get(a1,''currentpoint'');',...
       'userdata',Ymarks(indss(i)),'visible','off');% take marks for 19 channel variant!!!!!
end

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

GalileoView_scr_9;
