%% Task 6: 

% Solve newton method for data set 1
load data1.mat
s=[-1,-1];
r=0;
epsilon=10^-6;
alpha_hat=1;
gama=10^-4;
beta=0.5;
K=size(X,2);       

P=[s r];
new_x = [X;-ones(1,size(X,2))];

% Vectorized implementation of the gradiente
g=(1/K)*(sum(new_x.*exp(P*new_x)./(1+exp(P*new_x)),2)- sum(new_x.*Y,2));

% Vectorized implementation of Hessian 
lap=(1/K)*new_x*diag(exp(P*new_x)./(1+exp(P*new_x)))*new_x';
