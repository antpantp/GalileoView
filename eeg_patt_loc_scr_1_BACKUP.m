% script #1 for coefficients calculation program eeg_pattern_loc

% calculaing the projections of selected lead on overcomplete
% function set from file
% 
% 01.06.2005 18-31

wt3=uicontrol('style','text','string','Wait please',...
   'FontWeight','bold','fontsize',10,'foregroundColor',[1 0 0],...
   'units','normalized',...
   'position',[.31 .855 .079 .09]);
pause(.01);
[fun_num,fun_len]=size(F);
prj=zeros(1,fun_num);

% signal to analyse is taken from matrix without norming
signal=sig;

coef=2*max(signal)*ones(size(signal));
for s=1:w_stp:length(signal)-fun_len %!!!!!!!!!!!!!
   vector=signal(s:s+fun_len-1);
   for i=1:fun_num
      %% minimal maximum distance between function and vector
      nzi=find(F(i,:));
      prj(i)=max(abs(vector(nzi)-F(i,nzi)));%/length(nzi);
   end
   coef(s)=min(prj);% for new rule from 30.01.2005
   
   set(wt3,'string',strcat('Window # ',...
      num2str(s),' of ',num2str(length(signal)-fun_len)),...
      'foregroundColor',[0 0 1]);
end
set(wt3,'visible','off');
delete(wt3);
pause(.1);
set(fpb3,'visible','on');

% added 2.12.2004
clear fun_num w_stp  prj s i nzi step %signal  fun_len