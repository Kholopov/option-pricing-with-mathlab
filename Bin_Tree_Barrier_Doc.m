clear
clc
%S0=1000;
s=1000;
T=0.25;
sg=0.4;
n=1000;
X=1000;
r=0.05;
q=0;
A=800;
h=0.3;
% prespecification of matrices
Bin_Barrier_DOC_call_price=nan(size(0:1:s));
k=1;% helping address variable, used to save results for different S0
for S0=0:1:s
[S,u,d,delta_t]=CRR_Stock(T,sg,n,S0);
%probability of stock prices
p=(exp((r).*delta_t)-d)./(u-d);
%pre-specify option prices (call)
Barrier_DOC_Call_price=zeros(n+1,n+1);
%terminal payoff of the call at column n+1
Barrier_DOC_Call_price(:,n+1)=max(0,S(:,n+1)-X);
%backward iteration procedure
for j=n:-1:1%column change
    for i=1:j%row change
        if S(:,n+1)>A.*exp(h.*(delta_t.*n))
            Barrier_DOC_Call_price(:,n+1)=max(0,S(:,n+1)-X);
        elseif S(i,j)>A*exp(h.*(delta_t.*(j-1)))
        Barrier_DOC_Call_price(i,j)=exp(-r.*delta_t).*...
            (p*Barrier_DOC_Call_price(i,j+1)+(1-p)*Barrier_DOC_Call_price(i+1,j+1));
        else Barrier_DOC_Call_price(i,j)=0;
        end
    end
end
% save the call price in a separate matrix for graphical representation
 Bin_Barrier_DOC_call_price(k)=Barrier_DOC_Call_price(1,1);
k=k+1;% increase the addressing variable by one, the new price should be written down as the next element of the row-vector
end
% Use BSM to compute your call under the same data
l=1;
for S0=0:1:s
[Barrier_DOC_call(l)]=BSM_Barrier_DOC_Price(A,r,sg,T,X,S0,h);
l=l+1;
end
%%
S_graph=0:1:s;
figure;
plot(S_graph,Bin_Barrier_DOC_call_price); hold on; plot(S_graph,Barrier_DOC_call);hold off
xlim([800 inf]);
ylim([-10 100]);
legend('Binomial DOC Price','BSM DOC Price');
xlabel('Stock Price');
ylabel('Theoretical DOC Price');
title('BSM DOC Price vs Binomial DOC Price with a Moving Barrier');
 