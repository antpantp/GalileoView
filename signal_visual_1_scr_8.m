% adding the rises/lowings to concatenated
% waveforms in the set -- by _scr_8
% 7.10.2004, 11-15
% is recalled from _scr_7


% F(str, stb) + rsa
rsa_l=length(rsa);
F_n=zeros(str*rsa_l,stb);
cntr=1;
for i=1:rsa_l
   for j=1:str
      F_n(cntr,:)=F(j,:)+rsa(i);
      cntr=cntr+1;
   end
end
clear F i cntr;
F=F_n; % new set
set(nft,'visible','on','string',strcat('We have obtained `',num2str(str*rsa_l),' functions in the new set.'))
clear F_n rsa_l;
