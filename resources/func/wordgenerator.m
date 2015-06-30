function [ scr sy sx sg ] = wordgenerator( scr )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%   Initialization
sy=zeros(1,4);
sx=zeros(1,4);
sg=zeros(1,4);
scr=LSFR(scr);

sy(1)=scr(1);
sy(2)=xor(scr(3),scr(8));
sy(3)=xor(scr(6),scr(16));
sy(4)=mod((scr(9)+scr(14)+scr(19)+scr(24)),2);

sx(1)=xor(scr(4),scr(6));
sx(2)=mod((scr(7)+scr(9)+scr(12)+scr(14)),2);
sx(3)=mod((scr(10)+scr(12)+scr(20)+scr(22)),2);
sx(4)=mod((scr(13)+scr(15)+scr(18)+scr(20)+scr(23)+scr(25)+scr(28)+scr(30)),2);

sg(1)=mod(scr(1),scr(5));
sg(2)=mod((scr(4)+scr(8)+scr(9)+scr(13)),2);
sg(3)=mod((scr(7)+scr(11)+scr(17)+scr(21)),2);
sg(4)=mod((scr(10)+scr(14)+scr(15)+scr(19)+scr(20)+scr(24)+scr(25)+scr(29)),2);

end

