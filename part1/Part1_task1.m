%-------------------------Otimization and Algorithms----------------------%
%-------------------------------Projet - Part 1 --------------------------%
%-------------------------------------------------------------------------%
 
 
% --------Work by:------%
% Catia Fortunato
% Maria Inês Diegues
% Joao Carvalho
% -------Supervision by------%
% Profesor João Xavier
 
 
%%
clear all;
close all;
 
 
%% --------------------------Task1
 
%----------Constants:
 
T=80;
 
%----------Cost Function:
 
% Cost Function
E=[1 0 0 0; 0 1 0 0];
 
% Waypoints 
 
w=[10 20 30 30 20 10; 10 10 10 0 0 -10];
 
% Appointed times
 
tk=[10 , 25, 30, 40, 50, 60];
 
% Max control magnitude 
 
Umax=100;
 
% A and B matrixes for the dynamics of the robot 
 
A=[1 0 0.1 0; 0 1 0 0.1; 0 0 0.9 0; 0 0 0 0.9];
B=[0 0; 0 0; 0.1 0; 0 0.1];
 
% Regularization problem
 
lambda=[10^(-3) 10^(-2) 10^(-1) 10^0 10^1 10^2 10^3];
K=6;
 
% Solving the optimization problem 
 
cvx_begin quiet
 
    variable x(4,T);
    variable u(2,T);
    
    % Construct the cost function
    
    f1=0;
    f2=0;
    
    for i=1:K
        
     f1= f1 + square_pos(norm(x(1:2,tk(i))-w(:,i)));
     
    end
    
    for t=2:T
       
        f2=f2 + square_pos(norm(u(:,t)-u(:,t-1)));
        
    end
 
    f2=lambda(3)*f2;
    
    minimize (f1+f2);
    
    % Subject to
    
     x(:,1)==[0;5;0;0];
     x(:,T)==[15;-15;0;0];
 
    for i=1:T
 
        norm(u(:,i))<=Umax;
 
    end

     for i=2:T
            x(:,i)==A*x(:,i-1)+B*u(:,i-1);
     end
        
     
 cvx_end 
 
 % Plot the optimal position of the robot
 
 figure (1)
 scatter (x(1,:), x(2,:))
 grid on
 hold on 
 plot(w(1,:),w(2,:),'rs','MarkerSize',10)
 hold on
 plot(x(1,tk),x(2,tk),'mo')
 legend('pos','waypoinys','pos in tk','Location','northeastoutside')
 xlabel('X coordinate')
 ylabel('Y coordinate')
 title('Optimal positions of the robot')
 
 % Plot the optimal control signal

figure(2)
plot(0:T-1,u(1,:))
grid on
hold on 
plot(0:T-1,u(2,:))
legend('u1(t)','u2(t)','Location', 'northeastoutside')
xlabel('Time stamp')
ylabel('Control signal intensity')
axis([0 80 -40 40])
title('Optimal control signal')
 
 % Changes in the control signal
 
 changes=0;
 
 for i=2:T
     
     if norm(u(:,i)-u(:,i-1))>10^(-6)
         changes=changes+1;
     end 
 end
 
 
 % Mean deviation
 
mean_dev=0;

for i=1:K
    
    mean_dev=mean_dev + norm((x(1:2,tk(i))-w(:,i)));
    
end
 
mean_dev=(1/K)*mean_dev;

 %% --------------------------Task2

 clear all
 close all
 
 %----------Constants:
 
T=80;
 
%----------Cost Function:
 
% Cost Function
E=[1 0 0 0; 0 1 0 0];
 
% Waypoints 
 
w=[10 20 30 30 20 10; 10 10 10 0 0 -10];
 
% Appointed times
 
tk=[10 , 25, 30, 40, 50, 60];
 
% Max control magnitude 
 
Umax=100;
 
% A and B matrixes for the dynamics of the robot 
 
A=[1 0 0.1 0; 0 1 0 0.1; 0 0 0.9 0; 0 0 0 0.9];
B=[0 0; 0 0; 0.1 0; 0 0.1];
 
% Regularization problem
 
lambda=[10^(-3) 10^(-2) 10^(-1) 10^0 10^1 10^2 10^3];
K=6;
 
% Solving the optimization problem 
 
