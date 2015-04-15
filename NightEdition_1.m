% program for calculating coefficients for all
% signal using the set

% NightEdition_1


name='LJ00016t';
%name='LJ00000f';
%name='LJ00000c';
file_name=[name '.gtf'];
h=gtfopen(file_name);
A=-1*transpose(h.data);
smp_num=size(A,2);
time_step=1/h.SampleRate;

clear h;
%set_name='set_na';
set_name='set_187';
%set_name='set_ad'


load(set_name);% set function are in variable F arranged rowwise
[fun_num,fun_len]=size(F);%!!!!!!!!!!!!!!!!
[nzss,nzsb]=find(F);
l=sub2ind([fun_num,fun_len],nzss,nzsb);% non-zeros locations 
																%in functions
vecs=zeros(fun_num,fun_len);%places for signal replication


w_stp=2; % step to move time window
for ln=12 
   ln
   tic
   signal=A(ln,:);
   ms=2*max(signal);
   coef=ms*ones(size(signal));
   for s=1:w_stp:length(signal)-fun_len %!!!!!!!!!!!!!
      res=zeros(fun_num,fun_len);%results for current window
      vecs=repmat(signal(s:s+fun_len-1),fun_num,1);
      res(l)=abs(F(l)-vecs(l));
      coef(s)=min(max(res.'));% 
   end
   toc
   save(strcat('coef_', name,...
      '_ch', int2str(ln), '_Set_',set_name,'_step_',int2str(w_stp)),...
      'coef','ln','fun_len','signal','smp_num','time_step','F');
end