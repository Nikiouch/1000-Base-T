function [ sd,cs ] = convolutionalencoder( sd,cs,tx_enable )
%CONVOLUTIONALENCODER Summary of this function goes here
%   Detailed explanation goes here
csPrev=cs;
cs(1)=csPrev(3);
sd(9)=cs(1);
if(tx_enable)
    cs(3)=xor(sd(8),csPrev(2));
    cs(2)=xor(sd(7),csPrev(1));
else
    cs(1:2)=0;
end


end

