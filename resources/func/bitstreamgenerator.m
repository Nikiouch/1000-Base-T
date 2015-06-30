function [ bitStream ] = bitstreamgenerator( nBit )
%   Generator of four bit streams with length nBit
bitStream=round(rand(1,nBit));
end

