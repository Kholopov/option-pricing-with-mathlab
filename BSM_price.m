function [BSM_call,delta_call,gamma_call,vega_call,theta_call,upper_bound,lower_bound]=BSM_price(S,X,r,q,sg,T)

d1=(log(S./X)+(r-q+0.5.*sg.^2).*(T))./(sg.*sqrt(T));
d2=d1-sg.*sqrt(T);

% risk-neutral probabilities
Nd1=normcdf(d1);
Nd2=normcdf(d2);

% call price
BSM_call=S.*exp(-q.*T).*Nd1-X.*exp(-r.*T)*Nd2;

% delta 
delta_call=exp(-q.*T).*Nd1;

derivatives=1/sqrt(2.*pi).*exp(-0.5.*d1^2);

%theta
theta_call=-((S.*derivatives.*sg.*exp(-q.*T))./(2.*sqrt(T)))-((-q).*S.*exp(-q.*T)*Nd1)-(r.*X.*exp(-r.*T)*Nd2);

%gamma
gamma_call=(derivatives.*exp(-q.*T))./(S.*sg.*sqrt(T));
%vega
vega_call=S.*sqrt(T).*derivatives.*exp(-q.*T);
%upper bound
upper_bound=S.*exp(-q.*T);


if S <= X
    lower_bound=0
    else
    lower_bound=S.*exp(-q.*T)-X.*exp(-r.*T)
    end

end





