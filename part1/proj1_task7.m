%% Task 7

Umax=15;
W=[10 20 30 30 20 10;10 10 10 0 0 -10];
T=80;
tk=[10 25 30 40 50 60];
A=[1 0 0.1 0; 0 1 0 0.1; 0 0 0.9 0; 0 0 0 0.9];
b=[0 0; 0 0; 0.1 0; 0 0.1];
k=6;

cvx_begin 
    variable x(4,T)
    variable u(2,T)
    obj1=0;
    
    minimize(obj1)
    
    subject to
        x(:,1)==[0;5;0;0];
        x(:,T)==[15;-15;0;0];
        for i=1:T
            norm(u(:,i))<=Umax;
        end
        for i=2:T
            x(:,i)==A*x(:,i-1)+b*u(:,i-1);
        end
        for i=1:k
            x(1:2,tk(i))== W(:,i);
        end
cvx_end

