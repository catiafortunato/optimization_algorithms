function f = log_regresion(sk,X,yk)
% Compute logistic regression over a data set xk 
K=size(X,2);

f = (1/K)*(sum(log(1+exp(sk*X)))-yk*(sk*X)');

end
