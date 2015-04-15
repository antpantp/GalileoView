
% filtering trials
close all
clear all

Fs=256;% sampling frequency

t=(0:1/Fs:1); % time base
N=length(t);
x=sin(2*pi*15*t) + sin(2*pi*40*t);% signal
figure
plot(t,x)
grid

y=fft(x);
%yy=fftshift(y);
m=abs(y); 
p=unwrap(angle(y)); % mag. and phase
f=(0:length(y)-1)*99/length(y); % frequency vector

figure
plot(f,m)
%set(gca,'XTick',[15 40 60 85]);
grid
figure
plot(f,p*180/pi)
set(gca,'XTick',[15 40 60 85]);
grid
%%%%%%%%%%%%%%%%%%

filter=ones(size(f));
%filter()=0;

%%%%%%%%%

figure
plot(t,real(ifft(filter.*m)));
grid


