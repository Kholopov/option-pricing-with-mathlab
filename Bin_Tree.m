clear
clc

% Initial data
S0=10;
T=1;
sg=0.3;
%n=1000; % number of subperiods
X=10;
r=0.03;
q=0.05; % continuous dividend yield
N=1000; % The maximum number of subperiods 

% prespecification of matrices
Bin_call_price=nan(size(2:1:N));
Am_Bin_call_price=nan(size(2:1:N));

k=1; % helping address variable, used to save results for different n
for n=2:1:N
[S,u,d,delta_t]=CRR_Stock(T,sg,n,S0);

% probability of moves
p=(exp((r-q).*delta_t)-d)./(u-d);

% pre-specify your option prices (call)
Call_price=zeros(n+1,n+1);
Am_Call_price=zeros(n+1,n+1);

% Terminal payoff of the call at column n+1
Call_price(:,n+1)=max(0,S(:,n+1)-X);
Am_Call_price(:,n+1)=max(0,S(:,n+1)-X);

% Backward iteration procedure
for j=n:-1:1 % change the column: go backwards
    for i=1:j % change the row
       Call_price(i,j)=exp(-r.*delta_t).*(p*Call_price(i,j+1)+(1-p)*Call_price(i+1,j+1));
       Am_Call_price(i,j)=max(exp(-r.*delta_t).*(p*Am_Call_price(i,j+1)+(1-p)*Am_Call_price(i+1,j+1)),S(i,j)-X);   
    end
end
% save the call price in a separate matrix for graphical representation
        Bin_call_price(k)=Call_price(1,1);
        Am_Bin_call_price(k)=Am_Call_price(1,1);  

k=k+1; % increase the addressing variable by one, the new price should be written down as the next element of the row-vector
end

% Use BSM to compute your call under the same data
[BSM_call]=BSM_price(S0,X,r,q,sg,T);

%% Graphical representation of Binomial price vs the BSM price
figure;
semilogx(Bin_call_price);
hold on;
semilogx(BSM_call*ones(size(Bin_call_price)));
hold on;
semilogx(Am_Bin_call_price);
hold off;
legend('European binomial price','BSM price','American binomial price');
xlabel('Number of Subintervals');
ylabel('Call Price');
title('BSM Price vs Binomial Price');
