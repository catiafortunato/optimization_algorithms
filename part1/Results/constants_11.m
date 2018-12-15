T=80+1;
ci=[0;5;0;0]; %initial condition
pi=[0;5]; %initial position
cf=[15;-15;0;0]; %final condition
pf=[15;-15]; %final position
K=6;
W=[10 20 30 30 20 10; 10 10 10 0 0 -10]; %matrix with the positions!
ts=[10 25 30 40 50 60]+1;
A=[1 0 0.1 0;
    0 1 0 0.1;
    0 0 0.9 0;
    0 0 0 0.9];
B=[0 0;
    0 0;
    0.1 0;
    0 0.1];
Umax=15;
%Hyperparameters
epsilon=10^-6;
M=10;