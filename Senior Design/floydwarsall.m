function [S, P]=floydwarsall(AdjMax)
N=min(length(AdjMax(:,1)),length(AdjMax(1,:)));
P=-1*ones(N,N);
S=AdjMax;
for k=1:N
    for i=1:N
        for j=1:N
            if S(i,k)==inf
                continue;
            end
            if S(k,j)==inf
                continue;
            end
            if S(i,j)>S(i,k)+S(k,j)
                if P(i,k)==-1
                    P(i,j)=k;   
                else
                    P(i,j)=P(i,k);
                end
                S(i,j)=S(i,k)+S(k,j);
            end
        end
    end
end
