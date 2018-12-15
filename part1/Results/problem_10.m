cvx_begin quiet
%Initializations
variable x(4,T);
variable u(2,T);
f=0;%Define Objective Function
for i=1:K
    f=f+norm(x(1:2,ts(i))-W(:,i),2);
end
minimize(f)
subject to
x(:,1)==ci; %assuming vi=0
x(:,T)==cf; %assuming vf=0
for i=1:T
    norm(u(:,i),2)<=Umax;
end
for i=2:T
    x(:,i)==A*x(:,i-1)+B*u(:,i-1);
end
cvx_end