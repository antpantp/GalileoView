%% Zhenja
% program for Kan txt files reading
%rev. 2.0
%with previous memory allocation for matrix

clc
close all;
clear all;
pack;
tic
name='s3292h';
fid = fopen(strcat('C:\MATLAB7\work\',name,'.txt'),'r')
tline = fgetl(fid);

D=[];
T=[];
while tline ~= -1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    
    ii = find(tline == ',');
    tline(ii) = '.';
    
    
    time = sscanf(tline(1:15),'%d:%d:%d ');
    data = sscanf(tline(15:end),'%f ');

    if (length(time) ~= 3)
        disp(tline(1:15));
        break;
    end
        
    T(end+1,:) = time';
    D(end+1,:) = data';
    
    
end

fclose(fid);

elapsed_time=toc

% preparation for Galileo View 
h.name=name;
h.data=D';
h.time=T';
h.SampleRate=1000;
save(strcat('DXEEGfile_',name),'h');
