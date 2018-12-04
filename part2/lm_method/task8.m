
%-------------------------Otimization and Algorithms----------------------%
%-------------------------------Projet - Part 2 --------------------------%
%-------------------------------------------------------------------------%


% --------Work by:------%
% Catia Fortunato
% Maria In�s Diegues
% Joao Carvalho
% -------Supervision by------%
% Profesor Jo�o Xavier


%%
clear all;
close all;



%% ---------------------------------------------------------------
%%----------------------2. Network Localization-------------------
%%----------------------------------------------------------------

%% Initialization of the problem

%Load data
cd 'C:\JFCImportantes\Universidade\5� Ano - 1� Semestre\OA\Project\optimization_algorithms\part2\lm_method'
data=load('lmdata1.mat');
xinit=data.xinit; %Initialization of the method 

A=data.A; %Positions of anchors
S=data.S; %True positions of sensors)
iA=data.iA; %Pair of (anchor,sensor)
iS=data.iS; %Pair if (sensor sensor)

y=data.y; %Noisy measurerments (anchor, sensor)
z=data.z; %Noisy Measurements (sensor, sensor)



%% Running the LM Model


%1. Hiperparameters
lambdak=1;epsilon=10^-6;x_k=xinit;

%2. Set k=0
k=0;
convergence=0;
%3. Start Loop
while convergence==0
    
    %4. Compute Gradient
    G_xk=F_grad(x_k);
    %5. Check Stopping Criterion
    if (norm(F_xk)<epsilon)
        break
    end
    
    %6. Solve the Standard Least-Square Problem
    A=[G_xk lambdak;
    b=
    x_khat=pinv(;
    %7. Evaluate if better + update lambda
    if F(x_k1_hat)<F(x_k)
        x_k=x_khat;
        lambdak=0.7*lambdak;
    else 
        lambdak=2*lambdak;
    end
    %8. update k
%         k=k+1:
end
    
    


