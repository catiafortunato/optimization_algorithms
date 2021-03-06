
%-------------------------Otimization and Algorithms----------------------%
%-------------------------------Projet - Part 2 --------------------------%
%-------------------------------------------------------------------------%


% --------Work by:------%
% Catia Fortunato
% Maria In�s Diegues
% Joao Carvalho
% -------Supervision by------%
% Profesor Jo�o Xavier


%correr task 8
%- prep plots
%correr task 9
%-prep plots




%% ---------------------------------------------------------------
%%----------------------2. Network Localization-------------------
%%----------------------------------------------------------------

%% Initialization of the problem --- Task 9

clear all
close all

%Load data
cd 'C:\JFCImportantes\Universidade\5� Ano - 1� Semestre\OA\Project\optimization_algorithms\part2\lm_method'
data=load('lmdata2.mat');

A=data.A; %Positions of anchors
iA=data.iA; %Pair of (anchor,sensor)
iS=data.iS; %Pair if (sensor sensor)

y=data.y; %Noisy measurerments (anchor, sensor)
z=data.z; %Noisy Measurements (sensor, sensor)


%% Defining the Auxiliary Matrices
tic
A_val=reshape(A(:,iA(:,1)),[32,1]);

E1=zeros(32,16);
E_help=repmat(2*iA(:,2),1,2);
E_help(:,1)=E_help(:,1)-ones(16,1);
E_help=(reshape(E_help',32,1)-ones(32,1))*32+(1:32)';
E1(E_help)=-1;

E2=zeros(48,16);
E_help=repmat(2*iS(:,2),1,2);
E_help(:,1)=E_help(:,1)-ones(24,1);
E_help=(reshape(E_help',48,1)-ones(48,1))*48+(1:48)';
E2(E_help)=-1;

E_help=repmat(2*iS(:,1),1,2);
E_help(:,1)=E_help(:,1)-ones(24,1);
E_help=(reshape(E_help',48,1)-ones(48,1))*48+(1:48)';
E2(E_help)=1;

% toc
%0.004293s
%% Running the LM Model
tic
Xs_out=[];
Xs_in=[];
norms=[];
for i=1:1000
    %1. Hiperparameters
    lambda_k=1;epsilon=10^-6;
    xinit=(rand(16,1)*2-ones(16,1))*15;
    x_k=xinit;
    Xs_in=[Xs_in x_k];
    
    %2. Set k=0
    iteration=1;
    convergence=0;
    norms_midle=[]
    function_midle=[]
    %%
    
    %3. Start Loop
    while 1
        
        %4.----------Compute Gradient
        %%
        %         tic
        %First Summation
        D1=reshape(A_val+E1*x_k,[2,16]);
        D1_norm=vecnorm(D1)';
        D1_y=D1_norm-y; %Equivalent to the function H (without the square)
        
        H_grad_nsq=(E1'.*repmat(reshape((D1'./D1_norm)',32,1)',16,1));
        H_grad_nsq=(H_grad_nsq(:,1:2:end)+H_grad_nsq(:,2:2:end));
        H_grad=repmat(2*D1_y',16,1).*H_grad_nsq;
        
        %     toc
        %0.0024
        
        %Second Summation
        %     tic
        D2=reshape(E2*x_k,[2,24]);
        D2_norm=vecnorm(D2)';
        D2_z=D2_norm-z;%Equivalent to the function G (without the square)
        
        G_grad_nsq=(E2'.*repmat(reshape((D2'./D2_norm)',48,1)',16,1));
        G_grad_nsq=(G_grad_nsq(:,1:2:end)+G_grad_nsq(:,2:2:end));
        G_grad=repmat(2*D2_z',16,1).*G_grad_nsq;
        
        %     toc
        %%
        %0.0046
        
        
        %Gradient
        %     tic
        Gradient=sum(G_grad,2)+sum(H_grad,2);
        grad_norm=norm(Gradient,2);
        norms_midle=[norms_midle grad_norm];
        
        %     toc
        
        %%
        
        %5. --------------- Check Stopping Criterion
        if (grad_norm<epsilon) || iteration>20
            break
            disp(iteration)
            
        end
        %%
        
        %6.--------- Solve the Standard Least-Square Problem
        
        A_mat=[H_grad_nsq'; G_grad_nsq';sqrt(lambda_k)*eye(16)];
        F_k=[D1_y;D2_z];
        function_midle=[function_midle sum(F_k)];
        b=[A_mat(1:40,:)*x_k-F_k;sqrt(lambda_k)*x_k];
        
        x_k_hat=pinv(A_mat)*b;
        %     x_k_hat=inv(A'*A)*A'*b;
        
        
        
        
        
        %%
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
        %         disp('-----')
        %         disp(x_k')
        %8. update k
        iteration=iteration+1;
    end
    disp(i);
    
    norms=[norms grad_norm];
    Xs_out=[Xs_out x_k];
    
    
    figure(2);
    A_plot=A';
    clf
    x_k=reshape(x_k',2,[])';
    xinit_plot=reshape(xinit',2,[])';
    scatter(x_k(:,1),x_k(:,2),'o','r'); hold on;
    scatter(A_plot(:,1),A_plot(:,2),'x','m')
    scatter(xinit_plot(:,1),xinit_plot(:,2),'*','MarkerEdgeColor',[0 0.7 0.5])
    
    
    axis([-15 15 -15 15])
    grid on
    grid minor
    pause(0.3)
    
%     figure(1);
%     clf
%     semilogy(norms_midle,'Color','b');
%     grid on
%     grid minor
%     pause(0.3)
% 
%     figure(3);
%     clf
%     semilogy(function_midle,'Color','b');
%     grid on
%     grid minor
%     pause(0.3)

end
toc

%%
A_plot=A';
%%
figure(3)
clf
[minim index] =min(norms);
disp(minim)

xinit_plot=reshape(xinit',2,[])';
x_min=Xs_out(:,index);
x_final=reshape(x_min',2,[])';
x_init_plot=Xs_in(:,index);
scatter(x_final(:,1),x_final(:,2),'o','r'); hold on;
scatter(A_plot(:,1),A_plot(:,2),'x','m');hold on;
scatter(xinit_plot(:,1),xinit_plot(:,2),'*','MarkerEdgeColor',[0 0.7 0.5]);hold on;
axis([-15 15 -15 15])
grid on
grid minor