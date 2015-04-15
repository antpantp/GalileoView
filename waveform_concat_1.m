% program for waveform sets! concatenation
% 04-10-2004 19-07

% as part of signal_visual_1
% (is recalled from scr_7)

[p1r,p1c]=size(P1);
[p2r,p2c]=size(P2);
F=zeros(p1r*p2r,p1c+p2c);
k=1;
for i=1:p1r
    for j=1:p2r
        F(k,1:p1c)=P1(i,:);
        F(k,p1c+1:p1c+p2c)=P2(j,:);
        k=k+1;
    end
end
str=p1r*p2r;
stb=p1c+p2c;