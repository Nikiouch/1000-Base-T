function [ signal ] = pulseshaping( signal )
%Pulse Shaping: 0.75+0.25z^-1
%
%  Инициализация
n=length(signal);
oldSignal=zeros(n+1);
oldSignal(2:n+1)=signal;
%------------------------------
%
%------------------------------
for i=1:n
    signal(i)=oldSignal(i+1)*0.75+0.25*oldSignal(i);
end

end

