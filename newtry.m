close all;clear all;
L=15;
N=1000
Pf=0.01:0.01:1;
snr_dB=(-20:1:-10);
SNR = 10.^(snr_dB./10);
for a=1:length(SNR)
    a
    for m=1:length(Pf)
        m
        ii=0;
       for kk=1:N
             n = randn(1,L); % noise 
         s = (SNR(a)).*randn(1,L); 
           x=s+n;
            X=fft(x);
                Td(m)=sum(X.^2)/L;

             mu0(m)=var(n);
            sig0(m)=mu0(m)/sqrt(L);
            mu1(m)=(sig0(m).*(SNR(a)+1)).^2;
            sig1(m)=sig0(m).*sqrt(2*SNR(a)+1); 
            thres(m)=sig0(m)*qfuncinv(Pf(m))+mu1(m);
          %  Pd(m)=qfunc((sig0(m)*qfuncinv(Pf(m))+mu0(m)-mu1(m))/sig1(m));
          Pd(m) =qfunc((thres-mu1)/sig1);
      
              if((Td(m))>thres(m))
                    ii=ii+1;
              end
            
       end
        Pd_prac(m)=ii/N;
    end
    figure
    plot(Pf,Pd,'b');
    hold on
     plot(Pf,Pd_prac,'r');
    hold on
    figure
    
end
plot(snr_dB,Pd,'g');
    hold on
