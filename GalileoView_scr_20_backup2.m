% file for paroxismal index menu 
% EEG preprocessing
% called from gw
% 14.01.2007 13.38
% 11.02.2007 13:16
% 25.02.2007 15:23

%%%%%%%%%
clc;

% setting zeroes instead of artefacts, eyes_open and  eyes_closing(using labels)
% 
% see _scr_1 for details

[I,J]=find(ff==9); % 9 is the code for ARTIFACT
[I1,J1]=find(ff==1); % 1 is the code for eyes open
[I2,J2]=find(ff==2); % 2 is the code for eyes open


B=A(1:19,:);
% remove 0.5 sec before and after artifact
ttr=128;
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
B=B(:,s_beg:s_end);% extracting the part of interest

% indicies of groups of EEG leads
incs={1:6; 7:12; 13:19}; 
%incs={1:4; 5:8; 9:12; 13:16; 17:19};
%incs={1:19};
%incs={1:10; 11:19};



% wavelet processing
% scales
scls=[.08 .1 .12 .13 .15 .17 .2 .22 .25];
% translations
trns=[1:5:length(B)];

ccc=zeros(size(incs,1),length(trns)); % matrix for resulting coefficients for all groups

for i=1:size(incs,1)
   BB=sum(B(cell2mat(incs(i,:)),:));% summarizing
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%
   % creation of mother wavelet on the effective support
   % adaptive wavelet
   load set1;
   out1=F-mean(F);
   out1=out1/sum(out1.^2);
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % decomposition
   [f,c]=cwd1(BB,out1,scls,trns);
   clear f out1;
      
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %thresholding
   %soft
   thr=mean(max(c))
   c(abs(c)<thr)=0;
   c(c>=thr)=c(c>=thr)-thr;
   c(c<=-thr)=c(c<=-thr)+thr;
   
   % summarizing and norming
   cc=sum(c); 
   cc=cc/max(abs(cc));
   
   % thresholding again the sum of all rows
   thr=.2;% 0.2 is not bad
   cc(abs(cc)<thr)=0;
   cc(cc>=thr)=cc(cc>=thr)-thr;
   cc(cc<=-thr)=cc(cc<=-thr)+thr;
   
   ccc(i,:)=cc;
    
end;

%resulting matrix of group wavelet coefficients processing
for i=2:size(ccc,1)
   ccc(1,:)=ccc(1,:).*ccc(i,:);
end

% finding the non-zero elements of the absolute value
[I,J]=find(ccc(1,:));







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%visualizing
%places:
pl=-1000*ones(1,smp_num);
%pl(s_beg+trns-1)=1;

%pl(s_beg+J-1)=1;

for i=1:length(J)
   pl(s_beg+trns(J(i))-1:s_beg+trns(J(i))-1+ 128)=10*70+20;
end
pll=line('parent',a1,'color','red',...
   'linestyle','none','marker','.','markersize',5,...
   'MarkerFaceColor','blue',...
   'buttondownfcn','');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% inserting the processed part of the matrix into initial matrix and plotting
%A(:,s_beg:s_end)=B;

GalileoView_scr_9;


% evaluating the indises
% percentage of exceeding over the background
% paroxism duration to trial duration ratio
[I,J]=find(pl==720);
q=strcat('Paroxism duration/trial duration Ratio =', num2str(100*length(J)/smp_num),' %'); %-128*tot_art_len % ????????????
disp(q)



% paroxism average amplitude to background average amplitude ratio
pa=mean(mean(abs(A(:,J))));
[I,J]=find(pl==-1000);
pb=mean(mean(abs(A(:,J))));
q=strcat('Paroxism average amplitude/trial average amplitude =', num2str(100*pa/pb),' %');
disp(q)


clear tot_art_len q;