
%-------------------------Otimization and Algorithms----------------------%
%-------------------------------Projet - Part 1 --------------------------%
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

%% --------------------------Variation A




%% -------------------------Variation C

%----------Constants:
T=80;
pi=[0,5]; %initial position
pf=[15,-15]; %final position
A=[1 0 0.1 0; 0 1 0 0.1; 0 1 0 0.1; 0 0 0.9]
B=[0 0; 0 0; 0.1 0; 0 0.1]


%% 4.2 Squared l-2  Formulation 

cvx_begin quiet
	variable x(t);
	
	minimize 

	subject to
	x(0)=pi
	x(T)=pf
	norm(u,2)=<Umax
	x(t+1)=A*x(t)+B*u(t)