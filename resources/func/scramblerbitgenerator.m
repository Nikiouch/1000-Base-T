function [ sc ] = scramblerbitgenerator(sy, sx, tx_mode, n, n0, tx_enable,syPrev)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Initialization
sc=zeros(1,8);
sendMode='SEND_Z';
if strcmp(tx_mode,sendMode)
    sc(1)=0;
else
    sc(1)=sy(1);
end

if strcmp(tx_mode,sendMode)
    sc(2:4)=[0 0 0];
else
    if mod(n-n0,2)==  0
        sc(2:4)=sy(2:4);
    else
        sc(2:4)=xor(syPrev(2:4),[1 1 1]);
    end
end

if tx_enable==1
    sc(5:8)=sx;
else
    sc(5:8)=[0 0 0 0];
end

end

