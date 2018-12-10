function val=f(X,Y,xk)

  K=length(X);
  
  new_x = [X;-ones(1,size(X,2))];
  
  val = (1/K)*(sum(log(1+exp(xk*new_x)))-Y*(xk*new_x)');

end