function fun=sc_dl_tr(inp,sc,dl,a,b,tot_len);
% SC_DL_TR = Produces the scaled to SC, dilated/squeezed according to DL and with trend A+BX
% version of input vector  INP over the TOT_LEN number of samples.
% When dilating we use built-in SPLINE function of MATLAB. 
% Use DL>1 to squeeze the waveform, DL<1 to dilate it.

fun=zeros(1,tot_len);
inp_len=length(inp); % Length of the input vector.

% Dilate/squeeze and scale first:
dil_fun=sc*spline(1:inp_len,inp,linspace(1,inp_len,ceil(inp_len/dl)));   % New waveform

% now adding trend:
curr_len=min(tot_len,length(dil_fun));
x=0:curr_len-1;
fun(1:curr_len)=a+b*x+dil_fun(1:curr_len);


