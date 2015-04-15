% script #1 for coefficients calculation program eeg_pattern_loc

% calculaing the projections of selected lead on overcomplete
% function set from file
% 
% 01.06.2005 18-31
% 11.06.2005 15-22

wt3=uicontrol('style','text','string','Wait please',...
   'FontWeight','bold','fontsize',10,'foregroundColor',[1 0 0],...
   'units','normalized',...
   'position',[.31 .855 .079 .09]);
pause(.01);

%F=F;% functions are columnwise now 
[fun_num,fun_len]=size(F);%!!!!!!!!!!!!!!!!
[nzss,nzsb]=find(F);
l=sub2ind([fun_num,fun_len],nzss,nzsb);% non-zeros locations 
																%in functions
vecs=zeros(fun_num,fun_len);%places for signal replication

% signal to analyse is taken from matrix without norming
signal=sig;
ms=2*max(signal);
coef=ms*ones(size(signal));
for s=1:w_stp:length(signal)-fun_len %!!!!!!!!!!!!!
   res=zeros(fun_num,fun_len);%results for current window
   vecs=repmat(signal(s:s+fun_len-1),fun_num,1);
   res(l)=abs(F(l)-vecs(l));
   coef(s)=min(max(res.'));% 
   set(wt3,'string',strcat('Window # ',...
      num2str(s),' of ',num2str(length(signal)-fun_len)),...
      'foregroundColor',[0 0 1]);
end
set(wt3,'visible','off');
delete(wt3);
pause(.2);
set(fpb3,'visible','on');

% added 2.12.2004
clear l fun_num w_stp ms s i nzi step %signal  fun_len