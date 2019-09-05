function [Barrier_DOC_call]=BSM_Barrier_DOC_Price(A,r,sg,T,X,S0,h)
d1=(log(S0./X)+(r+0.5.*sg.^2).*(T))./(sg.*sqrt(T));
d2=(log((A.^2.)/(S0.*X))+(r+0.5.*sg.^2).*(T))./(sg.*sqrt(T));
d3=(log(S0./X)+(r-0.5.*sg.^2).*(T))./(sg.*sqrt(T));
d4=(log((A.^2.)/(S0.*X))+(r-0.5.*sg.^2).*(T))./(sg.*sqrt(T));

% risk-neutral probabilities
Nd1=normcdf(d1);
Nd2=normcdf(d2);
Nd3=normcdf(d3);
Nd4=normcdf(d4);
gamma1=(2.*(r-h))./((sg.^2)+1);
gamma2=(2.*(r-h))./((sg.^2)-1);

% call price
Barrier_DOC_call=S0.*(Nd1-(((A./S0).^gamma1).*Nd2))-exp((-r).*T).*X.*(Nd3-(((A./S0).^gamma2).*Nd4));