% filtering trials
close all
clear all
clc


load a_file; % file with A matrix from 17a.gtf
N=size(A,1);
time_step=1/256;
t=0:time_step:(N-1)*time_step;
Fs=256;
y=fft(A);
%%%%%%%%%%%%%]
%nums=(50000:51000);
%new=real(ifft(      2*y (:,1)    )      );
%figure
%plot(t(nums),A(nums,1),t(nums),new(nums));
%legend('OLD','NEW')
%grid
%%%%%%%%%%%%%%%%%%%%


tic
m=abs(y(:,1));
toc
'Magnitudes Done'

f=(0:length(y)-1)*Fs/length(y); % frequency vector

figure
plot(f(1:round((N-1)/2)),m(1:round((N-1)/2)))
set(gca,'XTick',[15 40 60 85]);
grid
title('Magnitudes')


%%%%%%%%%%%%%
load a4hh;

spf=interp1(0:length(wave)-1,wave,f,'nearest','extrap');

%figure
%plot(f(1:round((N-1)/2)),spf(1:round((N-1)/2)).*m(1:round((N-1)/2))')
%set(gca,'XTick',[15 40 60 85]);
%title('spectrum after rejection')


%%%%%%%%%%%%%%%%%%
%%%%%%%

%xxx=abs(ifft(y(:,1))); 
%xxx=real(ifft(m));% 
xxx=abs(ifft(spf'.*y(:,1)));% 

nums=(50000:51000);
figure
plot(t(nums),A(nums,1),t(nums),xxx(nums));
legend('OLD','NEW')
grid





