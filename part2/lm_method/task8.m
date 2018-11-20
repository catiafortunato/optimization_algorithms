
%-------------------------Otimization and Algorithms----------------------%
%-------------------------------Projet - Part 2 --------------------------%
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



k=0;
convergence=0;
while b==False
    a=1;
    gk=
    %1. compute gradient
    %2. evaluate stopping criterion
    %3. solve optimization problem
    %4. Evaluate if better + update lambda
    %5. update k
    
end
k=0;
% for 
    
    


