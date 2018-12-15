%% Running the LM Model
Xs_out=[];
Xs_in=[];
for i=1:10000
    %1. Hiperparameters
    lambda_k=1;epsilon=10^-6;
    xinit=(rand(16,1)*2-ones(16,1))*15;
    x_k=xinit;
    Xs_in=[Xs_in x_k];
    
    %2. Set k=0
    iteration=1;
    convergence=0;
    norms=[];
    

    
    %3. Start Loop
    while 1
        
        %4.----------Compute Gradient

        %First Summation
        D1=reshape(A_val+E1*x_k,[2,16]);
        D1_norm=vecnorm(D1)';
        D1_y=D1_norm-y; %Equivalent to the function H (without the square)
        
        H_grad_nsq=(E1'.*repmat(reshape((D1'./D1_norm)',32,1)',16,1));
        H_grad_nsq=(H_grad_nsq(:,1:2:end)+H_grad_nsq(:,2:2:end));
        H_grad=repmat(2*D1_y',16,1).*H_grad_nsq;

        
        %Second Summation
        %     tic
        D2=reshape(E2*x_k,[2,24]);
        D2_norm=vecnorm(D2)';
        D2_z=D2_norm-z;%Equivalent to the function G (without the square)
        
        G_grad_nsq=(E2'.*repmat(reshape((D2'./D2_norm)',48,1)',16,1));
        G_grad_nsq=(G_grad_nsq(:,1:2:end)+G_grad_nsq(:,2:2:end));
        G_grad=repmat(2*D2_z',16,1).*G_grad_nsq;     
        
        %Gradient
        Gradient=sum(G_grad,2)+sum(H_grad,2);
        grad_norm=norm(Gradient,2);
        norms=[norms grad_norm];

        
        %5. --------------- Check Stopping Criterion
        if (grad_norm<epsilon) || iteration>20
            break
            disp(iteration)
            
        end
       
        %6.--------- Solve the Standard Least-Square Problem
        A_mat=[H_grad_nsq'; G_grad_nsq';sqrt(lambda_k)*eye(16)];
        F_k=[D1_y;D2_z];
        b=[A_mat(1:40,:)*x_k-F_k;sqrt(lambda_k)*x_k];
        
        x_k_hat=pinv(A_mat)*b;
        %     x_k_hat=inv(A'*A)*A'*b;
        
        %7. Evaluate if better + update lambda
        %Build F(new_iteration)
        D1=reshape(A_val+E1*x_k_hat,[2,16]);
        D1_norm=vecnorm(D1)';
        D1_y=D1_norm-y;
        
        D2=reshape(E2*x_k_hat,[2,24]);
        D2_norm=vecnorm(D2)';
        D2_z=D2_norm-z;
        F_k_hat=[D1_y;D2_z].^2;
        
        x_k=x_k_hat;
        
        if sum(F_k_hat)<sum(F_k.^2)
            
            x_k=x_k_hat;
            lambda_k=0.7*lambda_k;
        else
            lambda_k=2*lambda_k;
        end

        %8. update k
        iteration=iteration+1;
    end
    disp(i);
    
    Xs_out=[Xs_out x_k];
    
end