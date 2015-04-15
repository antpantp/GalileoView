 %  'nearest'  - nearest neighbor interpolation
 %     'linear'   - linear interpolation
 %     'spline'   - piecewise cubic spline interpolation (SPLINE)
 %     'pchip'    - piecewise cubic Hermite interpolation (PCHIP)
 %     'cubic'    - same as 'pchip'
 %     'v5cubic'  - the cubic interpolation from MATLAB 5, which does not
 %                  extrapolate and uses 'spline' if X is not equally spaced.
 close all
 clear all
 
 load a4h;
t=length(wave);
 figure
 plot(wave)
% xn=1:round(t*.92);
 xn=1:.01:120;
 figure
 plot( xn,interp1(1:t,wave,xn,'nearest') )
 title('nearest')
 figure
 plot( xn,interp1(1:t,wave,xn,'linear'))
  title('linear')
  
 figure
 plot(xn,interp1(1:t,wave,xn,'spline'))
  title('spline')
  
 figure
 plot(xn,interp1(1:t,wave,xn,'pchip'))
  title('pchip')
  
   figure
 plot(xn,interpft(1:t,wave,xn))
  title('ft')
