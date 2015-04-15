% time localization of epileptiform complexes by CWT
% called from GV menwav
% 04.02.2010 
% 30.05.2010 - new version of complexes detection (without additional
%               functions), THRESHOLDING


%%%%%%%%%
clc;
clear ccc m wl detect coefs;
% setting zeroes instead of artefacts, eyes_open and  eyes_closing(using labels)
% see _scr_1 for details
[I,J]=find(ff==9); % 9 is the code for ARTIFACT
[I1,J1]=find(ff==1); % 1 is the code for eyes open
[I2,J2]=find(ff==2); % 2 is the code for eyes open
%%%%%%%%%%%%%
% cropping the part of interest from the entire signal
B=A(1:19,:); % <--- all signal for now

%%%%%%%%%%%%%%%%%%%%%%%
% removing 0.5 sec before and after artifact
ttr=round(h.SampleRate/2);% 128
for i=1:length(I)
   B(:,(ff(I(i),1)-ttr):(ff(I(i),1)+ttr) )=0;% positions of artifact labels are ff(I,1)
end
for i=1:length(I1)
   B(:,(ff(I1(i),1)-ttr):(ff(I1(i),1)+ttr) )=0;% positions of artifact labels are ff(I1,1)
end
for i=1:length(I2)
   B(:,(ff(I2(i),1)-ttr):(ff(I2(i),1)+ttr) )=0;% positions of artifact labels are ff(I2,1)
end
tot_art_len=length(I)+length(I1)+length(I2);
clear J J1 J2 i I I1 I2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% extracting the part of whole matrix (free of artefacts)
% B=B(:,s_beg:s_end);% extracting the part of interest from the entire signal




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% visualizing
% wl=-1000*ones(1,smp_num);
% 
% wl=ones(1,smp_num)*(10*70+20);


% load noisedWithComplexes
% load MotherWavelet 
load setfun; % адапт мат вейв
Multiplier = 2e2;
complex = setfun*2e2; % увелич ампл мат в
wave=complex-mean(complex); % Адаптивный мат вейвлет
norma=sqrt(sum(wave.*wave));
wave=wave/norma;

% figure; plot(0:1/Fs:length(wave)/Fs-1/Fs,wave*100,'k');
% xlabel('Time, s'); ylabel('V,mkV'); grid;


signal = h.data(ln,:); % выбор канала
BBB=1:length(signal);
%%%%%%%%%
% creating the range of scaling coefficients for CWT
rangeStart = 0.5;     % Вводим диапазон
rangeEnd = 1.1;      %
distribution = 2;       % Выбираем распеделение 1-Gaussian, 2-Uniform
quantity = 5;           % Кол-во масштабированных м. вейвлетов
variance = 0.25;        % (Только для нормального распределения)
dur_wavelet = (length(wave)-1)/h.SampleRate;

% скейлы, можно задать в ручную для вп
AAA = range(rangeStart,rangeEnd,dur_wavelet,distribution,quantity,...
    variance,h.SampleRate); 
AAA=[.5:.1:1.1];

%%%%%%%%%%%%%%%%%%%%%%%%%
%
[waves,coefs]=cwd3(signal,wave,AAA,BBB); % вейвл преобразование
coefs = abs(coefs); % модуль
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% для получения среднего коэффициента для фоновой ЭЭГ (первая секунда)
backgroundSum = sum(sum(coefs(:,1:h.SampleRate)))/h.SampleRate;

%%%%%%%%%%%%%
% получение суммы вейвл коэффициентов
coefsSum=sum(coefs);
% coefsSum = coefsSum - backgroundSum;

% %%%%%%%%%%%%%%%%%%%%
% % Thresholding - 30.05.2010
 thr=backgroundSum;
%
% % SOFT, will work only without preliminary taking absolute value!!!!
% [v ind]=find(coefs>=thr);
% coefs(ind)=coefs(ind)-thr;
% [v ind]=find(coefs<=-thr);
% coefs(ind)=coefs(ind)+thr;
% [v ind]=find(abs(coefs)<thr);
% coefs(ind)=0;
% 
% HARD
[v ind]=find(coefs>=thr);
coefs(ind)=0;
clear v ind;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% % figure; imagesc(coefsSum);
% % xlabel('Time Shifts');ylabel('Scales');
% figure; plot(0:1/Fs:length(coefsSum)/Fs-1/Fs,coefsSum);
% set(gcf,'color',[1 1 1]);
% colorbar('peer',coefsSum); colormap('winter');
% set(gca,'ytick',1:length(A),'YTickLabel',[]);
% title('CWT coefficients');
% set(gcf,'color',[1 1 1]);
% 
% figure;
% plot(0:1/Fs:length(coefsSum)/Fs-1/Fs,coefsSum);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Критерий относительно макс коэф, проценты
Match = 1;
coefs=coefsSum;
%%%%%%%%%%%%%%%%%%%%%%
complexLength=length(wave);
coefMax= max(coefs);
i=1;% first sample
detect=-1000*ones(size(coefs));% for values of coefficients where complexes detected
while i<=smp_num-complexLength;
    if coefs(i)>=Match*coefMax
        [c_val c_place]=max(coefs(i:i+complexLength));
        detect(i+c_place:i+c_place+complexLength)=80*(ch_num-ln);
        i=i+c_place+complexLength;
    end
    i=i+1;
end

wl = detect;
wll=line('parent',a1,'color','red',...
   'linestyle','none','marker','.','markersize',5,...
   'MarkerFaceColor','blue',...
   'buttondownfcn','');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% inserting the processed part of the matrix into initial matrix and plotting
A=B; % A(:,s_beg:s_end)=B;
GalileoView_scr_9;


