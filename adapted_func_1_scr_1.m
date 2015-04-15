% script file for adapted_func_1
% adds one waveform to the existing waveset matrix
% and evaluates the new set function
% if the functions have the lengths not equal,
% the new insert will be lengthened or shortened to fit the functions
% already in the matrix

% changed on 07.06.2005, 9-52
% removed: norming of waveset matrix (here was    norming1(WSM)   ) and 
% norming of obtained eigenvector (here was    setfun=(-1)*eigvect_ch(:,c)/max(abs(eigvect_ch(:,c)));)


% added on 02.08.2005, 11-18
% added multiplacation of resulting eigenvector by
% the "averaged" amplitude to preserve the amplitude

if get(aleb,'Userdata')==1% we use the existing set of functions,
   % we don't add new waveform to it 
   load(get(afn,'string'));
   [r,c]=size(WSM);
   
   % added 02.08.2005
   %
   rr=mean(max(WSM'))
   [eigvect_ch,prom]=...
       eig(cov_in_wind(WSM,c,1));
   eigvect_ch(1:20,c)
   eigvect_ch(1:20,c)/max(abs(eigvect_ch(:,c)))
   
   setfun=(-1)*rr*eigvect_ch(:,c)/max(abs(eigvect_ch(:,c)));
   %
   %
   
   
   
   % is multiplied by -1 ???????  :)
   set([txt fcs],'visible','on');
   
else % we add another one function to the existing set
   load(get(afn,'string'));
   [r,c1]=size(WSM) % functions are arranged rowwise in the matrix
   c=max(c1,wf_end-wf_beg+1);% the length of all future waveforms
   new=zeros(1,c);
   new(1:wf_end-wf_beg+1)=sig(wf_beg:wf_end);
   WSM_1=zeros(r+1,c);
   WSM_1(1:r,1:c1)=WSM;
   WSM_1(r+1,:)=new;
   clear WSM r new;
   WSM=WSM_1;
   clear WSM_1;
   save(get(afn,'string'),'WSM');
   
   % added 02.08.2005
   %
   rr=mean(max(WSM'))
   [eigvect_ch,prom]=...
       eig(cov_in_wind(WSM,c,1));
   eigvect_ch(1:20,c)
   eigvect_ch(1:20,c)/max(abs(eigvect_ch(:,c)))
   
   setfun=(-1)*rr*eigvect_ch(:,c)/max(abs(eigvect_ch(:,c)));
   %
   %
  
   %[eigvect_ch,prom]=eig(cov_in_wind(WSM,c,1)); 
   %setfun=(-1)*eigvect_ch(:,c); 
   % is multiplied by -1 ???????  :)
   
   set([txt fcs fcrs txtc],'visible','on');
end
clear eigvect_ch prom c r rr;

