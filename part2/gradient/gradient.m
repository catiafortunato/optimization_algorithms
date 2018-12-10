function grad=gradient(X,Y,xk)

K=length(X);

new_x = [X;-ones(1,size(X,2))];

% Gradient (first 2 rows for s and the last one is for the r)

grad=(1/K)*(sum(new_x.*(exp(xk*new_x)./(1+exp(xk*new_x))),2)- sum(new_x.*Y,2));
 
end