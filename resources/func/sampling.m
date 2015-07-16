function [ stream, time ] = sampling( stream, n)
% SAMPLING of stream with n samples
%
%  �������������
oldStream=stream; %���������� ������� �������
[r,l]=size(stream); % ����� ��������� �������
stream=zeros(4,n*l); %�������� ������ �������
%
%
%
for j=1:r
    for i=1:l
        stream (j,(i-1)*n+1:(i-1)*n+n)=oldStream(j,i);
    end
end
time=0:8e-9/n:8e-9*l-8e-9/n;

end

