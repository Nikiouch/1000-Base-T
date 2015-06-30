function [ stream ] = sampling( stream, n)
% SAMPLING of stream with n samples
%
%  �������������
oldStream=stream; %���������� ������� �������
l=length(stream); % ����� ��������� �������
stream=zeros(1,n*l); %�������� ������ �������
%
%
%
for i=1:l
    stream ((i-1)*n+1:(i-1)*n+n)=oldStream(i);
end

end

