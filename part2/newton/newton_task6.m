%% Task 6: 

% Choose the data 

%load data1.mat
%load data2.mat
%load data3.mat
load dataset4.mat

s=-ones(1, size(X,1));
r=0;
epsilon=10^-6;
alpha_hat=1;
gama=10^-4;
beta=0.5;
K=size(X,2);       
k=0;

P=[s r];
new_x = [X;-ones(1,size(X,2))];
g=ones(size(new_x,1));

G=[];
A=[];

tic()

while norm(g) > epsilon
    % Vectorized implementation of the gradiente
    g=(1/K)*(sum(new_x.*(exp(P*new_x)./(1+exp(P*new_x))),2)- sum(new_x.*Y,2));
    G=[G g];
    % Vectorized implementation of Hessian 
    lap=(1/K)*new_x*diag(exp(P*new_x)./(1+exp(P*new_x)).^2)*new_x';
    % Compute d
    d=-inv(lap)*g;
    % check the value of alpha
    alpha=alpha_hat;
    while log_regression(P+alpha*d',new_x,Y)>log_regression(P,new_x,Y)+gama*g'*(alpha*d)
        alpha=beta*alpha;
    end
    % Update the variables
    P=P+alpha*d';
    A=[A alpha];
    % compute the iteration number
    k=k+1;

end
toc()
%% Plots

% Plot the alphas 
figure(1)
stem(1:k,A, 'filled')
xlabel('Iteration k')
ylabel('Alpha value')
axis([1 k 0 1])
title('Alpha values for each iteration of Newton Method')

% Plot norm of gradient

gplot=zeros(1,k);
for i=1:k
    gplot(i)=norm(G(:,i));
end

figure(2)
p=semilogy(1:k,gplot)
p.LineWidth = 2;
xlabel('Iteration k')
axis([1 k 10^-9 10])
ylabel('||g||')
title(' Gradient norm of Newton Method')
