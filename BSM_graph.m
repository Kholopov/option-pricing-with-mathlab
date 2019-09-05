clear
clc

% Initial data
S0=160; % underlying price
X=150; % strike price
r=0.03; % risk-free interest rate
q=0.04; % continuous dividend yield
sg=0.12; % volatility
T=1; % time to maturity, given that t=0


%% For-loop for 2D Graph
% pre-specification of matrices
BSM_call=nan(1,221);
delta_call=nan(1,221);
gamma_call=nan(1,221);
vega_call=nan(1,221);
theta_call=nan(1,221);
lower_bound=nan(1,221);

upper_bound=nan(1,221);


i=1;
for S=0:1:S0*2
[BSM_call(i),delta_call(i),gamma_call(i),vega_call(i),theta_call(i),upper_bound(i),lower_bound(i)]=BSM_price(S,X,r,q,sg,T);
BSM_call_1(i)=BSM_call(i);
upper_bound_1(i)=upper_bound(i);
lower_bound_1(i)=lower_bound(i);
i=i+1;
end

T=5;
i=1;
for S=0:1:S0*2
[BSM_call(i),delta_call(i),gamma_call(i),vega_call(i),theta_call(i),upper_bound(i),lower_bound(i)]=BSM_price(S,X,r,q,sg,T);
BSM_call_2(i)=BSM_call(i);
upper_bound_2(i)=upper_bound(i);
lower_bound_2(i)=lower_bound(i);
i=i+1;
end

% 2D graphs
S_graph=0:1:S0*2;
figure;
plot(S_graph,BSM_call_1,'linewidth', 2,'color','g'); hold on; plot(S_graph,upper_bound_1,'linewidth', 2,'color','r');hold on;
plot(S_graph,lower_bound_1,'linewidth', 2,'color','b');hold on;plot(S_graph,BSM_call_2,'linewidth', 2,'color','m'); hold on; plot(S_graph,upper_bound_2,'linewidth', 2,'color','y');hold on;
plot(S_graph,lower_bound_2,'linewidth', 2,'color','c');hold off;

xlabel('Stock Price');
ylabel('Call Price');
title('Call Price and Boundaries');
legend('BSM Call 1','Upper bound 1','Lower bound 1','BSM call 2','Upper bound 2','Lower bound 2','Location','northwest');

%% For-loops for 3D graphs
% pre-specification of matrices
BSM_call=nan(221,30);
delta_call=nan(221,30);
gamma_call=nan(221,30);
vega_call=nan(221,30);
theta_call=nan(221,30);


S_graph=nan(221,30);
T_graph=nan(221,30);

j=1;
for T=0.1:0.1:3
i=1;
    for S=0:1:S0*2
    [BSM_call(i,j),delta_call(i,j),gamma_call(i,j),vega_call(i,j),theta_call(i,j),upper_bound(i,j),lower_bound(i,j)]=BSM_price(S,X,r,q,sg,T);
    S_graph(i,j)=S;
    T_graph(i,j)=T;
    i=i+1;
    end
j=j+1;
end

% 3D figures
figure;
surf(S_graph,T_graph,BSM_call);
xlabel('Stock Price');
ylabel('Time to Maturity');
zlabel('Call Price');
title('Call Price as a Function of S and T');

figure;
surf(S_graph,T_graph,delta_call);
xlabel('Stock Price');
ylabel('Time to Maturity');
zlabel('Delta');
title('Delta Call as a Function of S and T');

figure;
surf(S_graph,T_graph,gamma_call);
xlabel('Stock Price');
ylabel('Time to Maturity');
zlabel('Gamma');
title('Gamma Call as a Function of S and T');

figure;
surf(S_graph,T_graph,vega_call);
xlabel('Stock Price');
ylabel('Time to Maturity');
zlabel('Vega');
title('Vega Call as a Function of S and T');

figure;
surf(S_graph,T_graph,theta_call);
xlabel('Stock Price');
ylabel('Time to Maturity');
zlabel('Theta');
title('Theta Call as a Function of S and T');





