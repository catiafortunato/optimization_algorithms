thrs=10^-6;
a=zeros(1,6);
for i=1:K
    if norm(x(1:2,ts(i))-W(:,i))<thrs
        a(i)=1;
    end
end