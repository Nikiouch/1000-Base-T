scr=[];
cs=[0 0 0];
for i=1:8
    [signal scr cs]=encodedata(data,cs,scr);
    signal
end