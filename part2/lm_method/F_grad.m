function [out] = F_grad(S,A,iS,iA)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

D_as=repmat(A,8,1)-repmat(S(:),1,4); %Columns->a's, Lines->s's (16X4)
D_ss=repmat(S(:),1,8)-repmat(S,8,1);


H=zeros(8,1);

 
    

out=S;
end

