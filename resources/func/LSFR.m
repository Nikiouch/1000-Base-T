function [scr] = LSFR(scr)
% LSFR generate pseudo random 33 bits stream
% If scr not exist it creates new random stream 
% else it uses scr to generate new stream 
if isempty(scr)
    scr=round(random('uniform',zeros(1,33),ones(1,33)));
end
temp=xor(scr(13),scr(33));
scr(2:33)=scr(1:32);
scr(1)=temp;

end

