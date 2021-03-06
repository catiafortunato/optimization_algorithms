%% Task 6

% Compute the minimization parameters

C=[10 20 30 30 20 10; 10 10 10 0 0 -10];
r=2;
T=81;
tk=1+[10 25 30 40 50 60];
Umax=100;
k=6;
lambda=0.1;
A=[1 0 0.1 0; 0 1 0 0.1; 0 0 0.9 0; 0 0 0 0.9];
b=[0 0; 0 0; 0.1 0; 0 0.1];

cvx_begin quiet
    variable x(4,T)
    variable u(2,T)
    obj1=0;
    obj2=0;
    for i=1:k
        % first sum
        obj1=obj1+square_pos(square_pos(norm(x(1:2,tk(i))-C(:,i)))-r^2);
    end
    for i=2:T
        obj2=obj2+norm(u(:,i)-u(:,i-1),1);
    end
    
    minimize(obj1+lambda*obj2)
    
    subject to 
        x(:,1)==[0;5;0;0];
        x(:,T)==[15;-15;0;0];
        for i=1:T
            norm(u(:,i))<=Umax;
        end
        
        for i=2:T
            x(:,i)==A*x(:,i-1)+b*u(:,i-1);
        end
    
cvx_end

%% a) Plot the positions of the robot and the regions

figure(1); 
scatter(x(1,:),x(2,:)); hold on;
for i=1:k
    cx = C(1,i);
    cy = C(2,i);

    n = 50;                           % 50 point approximation
    R = 2;                            % Unit radius
    angle = 0:2*pi/n:2*pi;            % vector of angles at which points are drawn

    x1 = cx+R*cos(angle);  y1 = cy+R*sin(angle); % Coordinates of circle
    plot(x1,y1,'color','r');                                 % Plot the circle

    axis equal;
    
    hold on;
end

xlabel('X coordinate')
ylabel('Y coordinate')
legend({'robot positions','regions'},'Location','southwest')
for i=1:k
    scatter(x(1,tk(i)),x(2,tk(i)),'filled','m')
    
end

title('Optimal positions of the robot')

%% b) Plot the optimal control signal
figure(2)
p=plot(1:T,u(1,:),1:T,u(2,:))
p(1).LineWidth=2;
p(2).LineWidth=2;
legend({'u1(t)','u2(t)'})
xlabel('Time stamp')
ylabel('Control signal intensity')
title('Optimal control signal')

%% d) 

pk=zeros(2,k);
for i=1:k
    pk(:,i)=x(1:2,tk(i));
end

diff=abs(C-pk);

dev=zeros(1,k);

for i=1:k
    dev(i)=norm(diff(:,i));
end

mean_dev=mean(dev);

 