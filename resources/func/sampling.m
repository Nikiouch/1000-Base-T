function [ stream ] = sampling( stream, n)
% SAMPLING of stream with n samples
%
%  Инициализация
oldStream=stream; %Сохранение старого вектора
l=length(stream); % Длина исходного вектора
stream=zeros(1,n*l); %Создание нового вектора
%
%
%
for i=1:l
    stream ((i-1)*n+1:(i-1)*n+n)=oldStream(i);
end

end

