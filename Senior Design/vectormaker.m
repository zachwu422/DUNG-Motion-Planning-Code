function [R]=vectormaker(A,B,P,IDVector)
%Unconvert Indices
result=[A B];
for i=1:length(result)
    for j=1:length(IDVector)
        if result(i)==IDVector(2,j)
            result(i)=IDVector(1,j);
        end
    end
end
%"Inbetweener Kill Condition
nextnode=0;
penind=2;
%Constructing in-between nodes until no other nodes are possible
while nextnode~=-1
    nextnode=P(result(length(result)-1),result(length(result)));
    if nextnode ~=-1
        if length(result)==2
 result=[result(1:(penind-1)) nextnode result(penind:length(result))];
 penind=length(result)-1;
        else
    result=[result(1:(penind)) nextnode result(penind+1:length(result))];
    penind=length(result)-1;
        end
    else
        nextnode=-1;
    end
end
%Reconvert Indices
R=result;
for i=1:length(R)
    R(i)=IDVector(2,R(i));
end
end