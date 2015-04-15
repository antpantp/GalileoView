function A_out=ds_1(A, dsr);
% DS_1 -- Function for obtaining the "downsampled" signal.
% DS_1(A,dsr), where A is the signal matrix. Raws - signal leads,
% columns--signal samples for each lead. A_out will be the 
% matrix, where in leads will be remained every DSR's  sample
% in each lead. A can also be the raw vector (of one signal lead).
[lead_num, samp_num]=size(A);
new_samp_num=floor(samp_num/dsr);
sig_counts=1:dsr:new_samp_num*dsr;
A_out=zeros(lead_num,new_samp_num);
A_out=A(:,sig_counts);

