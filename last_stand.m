close all;clear all;
L=15;
snr_dB=(-24:1:-16);


SNR = 10.^(snr_dB./10); % Linear Value of SNR

N_prac=1000;
%N=zeros(length(SNR));
for m = 1:length(SNR)
    m;
    ii=0;
 
        
        n = randn(1,L); % noise 
        s = (SNR(m)).*randn(1,L); 
       x=s+n;
     
        mu0(m)=var(n);
        sig0(m)=mu0(m)/sqrt(L);
        mu1(m)=(sig0(m).*(SNR(m)+1)).^2;
        sig1(m)=sig0(m).*sqrt(2*SNR(m)+1);
        %Pf=qfunc((thres-mu0)/sig0);
        %Pd=qfunc((thres-mu1)/sig1);
    
        Pf(m)=qfunc(((SNR(m)*sqrt(L)/2)+(mu1(m)-mu0(m))*(1+SNR(m))/sig1(m))/(1+(1+SNR(m))*sig0(m)/sig1(m)));
        Pd(m)=qfunc((sig0(m)*qfuncinv(Pf(m))+mu0(m)-mu1(m))/sig1(m));
       % Pf=qfunc((sig1*qfuncinv(Pd)-mu0+mu1)/sig0);
      %(sqrt(2).*(qfuncinv(Pf)+qfuncinv(Pd)))./(sqrt(L)-qfuncinv(Pd)*sqrt(2))=SNR;
      % Pf=qfunc((thres*(sqrt(L)-qfuncinv(Pd)*sqrt(2))-qfuncinv(Pd))/sqrt(2));
       thres(m)=sig0(m)*qfuncinv(Pf(m))+mu1(m);
       N(m)=((sig0(m).*qfuncinv(Pf(m))-sig1(m).*qfuncinv(Pd(m)))./(mu1(m)-mu0(m))).^2;

end
Pf_prac=0:0.01:1;
for m=1:length(SNR)

    for a=1:length(Pf_prac)
        ii=0;
        for kk=1:N_prac
             n = randn(1,L); % noise 
            s = (SNR(m)).*randn(1,L); 
            x=s+n;
            X=fft(x);
            Td(m)=sum(X.^2)/L;
            if((Td(m))>thres(m))
                ii=ii+1;
            end
        end
       Pd_prac(a)=ii/N_prac; 
    end
    
    figure
    plot(smooth(Pf_prac,20),smooth(Pd_prac,20),'b')

    hold on;
end
figure
plot(snr_dB,thres,'g')
hold on;
figure
plot(snr_dB,N,'bl')
hold on;
figure
plot(Pd,Pf,'r')
hold on;
%

