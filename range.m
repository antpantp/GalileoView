function [scales]=range(rangeStart,rangeEnd,dur_wavelet,distribution,quantity,...
    dispersion,Fs)

rangeStartCoef = rangeStart/dur_wavelet;
rangeEndCoef = rangeEnd/dur_wavelet;

switch(distribution)
    case(1)
        scales = (rangeEndCoef+rangeStartCoef)/2+...
            (rangeEndCoef-rangeStartCoef)*dispersion/2*randn([1 quantity]);
    case(2)
        scales = unifrnd(rangeStartCoef,rangeEndCoef,[1 quantity]);
end