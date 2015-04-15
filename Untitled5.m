% filtering trials
close all
clear all
clc
Fs=256;% sampling frequency

t=(0:1/Fs:20); % time base
N=length(t);
x=zeros(1,1*N);

x(1:N)=sin(2*pi*5*t) + sin(2*pi*10*t)+ sin(2*pi*15*t)+ sin(2*pi*20*t)+ sin(2*pi*30*t)+...
    sin(2*pi*40*t)+ sin(2*pi*50*t)+ sin(2*pi*60*t)+...
    sin(2*pi*70*t) + sin(2*pi*80*t)+ sin(2*pi*90*t)+ sin(2*pi*100*t)+...
    sin(2*pi*110*t)+sin(2*pi*120*t);

y=fft(x);
%yy=fftshift(y);
m=abs(y); 
p=unwrap(angle(y)); % mag. and phase
f=(0:length(y)-1)*Fs/length(y); % frequency vector
figure
plot(f(1:round((N-1)/2)),m(1:round((N-1)/2)))
set(gca,'XTick',[15 40 60 85]);
grid


%%%%%%%%%%%%%
load a4hh;

spf=interp1(0:length(wave)-1,wave,f,'nearest','extrap');

figure
plot(f(1:round((N-1)/2)),spf(1:round((N-1)/2)).*m(1:round((N-1)/2)))
set(gca,'XTick',[15 40 60 85]);
title('spectrum after rejection')
%%%%%%%%%%%%%%%%%%






%figure
%plot(f,p*180/pi)
%set(gca,'XTick',[15 40 60 85]);
%grid
%%%%%%%%%%%%%%%%%%


%%%%%%%%%

figure
plot(t,x,t,real(ifft(spf.*m)));
legend('OLD','NEW')
grid









