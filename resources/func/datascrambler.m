function [ sd ] = datascrambler( TXD, sc, tx_enable, tx_enableN, cs,loc_rcvr_status ,tx_error)
%DATASCRAMBLER Summary of this function goes here
%   Detailed explanation goes here
sd=zeros(1,8);
csreset=0;%tx_enable && xor(tx_enableN,1);
tx_enable=1;
if csreset == 0 && tx_enable==1
    sd(7:8)=xor(sc(7:8),TXD(7:8));
else
    if(csreset==1)
        sd(7:8)=cs(1:2);
    else
        sd(7:8)=sc(7:8);
    end
end

if tx_enable==1
    sd(1:6)=xor(sc(1:6),TXD(1:6));
else
    sd(3:5)=sc(3:5);
    sd(2)=xor(sc(2),(loc_rcvr_status == 'OK'));
    if tx_enableN == 0 && bi2de(TXD)==240
        cext=tx_error; 
        cext_err=0;
    else
        cext_err=tx_error;
        cext=0;
    end
    sd(2)=xor(sc(2),cext);
    sd(1)=xor(sc(1),cext_err);
end

