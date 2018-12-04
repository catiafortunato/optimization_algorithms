function [out] = F(iA,iS,A,y,z,S)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


tic
f1_aux=vecnorm(A(:,iA(:,1))-S(:,iA(:,2)))-y;
f2_aux=vecnorm(S(:,iS(:,1))-S(:,iS(:,2)))-z;

out=sum(diag(f1_aux'*f1_aux))+sum(diag(f2_aux'*f2_aux));
toc



end

