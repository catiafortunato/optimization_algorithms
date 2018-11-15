
%-------------------------Otimization and Algorithms----------------------%
%-------------------------------Projet - Part 1 --------------------------%
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

data=load('lmdata1.mat');

xinit=data.xinit; %Initialization of the method 

A=data.A; %Positions of anchors
S=data.S; %True positions of sensors)
iA=data.iA; %Pair of (anchor,sensor)
iS=data.iS; %Pair if (sensor sensor)

y=data.y; %Noisy measurerments (anchor, sensor)
z=data.z; %Noisy Measurements (sensor, sensor)

%Hiperparameters
lambda0=1;epsilon=10^-6;

%% Running the LM Model
% Definition of objective function

cvx_begin quiet
variable S_u(2,8)

%Definition of the cost function
f=(A(:,iA(:,1))-S_u(:,iA(:,2)))'* %cENA QUE O PROF FEZ!!

ones(2,1))-y(iA))

k=0;
while !convergence:
    %1. compute gradient
    %2. evaluate stopping criterion
    %3. solve optimization problem
    %4. Evaluate if better + update lambda
    %5. update k
    


k=0;
% for 
    
    


