function [ signal, scr,cs] = encodedata( data,cs,scr )
%ENCODEDATA Summary of this function goes here
%   Detailed explanation goes here

%initial
dataLength=ceil(length(data)/8)*8;
encodedData=zeros(1,dataLength);
encodedData(1:length(data))=data; 
startIndex=1;
endIndex=8;
for i=1:ceil(length(data)/8)
    [scr sy sx sg]=wordgenerator(scr);
    sc=scramblerbitgenerator(sy,sx,'SEND',0,0,1,[0 0 0]);
    sd=datascrambler(encodedData( startIndex:endIndex ),sc,1,0,cs,'OK',0);
    [sd,cs]=convolutionalencoder(sd,cs,1);
    [table1,table2]=initializeLookupTables;
    if(sd(9)==1)
        index=bi2de(wrev(sd(7:8)));
        index=index*4+1;
        signal(1:4,i)=table2(bi2de(wrev(sd(1:6)))+1,index:index+3);
    else
        index=bi2de(wrev(sd(7:8)));
        index=index*4+1;
        signal(1:4,i)=table1(bi2de(wrev(sd(1:6)))+1,index:index+3);
    end
    startIndex=(i*8)+1;
    endIndex=(i+1)*8;
end
end

