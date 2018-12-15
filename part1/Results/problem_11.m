
x_it=x;%Results from previous otpimization model
thrs=10^-6;
out_wpoints=zeros(10,6);
weights=zeros(M,K);
%------------Model:
for m=0:M-1
    cvx_begin quiet  
    %Initializations
    variable x(4,T);
    variable u(2,T);
    
    
    f=0;%Define Objective Function
    for i=1:K
        fi=norm(x(1:2,ts(i))-W(:,i),2);
        %             disp(fi)
        %weight=power((norm(x_it(1:2,ts(i))-W(:,i))+epsilon),-1);
        weight=norm(x_it(1:2,ts(i))-W(:,i),2)+epsilon;
        weights(m+1,i)=1/weight;
        disp(1/weight)
        
        f=fi/weight+f;
    end    
    minimize(f)
    subject to
    x(:,1)==ci; %assuming vi=0
    x(:,T)==cf; %assuming vf=0
    for i=1:T
        norm(u(:,i))<=Umax;
    end
    for i=2:T
        x(:,i)==A*x(:,i-1)+B*u(:,i-1);
    end
    cvx_end
    x_it=x;
    % C) How many waypoints are captured?
    for i=1:K
        if norm(x(1:2,ts(i))-W(:,i))<thrs
            out_wpoints(m+1,i)=1;
        end
    end
    
end