%script #29 for GalileoView
% 
% called from GalileoView,
% Opens EEG signal stored in DX-created *.txt file, 
% made by V.A.
% fast conversion
% 18.06.2012

fid = fopen(strcat(pname,fname),'r')
%
% comma-to-dot substitution should go here
% tline = fgetl(fid);
% while tline ~= -1
%     tline = fgetl(fid)
%     if ~ischar(tline)
%         break;
%     end
%      tline(tline == ',' )= '.';
%      
% end
disp('substitution done')
%

% V.A.
% fid = fopen('Big5447_short.txt', 'r');
fgetl(fid) % skip header
B = fscanf(fid, '%*d:%*d:%*d%g%g%g%g%g%g%g%g%g%g%g%g%g%g%g%g%g%g%g%g%d', [21 inf]);
% make array columnwise
B = B';
fclose(fid);

%
% preparation for Galileo View 
h.FileName=fname(1:end-4);
h.data=B;
%h.time=T';
h.SampleRate=1000;
h.EVENT.POS=[];
h.EVENT.TYP=[];

%%%%%%%%%%%%%%%%%%%
% I leaved the check for existence of fields EVENT for possible further
% use.!!!! 12.09.2010
clear A Ab; pack;
size(A)
A=h.data;
SampleRate=h.SampleRate;
if isfield(h,'EVENT')
    disp('field')
    if ~isempty(h.EVENT.POS)
        ff=sortrows([h.EVENT.POS h.EVENT.TYP-10],1);
    else
       ff=[];
    end
else
    disp('no fild')
    ff=[];
end
%%%%%%%%%%%%%%%%%%%
set(fn1,'string',fname);
set(ulm,'string','');
set([a1 al_l al_r scc sct ulm fn1],'visible','on');
set([men mens ment menf mencol mensp menpsp menpi menwav menth],'enable','on')