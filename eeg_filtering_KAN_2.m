% filtering trials
close all
clear all
clc
h=gtfopen('LJ000003.GTF');
B=-1*transpose(h.data);
Fs=h.SampleRate;
N=size(B,2);% rows
time_step=1/256;
t=0:time_step:(N-1)*time_step;
A=B(1,:);
figure
plot(A(1:1000))
title('do');
cor=zeros(size(A));
cor=(  (A(:,N)-A(:,1))/(N-1)  )*[0:N-1];
A=A-cor;

y=fft(A);
%e=ifft(y);
% figure
% plot(real(e(1:1000)))

%%%%%%%%%%%%%]
%nums=(50000:51000);
%new=real(ifft(      2*y (:,1)    )      );
%figure
%plot(t(nums),A(nums,1),t(nums),new(nums));
%legend('OLD','NEW')
%grid
%%%%%%%%%%%%%%%%%%%%

%m=abs(y(:,1));
m=abs(y(:));

f=(0:length(y)-1)*Fs/length(y); % frequency vector

figure
plot(f(1:round((N-1)/2)),m(1:round((N-1)/2)))
set(gca,'XTick',[1 3 5 10 15 40 50 60 85]);
grid
title('Magnitudes')

%%%%%%%%%%%%%
load a4hh;
spf=interp1(0:length(wave)-1,wave,f,'nearest','extrap');
%spf=ones(1,length(y));

figure
plot(f(1:round((N-1)/2)),...
    spf(1:round((N-1)/2)).*m(1:round((N-1)/2))')
set(gca,'XTick',[1 3 5 10 15 40 50 60 85]);
title('spectrum after rejection')

%%%%%%%%%%%%%%%%%%
%%%%%%%
%xxx=abs(ifft(y(:,1))); 
%xxx=real(ifft(m));% 
%xxx=abs(ifft(spf'.*y(:,1)));% 

%xxx=abs(spf(1:round((N-1)/2)).*m(1:round((N-1)/2))');
%xxx=ifft(y);
xxx=ifft(spf(1:round((N-1)/2)).*y(1:round((N-1)/2)));

figure
plot(real(xxx(1:1000)))
title('posle vosst');