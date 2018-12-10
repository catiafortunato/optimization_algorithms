%% GRADIENT METHOD 

clear all
close all

%  load 'data1.mat'
% load 'data2.mat'
% load 'data3.mat'
load 'dataset4.mat'

%% ------------ Task 2 & 3 ------------

% Initialization 

    % Gradient method
    
    K=size(X,2);
    xk=[-ones(1,size(X,1)) 0]; % xk=[s,r]
    e=10^(-6); % stop criteria
    
    % Backtracking subroutine variables 
    
    alpha_hat=1;
    gamma=10^(-4);
    beta=0.5;

    % The Gradient Descent algorithm 

    grad=gradient(X,Y,xk);
    n=norm(grad);
    N=[n]; % storage of the norms along the iterations 
    k=0; % nº of iterations 
    
    tic()
    
    while norm(grad)>e

        dk=-grad;
        k=k+1;
        
        % Backtracking subroutine to find the step size
          
          alpha=alpha_hat; %initialization of the alpha
          
          while f(X,Y,xk+alpha*dk')>f(X,Y,xk)+gamma*grad'*(alpha*dk)
              
               alpha=beta*alpha;
               
          end
          
          xk=xk+alpha*dk';
          
          grad=gradient(X,Y,xk);
          
          n=norm(grad);
          
          N=[N n];    

    end
    
    toc()
    
%% Plots 2 & 3

    % Division line
    x1=[-4 : 8];
    x2=(xk(3)-xk(1)*x1)/xk(2);
    
    figure(1)
    gscatter (X(1,:),X(2,:),Y,'rb','oo',10)
    grid on
    title('Gradient Descent')
    xlabel('x1')
    ylabel('x2')
    axis([-4 8 -4 8])
    hold on 
    plot(x1,x2,'g','LineStyle','--','LineWidth',2)
    
    figure(2)
    semilogy(N,'LineWidth',2)
%     axis([0 k 10^(-6) 3])
    grid on
    xlabel('k')
    ylabel('Norm gradient')
    title('Gradient norm along iterations')
    
