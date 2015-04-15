% diss 1
close all
clear all
%save 'diss_sign' ss1 ss2 ss3

load fun_diss;
ss=WSM;
%ss=[ss1(1:126)+5; ss3(1:126)+130; ss2(1:126)+255];
%ss=[ss1(1:126); ss3(1:126); ss2(1:126)];
%WSM=ss;
%save 'fun_diss' WSM
%noise=rand(1,length(ss1))*5;
%ss=[ss1/max(ss1); ss2/max(ss2); ss3/max(ss3)];

sss=sum(ss)/max(sum(ss));

load rod_kompl_diss;
sig=sig/max(sig);

for i=1:3
   figure;
   plot(ss(i,:));   %,'k.-')
   grid on
   vz(i)=ss(i,:)*sig;
end

%%%%
figure
plot(sig)
grid on

figure
plot(sss-sig')
grid on

Sp=fft(ss');
%Sm=abs(Sp);

[m,n]=size(Sp);
sn=zeros(m,n);
b=2;
for k=[3 5 30]
   sn(b:k+1,:)=Sp(b:k+1,:);
   sn(m-k+1:m,:)=Sp(m-k+1:m,:);
   sn(k+2:m-k-1,:)=0;
   sr=abs(ifft(sn));
   figure
   plot(sr)
   
end

%b=20;
%k=63;
%sn(b:k+1,:)=Sp(b:k+1,:);
%sn(m-k+1:m,:)=Sp(m-k+1:m,:);
%sn(k+2:m-k-1,:)=0;

%sr=abs(ifft(sn));
%figure
%plot(sr)



%figure
%plot(Sm')
%grid on

%sp1=Sm(:,1);
%figure
%plot(sp1)


%WSM=[ss1(1:126)/max(abs(ss1(1:126))); ss2(1:126)/max(abs(ss2(1:126))); ss3(1:126)/max(abs(ss3(1:126)))];
%save 'set_diss' WSM
%cc=cov_in_wind(ss,130,1);
%[v,d]=eig(cc);%
%figure
%plot(v(:,1))
