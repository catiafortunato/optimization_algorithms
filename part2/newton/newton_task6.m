%% Task 6: 

% Solve newton method for data set 1

s=[-1,-1];
r0=0;
epsilon=10^-6;
alpha_hat=1;
gama=10^-4;
beta=0.5;
K=length(X);       

% Vectorized implementation of the gradiente
Fs=(1/K)*(-sum(Y.*X,2)+sum(X.*exp(s*X-r0)./(1+exp(s*X-r0)),2));
Fr=(1/K)*(sum(Y)+sum(-(exp(s*X-r0))./(1+exp(s*X-r0))));
g=[Fs;Fr];

% Vectorized implementation of Hessian 
