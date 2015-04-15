% filtering trials
close all
clear all
clc
h=gtfopen('LJ000003.GTF');
B=-1*transpose(h.data);
Fs=h.SampleRate;
N=size(B,2);% rows
A=B(1,:);



% Fs=256;
% 
% A=rand(1e5,1)+j*rand(1e5,1);
% N=1e5;
% %%%%%%
% % Gibbs ph. removal
% cor=zeros(size(A));
% cor=(  (A(:,N)-A(:,1))/(N-1)  )*[0:N-1];
% A=A-cor;
% % %%%%%%%%%%%%%%%%%%%%%%

y=fft(A);
m=abs(y(:));
f1=(0:length(y)-1)*Fs/length(y); % frequency vector

f=f1;
figure
plot(f,m)
% set(gca,'XTick',[10 30 50 70 85]);
% grid
title('Magnitudes')

%%%%%%%%%%%%%
load a4hh;

spf=zeros(size(y));
f1=(0:length(y)-1)*Fs/length(y); % frequency vector
ww=[0:inc:length(wave)-1]*inc;
if length(ww)>=1e4
    ww=ww(1:1e4);
end

sp=interp1([0:length(wave)-1]*inc,wave,f1,'nearest','extrap');

spf(1:round((N-1)/2))=sp(1:round((N-1)/2));
spf(N:-1:N-round((N-1)/2)+2)=sp(2:round((N-1)/2));

figure
plot(f,spf.*m')
% set(gca,'XTick',[1 2 3 4 5 6 7 8 10 30 50 70 85],'ylim',[0 2.5e5]);
% grid on
title('spectrum after rejection')

xxx=ifft(spf.*y);

figure
plot(1:1000, real(A(1:1000)), 1:1000, real(xxx(1:1000)))
legend('do', 'posle')
grid

%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%



%
%%%%%%%%%%%%%%%%%%
%A=real(xxx);

A=B(1,:);


% % %%%%%%
% % Gibbs ph. removal
% cor=zeros(size(A));
% cor=(  (A(:,N)-A(:,1))/(N-1)  )*[0:N-1];
% A=A-cor;
% % %%%%%%%%%%%%%%%%%%%%%%




y=fft(A);
m=abs(y(:));
f1=(0:length(y)-1)*Fs/length(y); % frequency vector

f=f1;
figure
plot(f,m)
% set(gca,'XTick',[10 30 50 70 85]);
% grid
title('Magnitudes')

%%%%%%%%%%%%%
load a4hh;

spf=zeros(size(y));
f1=(0:length(y)-1)*Fs/length(y); % frequency vector
ww=[0:inc:length(wave)-1]*inc;
if length(ww)>=1e4
    ww=ww(1:1e4);
end

sp=interp1([0:length(wave)-1]*inc,wave,f1,'nearest','extrap');

spf(1:round((N-1)/2))=sp(1:round((N-1)/2));
% spf(N:-1:N-round((N-1)/2)+2)=sp(2:round((N-1)/2));

figure
plot(f,spf.*m')
% set(gca,'XTick',[1 2 3 4 5 6 7 8 10 30 50 70 85],'ylim',[0 2.5e5]);
% grid on
title('spectrum after rejection')

xxx=ifft(spf.*y);

figure
plot(1:1000, real(A(1:1000)), 1:1000, real(xxx(1:1000)))
legend('do', 'posle')
grid

