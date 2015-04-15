%script #26 for GalileoView
% 
% called from GalileoView,
% Opens EEG signal stored in DX-created *.txt file, converts it into connon structure
% (takes a lot of time!!!!)

% 12.09.2010
fid = fopen(strcat(pname,fname),'r'); 
tline = fgetl(fid);
D=[]; %T=[];
tic
while tline ~= -1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    ii = find(tline == ',');
    tline(ii) = '.';
%     time = sscanf(tline(1:15),'%d:%d:%d ');
    data = sscanf(tline(15:end),'%f ');
%     if (length(time) ~= 3)
%         disp(tline(1:15));
%         break;
%     end
    % T(end+1,:) = time';
    D(end+1,:) = data';
end
fclose(fid);
% preparation for Galileo View 
h.FileName=fname(1:end-4);
h.data=D';
%h.time=T';
h.SampleRate=1000;
h.EVENT.POS=[];
h.EVENT.TYP=[];
elapsed_time=toc
%%%%%%%%%%%%%%%%%%%
% I leaved the check for existence of fields EVENT for possible further
% use.!!!! 12.09.2010
clear A Ab; pack;
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