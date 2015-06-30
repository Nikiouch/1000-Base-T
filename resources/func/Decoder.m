function [ stream ] = Decoder( stream)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
paths=zeros(1,8);
lengths=zeros(1,8);
[m,n]=size(stream);
for k=1:n
    data=stream(1:4,k);
    data=data';
    [table1,table2]=initializeLookupTables;
    for i=1:4
        table=table1(:,(i-1)*4+1:(i-1)*4+4);
        for j=1:length(table)
            if table(j,:)==data 
                first=fliplr(de2bi(j-1));
                second=fliplr(de2bi((i-1)*2));
            end
        end
    end
    for i=1:4
        table=table2(:,(i-1)*4+1:(i-1)*4+4);
        for j=1:length(table)
            if table(j,:)==data 
                first=fliplr(de2bi(j-1));
                second=fliplr(de2bi(i*2-1));
            end
        end
    end
    
end

end

