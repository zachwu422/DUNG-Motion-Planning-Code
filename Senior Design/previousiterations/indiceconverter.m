function O=indiceconverter(ToConvert,IDVector)
R=ToConvert;
for i=1:length(R)
    R(i)=IDVector(2,R(i));
end
O=R;
end