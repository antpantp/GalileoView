% diss 1
close all
clear all
%save 'diss_sign' ss1 ss2 ss3

load fun_diss;
ss=WSM;
for i=1:3
   ss(i,:)=ss(i,:)/max(ss(i,:));
end
sss=sum(ss)/max(sum(ss));
load rod_kompl_diss;
sig=sig/max(sig);

sp=fft(ss');
r_m=mean(real(sp));
i_m=mean(imag(sp));
k=.5; 

[m,n]=size(sp);
I=70;
vzk=zeros(I+1,n);
vzk(1,:)=(ss*sig)';
for i=1:I
   sn=rand(m,n)*k*r_m+j*rand(m,n)*k*i_m;
   sr=sp+sn;
   s=ifft(sr);
   signal=abs(s);
   vzk(i+1,:)=(signal'*sig)';
end
figure
plot(vzk,'k.-')
grid

figure
plot(signal)
grid

   
