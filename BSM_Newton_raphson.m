

function [sg0]=Newton_raphson(S,X,T,p,c)
clear 
clc
[num,txt,raw]=xlsread('Daten11.xlsx');
d=str2double(raw);
X=d(:,1);
p=d(:,2);
c=d(:,3);
S=10077;
T = 0.6739726;
r=log((S-c+p)./X)./(-T);
R=mean(r);
R=0.0101;

%memory for the vector
    sg0=zeros(10000,1);
    %first  elements
    sg0=0.3; 
    f=X.*exp((-r).*T).*(1-normcdf((log(S./X)+(R+0.5.*(sg0.^2)).*(T))./(sg0.*sqrt(T))-sg0.*sqrt(T)))-S.*(1-normcdf((log(S./X)+(R+0.5.*(sg0.^2)).*(T))./(sg0.*sqrt(T))));
    fprime=S.*((1./sqrt(2.*pi)).*exp(-0.5.*(((log(S./X)+(0.5.*(sg0.^2)).*(T))./(sg0.*sqrt(T))).^2))).*(1./(2.*sg0)).*sqrt(T);
    sg1=sqrt((sg0.^2)-(f-p)./(fprime));
    
    while(abs(sg1-sg0))>0.0001 
    %Newton Raphson itself
    sg0=sg1; 
    f=X.*exp((-r).*T).*(1-normcdf((log(S./X)+(R+0.5.*(sg0.^2)).*(T))./(sg0.*sqrt(T))-sg0.*sqrt(T)))-S.*(1-normcdf((log(S./X)+(R+0.5.*(sg0.^2)).*(T))./(sg0.*sqrt(T))));
    fprime=S.*((1./sqrt(2.*pi)).*exp(-0.5.*(((log(S./X)+(0.5.*(sg0.^2)).*(T))./(sg0.*sqrt(T))).^2))).*(1./(2.*sg0)).*sqrt(T);
    sg1=sqrt((sg0.^2)-(f-p)./(fprime));
    end
    sg0;
    S_graph=X./S;
    %sg0=nan(size(S_graph));
    figure;
    plot(S_graph,sg0); 
    xlabel('Moneyness');
    ylabel('Implied volatility');
    title('Volatility smile');
end