cvx_begin quiet
 
    variable x(4,T);
    variable u(2,T);
    
    % Construct the cost function
    
    f1=0;
    f2=0;
    
    for i=1:K
        
     f1= f1 + square_pos(norm(x(1:2,tk(i))-w(:,i)));
     
    end
    
    for t=1:(T-1)
       
        f2=f2 + norm(u(:,t+1)-u(:,t));
        
    end
 
    %f2=lambda(3)*f2;
    
    minimize (f1+lambda(3)*f2);
    
    % Subject to
    
     x(:,1)==[0;5;0;0];
     x(:,T)==[15;-15;0;0];
 
    for i=1:T
 
        norm(u(:,i))<=Umax;
 
    end

     for i=2:T
            x(:,i)==A*x(:,i-1)+B*u(:,i-1);
     end
        
     
 cvx_end 
 
 % Plot the optimal position of the robot
 
 figure (1)
 scatter (x(1,:), x(2,:))
 grid on
 hold on 
 plot(w(1,:),w(2,:),'rs','MarkerSize',10)
 hold on
 plot(x(1,tk),x(2,tk),'mo')
 legend('pos','waypoinys','pos in tk','Location','northeastoutside')
 xlabel('X coordinate')
 ylabel('Y coordinate')
 title('Optimal positions of the robot')
 
 % Plot the optimal control signal

figure(2)
plot(1:T,u(1,:))
grid on
hold on 
plot(1:T,u(2,:))
legend('u1(t)','u2(t)','Location', 'northeastoutside')
xlabel('Time stamp')
ylabel('Control signal intensity')
title('Optimal control signal')
 
 % Changes in the control signal
 
 changes=0;
 
 for i=2:T
     
     if norm(u(:,i)-u(:,i-1))>10^(-6)
         changes=changes+1;
     end 
 end
 
 
 % Mean deviation
 
mean_dev=0;

for i=1:K
    
    mean_dev=mean_dev + norm((x(1:2,tk(i))-w(:,i)));
    
end
 
mean_dev=(1/K)*mean_dev;
 %% --------------------------Task3

 clear all
 close all
 
 %----------Constants:
 
T=80;
 
%----------Cost Function:
 
% Cost Function
E=[1 0 0 0; 0 1 0 0];
 
% Waypoints 
 
w=[10 20 30 30 20 10; 10 10 10 0 0 -10];
 
% Appointed times
 
tk=[10 , 25, 30, 40, 50, 60];
 
% Max control magnitude 
 
Umax=100;
 
% A and B matrixes for the dynamics of the robot 
 
A=[1 0 0.1 0; 0 1 0 0.1; 0 0 0.9 0; 0 0 0 0.9];
B=[0 0; 0 0; 0.1 0; 0 0.1];
 
% Regularization problem
 
lambda=[10^(-3) 10^(-2) 10^(-1) 10^0 10^1 10^2 10^3];
K=6;
 
% Solving the optimization problem 
 
cvx_begin quiet
 
    variable x(4,T);
    variable u(2,T);
    
    % Construct the cost function
    
    f1=0;
    f2=0;
    
    for i=1:K
        
     f1= f1 + square_pos(norm(x(1:2,tk(i))-w(:,i)));
     
    end
    
    
    for t=2:T
       
        
        f2=f2 + norm(u(:,t)-u(:,t-1),1);
        
    end
 
    f2=lambda(3)*f2;
    
    minimize (f1+f2);
    
    % Subject to
    
     x(:,1)==[0;5;0;0];
     x(:,T)==[15;-15;0;0];
 
    for i=1:T
 
        norm(u(:,i))<=Umax;
 
    end

     for i=2:T
            x(:,i)==A*x(:,i-1)+B*u(:,i-1);
     end
        
     
 cvx_end 
 
 % Plot the optimal position of the robot
 
 figure (1)
 scatter (x(1,:), x(2,:))
 grid on
 hold on 
 plot(w(1,:),w(2,:),'rs','MarkerSize',10)
 hold on
 plot(x(1,tk),x(2,tk),'mo')
 legend('pos','waypoinys','pos in tk','Location','northeastoutside')
 xlabel('X coordinate')
 ylabel('Y coordinate')
 title('Optimal positions of the robot')
 
 % Plot the optimal control signal

figure(2)
plot(0:T-1,u(1,:))
grid on
hold on 
plot(0:T-1,u(2,:))
legend('u1(t)','u2(t)','Location', 'northeastoutside')
xlabel('Time stamp')
ylabel('Control signal intensity')
title('Optimal control signal')
 
 % Changes in the control signal
 
 changes=0;
 
 for i=2:T
     
     if norm(u(:,i)-u(:,i-1))>10^(-6)
         changes=changes+1;
     end 
 end
 
 
 % Mean deviation
 
mean_dev=0;

for i=1:K
    
    mean_dev=mean_dev + norm((x(1:2,tk(i))-w(:,i)));
    
end
 
mean_dev=(1/K)*mean_dev;
 