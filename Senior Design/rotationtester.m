%function [result,crm,chm] = rotationplotter(tag1,tag2,IDVector,compass,rm,ch)
tag1=1;
tag2=2;
IDVector=NoPlaneID;
compass=noplanecompass;
rm=crm;
ch=chm;

%Track Matrix Initialization
d1=dmatrixgen(compass,tag1,IDVector);
d2=dmatrixgen(compass,tag2,IDVector);
%Indice Converter
j=0;
b=1;
    while j~=1
        if tag1==IDVector(2,b)
            tag1=IDVector(1,b);
            j=1;
        end
        b=b+1;
    end
k=0;
a=1;
    while k~=1

        if tag2==IDVector(2,a)
            tag2=IDVector(1,a);
            k=1;
        end
        a=a+1;
    end

%Junction Logic (adds to direction matrices)
if compass(tag1,tag2)=="W" && compass(tag2,tag1)=="E"
    d1(2,1)=2;
    d2(2,3)=2;
elseif compass(tag1,tag2)=="E" && compass(tag2,tag1)=="W"
    d1(2,3)=2;
    d2(2,1)=2;
elseif compass(tag1,tag2)=="N" && compass(tag2,tag1)=="S"
    d1(1,2)=2;
    d2(3,2)=2;
elseif compass(tag1,tag2)=="S" && compass(tag2,tag1)=="N"
    d1(3,2)=2;
    d2(1,2)=2;
end
%Rotation Encoding (output the correct rotation)
if d1(1,2)==d2(3,2) && d2(3,2)==2
result=rm(1,2);

elseif d1(3,2)==d2(1,2) && d2(1,2)==2
result=rm(3,2);

elseif d1(2,3)==d2(2,1) && d2(2,1)==2
result=rm(2,3);

elseif d1(2,1)==d2(2,3) && d2(2,3)==2
result=rm(2,1);
else
    result="FAIL";
end
%Internal Guidance Updater (update internal compass to match with robot
%orientation)
if result=="RR"
    orm=flip(rm)';
    ohm=flip(ch)';
elseif result=="RL"
    orm=flip(rm');
    ohm=flip(ch');
end
%OUTPUTS

%end