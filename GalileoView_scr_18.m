% script for GalileoView
% sets the appropriate scale for 50uV labels

% called from GalileoView_scr after

% 11.09.2005

for i=1:3:ch_num
   set(l_lab_l(i),'ydata',scale*Lab+70*(ch_num-i+1));
   set(l_lab_r(i),'ydata',scale*Lab+70*(ch_num-i+1));
end

