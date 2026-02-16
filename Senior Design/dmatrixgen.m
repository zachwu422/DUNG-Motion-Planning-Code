function [directionmatrix]=dmatrixgen(compass,tagnum,IDVector)
%Indice Converter
    for j=1:length(IDVector)
        if tagnum==IDVector(2,j)
            tagnum=IDVector(1,j);
        end
    end
%Track Matrix Encoding
directionmatrix=[0 0 0; 0 0 0 ; 0 0 0];
for i=1:length(compass(:,tagnum))
if compass(tagnum,i)=="N"
    directionmatrix(1,2)=1;
elseif compass(tagnum,i)=="E"
    directionmatrix(2,3)=1;
elseif compass(tagnum,i)=="S"
    directionmatrix(3,2)=1;
elseif compass(tagnum,i)=="W"
    directionmatrix(2,1)=1;
end
end
end