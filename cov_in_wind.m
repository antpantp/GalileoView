function [c]= cov_in_wind(A,T,t)
%COV_IN_WIND Covariance matrix of the signal A (matrix)in the 
% window with duration T samples beginning from sample t

%								
[chan_num samp_num]=size(A);
%% 
%
sum2=0;
c=zeros(T,T); % empty matrix for covariance matrix
for i=t:t+T-1 % row 
   for j=i:t+T-1   % row
   
      for ch=1:chan_num % all channels summation
         sum2=sum2+A(ch,i)*A(ch,j);
      end
      c(i-t+1,j-t+1)=sum2/chan_num;
      c(j-t+1,i-t+1)=c(i-t+1,j-t+1);
      sum2=0;
   end
end



