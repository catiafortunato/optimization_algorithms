function [out] = F(iA,iS,A,y,z,S)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


% f1_aux=vecnorm(A(:,iA(:,1))-S(:,iA(:,2)))-y;
% f1=diag(f1_aux'*f1_aux)'*ones(16,1);
% 
% f2_aux=vecvecnorm(S(:,iA(:,1))-S(:,iA(:,2)))-z;
% f2=diag(f2_help'*f2_help)'*ones(24,1);

f1_aux=vecnorm(A(:,iA(:,1))-S(:,iA(:,2)))-y;
f2_aux=vecvecnorm(S(:,iA(:,1))-S(:,iS(:,2)))-z;

out=diag(f1_aux'*f1_aux)+diag(f2_aux'*f2_aux);

end

