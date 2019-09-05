function [DOC_call]=BSM_DOC_Price(r,sg,T,H,X,S0)
d1=(log(S0./X)+(r+0.5.*sg.^2).*(T))./(sg.*sqrt(T));
d2=d1-sg.*sqrt(T);
d3=(log(((H.^2)./S0)./X)+(r+0.5.*sg.^2).*(T))./(sg.*sqrt(T));
d4=d3-sg.*sqrt(T);

% risk-neutral probabilities
Nd1=normcdf(d1);
Nd2=normcdf(d2);
Nd3=normcdf(d3);
Nd4=normcdf(d4);
gamma=2.*r./(sg.^2);

% call price
DOC_call=(S0.*Nd1)-(X.*exp(-r.*T).*Nd2)-((H./S0).^(gamma-1)).*(((H.^2)./S0).*Nd3-X.*exp(-r.*T).*Nd4);