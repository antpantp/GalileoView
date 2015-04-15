% script for use with Galileo View
% 15.04.2015

% called from Galileo View

% the part of callback function for opening the EEG, stored in .mat file
% and annotations with the labels of "Interesting Events"

% deals with the case, when .mat file is accompanied with the additional
% mat-file containing the labels of event start and ends.
% mat-file is prepared using Kharitonov's data (EDF).


load(fname);
clear A Ab;
A=d.data'; % EEG data into a matrix A
SampleRate=d.Fs;
ff={};% empty array for events

events_line=-1000*ones(1,size(A,2));
%%%%%%%%%%%%%%
%%%% reading from ANNOTATIONS file
ann_fname=[fname(1:end-4),'_ann'];
load(ann_fname);
% reading ann_1
for ev=1:size(ann_1,1)% every event
    ev_s=ann_1(ev,1);%*SampleRate;% start sample
    ev_e=ann_1(ev,2);%*SampleRate;% end sample
    events_line(ev_s:ev_e)=10*70+20;
end
% line is plotted in _scr_1

   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
GalileoView_scr_1;
set(fn1,'string',fname);
set(ulm,'string','');
set([a1 al_l al_r scc sct ulm fn1],'visible','on');
set([men  ment menf mencol mensp menpsp menpi menwav ],'enable','on');% mens? menth?
