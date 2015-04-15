%============ Масштабирование мат вейвлетов
% 19.01.10

clear all; close all; clc;
Fs = 256;

load epileptiform_complexes_17y_P4;
ComplexNo = 5;                      % Выбор комплекеса
wave=ec{ComplexNo}-mean(ec{ComplexNo});
norma=sqrt(sum(wave.*wave));
wave=wave/norma;

wave = wave*2e2;
len_wavelet=length(wave);
dur_wavelet=(len_wavelet-1)/Fs;
% rangeStart = 15e-3;     % Вводим диапазон
% rangeEnd = 200e-3;      %

rangeStart = 0.5;     % Вводим диапазон
rangeEnd = 1.1;      %
distribution = 2;       % Выбираем распеделение 1-Gaussian, 2-Uniform
quantity = 5;           % Кол-во масштабированных м. вейвлетов
variance = 0.25;        % (Только для нормального распределения)

scales = range(rangeStart,rangeEnd,dur_wavelet,distribution,quantity,...
    variance);


scl = length(scales);
scld_wave = {scales};

for i=1:scl
    current_grid= linspace(1,length(wave),floor(length(wave)*scales(i)));
    scaledlWave(i)={spline(1:length(wave),wave,current_grid)};
%     subplot(scl+1,1,i); plot(0:1/Fs:length(scaledlWave{i})/Fs-1/Fs,scaledlWave{i});
end
% subplot(scl+1,1,i+1);
% plot(0:1/Fs:length(wave)/Fs-1/Fs,wave);
% title('scaled wavelet'); grid;


WSM = wave;
save MotherWavelet WSM
save waves1 scaledlWave


% Вставляем

clear all;
Fs = 256;

load waves1;            % Загружаем комплексы
load EEG_model_take_1;   % Загружаем сигнал

signal= h.data;

distance = 5;            % В секундах
distance = ceil(distance*Fs);
bias = 5;                % Вставляем с этого момента, в сек
bias = ceil(bias*Fs);
% signal(1:2000)=0;
sum = 1;                 % 1 - замещение шума комплексом, 2 - суммирование
complexNoise = 3e-1; % Сравнимо с амплитудой окружающего сигнала, коэффициент

h.data = insert(signal,scaledlWave,size(signal,2),distance,bias,sum,...
    complexNoise);
signal = h.data;
% figure; 
% for i=1:size(signal,1)-10
%     subplot(size(signal,1)-10,1,i); 
%     plot(0:1/Fs:length(signal(i,:))/Fs-1/Fs,signal(i,:));
% end
% length(signal(1,:))
% plot(0:1/Fs:length(signal(1,1000:2000))/Fs-1/Fs,signal(1,1000:2000));
% title('Signal with inserted waveforms'); grid on; 
% xlabel('time');ylabel('magnitude');
save noisedWithComplexes h

clear all;
load noisedWithComplexesTest
load MotherWavelet 
Fs = 256;

signal = h.data(1,:);
B=[1:1:size(signal,2)];
A = [1 1.2];            % Первый должен быть 1, для сравнения

[waves,coefs]=cwd3(signal,WSM,A,B);

% figure; imagesc(abs(coefs));
% xlabel('Time Shifts');ylabel('Scales');
% set(gcf,'color',[1 1 1]);
% colorbar;colormap('winter');
% set(gca,'ytick',1:length(A),'YTickLabel',[]);
% title('CWT coefficients');
% set(gcf,'color',[1 1 1]);
% 
% figure; plot(sum(abs(coefs))); grid on;
% xlabel('Time Shifts');ylabel('Magnitude');
% set(gcf,'color',[1 1 1]);


maxCriteria = 70;      % Критерий относительно максимального коэф, в проц
Match = 55;            % Абсолютное совпадение, в процентах
sites = detection(coefs,Match,maxCriteria);




detect = underlining(sites,coefs,waves);


detectExample = detect(1,:);
wavesExample = waves{1};
complexesOverlap=50;    % Перекрытие комплексов, в процентах

[sensitivity selectivity] = parameters(detect(2:end,:), ...
    detectExample,wavesExample,complexesOverlap);




% plots

    subplot(3,1,1)
imagesc(abs(coefs));
xlabel('Time Shifts');ylabel('Scales');
set(gcf,'color',[1 1 1]);
colormap('winter');
set(gca,'ytick',1:length(A),'YTickLabel',[]);
title('CWT coefficients');
set(gcf,'color',[1 1 1]);

    subplot(3,1,2)
plot(1:size(coefs,2),detect(1,:));
XLIM([0 length(coefs)]);
xlabel('Time Shifts');ylabel('Criteria');

    subplot(3,1,3)
plot(1:size(coefs,2),detect(2,:));
XLIM([0 length(coefs)]);
xlabel('Time Shifts');ylabel('Criteria');
    
% figure; surf(abs(coefs));


