% script for use with Galileo View
% 09.01.2010

% the part of callback function for opening the EEG, stored in .mat file
% deals with the case, when .mat file was created from the .GTF file
% and contains the marks and labels
% 
load(fname);
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
GalileoView_scr_1;
set(fn1,'string',fname);
set(ulm,'string','');
set([a1 al_l al_r scc sct ulm fn1],'visible','on');
set([men  ment menf mencol mensp menpsp menpi menwav ],'enable','on');% mens? menth?
