function [f,Y,NFFT] = spectrumest(data, Fs )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
L = length(data);                     % Length of signal
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fft(data,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
Y=2*abs(Y(1:NFFT/2+1));

