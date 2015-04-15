%script #25 for GalileoView
% 
% called from GalileoView,
% saves the current EEG signal in the txt-file in the DX-System format
% the name is the same as initial signal with suffix _filtered

% 13.03.2010
% IS NOT IN USE!!!!

fname_new=strcat(fname(1:end-4),'_filtered.txt');
zer=zeros(2,size(A,2));
Af=[A; zer]; clear zer;
fid=fopen(fname_new,'wt');
firstline = 'Fp1\tFp2\tF7\tF3\tFz\tF4\tF8\tT3\tC3\tCz\tC4\tT4\tT5\tP3\tPz\tP4\tT6\tO1\tO2\tECG\tМаркеры\n';
fprintf(fid,firstline);
fclose(fid);
fid=fopen(fname_new,'at');
%fprintf(fid,'%6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f %6.3f\n',Af)
fprintf(fid,'%6.3f\t%6.3f\t%6.3f\t%6.3f\t%6.3f\t%6.3f\t%6.3f\t%6.3f\t%6.3f\t%6.3f\t%6.3f\t%6.3f\t%6.3f\t%6.3f\t%6.3f\t%6.3f\t%6.3f\t%6.3f\t%6.3f\t%6.3f\t%6.3f\n',Af)
fclose(fid);
[FILENAME,PATHNAME, FILTERINDEX] = uiputfile('*.m','Save current EEG signal as...');