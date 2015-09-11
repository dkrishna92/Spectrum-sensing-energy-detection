close all
clear all
hold all
figure
L=400;  %Number of samples in an observation period
snr_dB=-15; %Siganl to noise ration in db
N=1000;%Total number observations for a single Pf value
snr = 10.^(snr_dB./10); % Linear Value of SNR
  %% classical Energy detection alorith  
 for P=1:5
      P
      Pf = 0.01:0.01:1;
      for m = 1:length(Pf)
        m
 
       zz(m)=0;

        for kk=1:N % 

         n = randn(1,L); % noise 
         s = (snr).*randn(1,L); % Primary User Signal
         y= s + n; % pu present and adding noise 
%             mu0(m)=var(n);
%             sig0(m)=mu0(m)/sqrt(L);
%             mu1(m)=(sig0(m).*(snr+1)).^2;
%             sig1(m)=sig0(m).*sqrt(2*snr+1); 
         
        mu0(P)=((2)^(P/2)/sqrt(pi))*gamma((P+1)/2)*(var(n)^(P/2));
        sig0(P)=((2)^(P)/sqrt(pi))*(gamma((2*P+1)/2)- (1/sqrt(pi)*(gamma((P+1)/2)^2)))*(var(n)^(P));
        mu1(P)=((2^(P/2))*(1+snr)^(P/2)/sqrt(pi))*gamma((P+1)/2)*(var(n)^P);
        sig1(P)=(((2)^(P)/sqrt(pi))*(1+snr)^P)*(gamma((2*P+1)/2)- (1/sqrt(pi)*(gamma((P+1)/2)^2)))*(var(n)^(P));
         thresh(P)=sig0(P)*qfuncinv(Pf(m))+mu1(P);
         energy= (abs(y)).^P; % Energy of received signal over N samples
         energy_fin(kk) =(1/L).*sum(energy); % Test Statistic for the energy detection
          %  thresh_c(m) = ((qfuncinv(Pf(m))./sqrt(L))+ 1);

            %  thresh(kk) = sig(kk)*((qfuncinv(Pf(m)).*sqrt(2*L))+ L);

                  if(energy_fin(kk)>=thresh(P))
              zz(m) = zz(m)+1;
                  end
                  
        end 
         
    Pz(m) =zz(m)/N; 
     end  
    

plot(smooth(Pf,20),smooth(Pz,20),'Color',rand(1,3))%Pd of Classical Detection
 axis([0 1 0 1])
hold on
 end
 legend('P=1','P=2','P=3','P=4','P=5');
