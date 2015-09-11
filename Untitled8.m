close all;clear all;
L=500;  %Number of samples in an observation period
snr_dB=-20; %Siganl to noise ration in db
N=1000;%Total number observations for a single Pf value

M=15; % average energy of M consecuitve periods of N periods of Observations.
%snr_db= -10; % SNR in decibels
snr = 10.^(snr_dB./10); % Linear Value of SNR
Pf = 0.01:0.01:1; % Pf = Probability of False Alarm

%% Simulation to plot Probability of Detection (Pd) vs. Probability of False Alarm (Pf) 
% using variable threshold algorithm
for m = 1:length(Pf)
    m
  
   ii(m)=0;
     % Theoretical value of Threshold,fgfnhb refer, Sensing Throughput Tradeoff in Cognitive Radio, Y. C. Liang
    for kk=1:N % 
     
     n = randn(1,L); % noise 
     sig(kk) =var(n);
     s = (snr).*randn(1,L); % Primary User Signal
     Vav(kk)=mean(n);
     
     Vmax(kk)=max(n);
     rho(kk)=abs(Vmax(kk)/Vav(kk));
     y = s + n; % pu present and adding noise 
     
     
     energy = abs(y).^2; % Energy of received signal over N samples
     energy_fin(kk) =(1/L).*sum(energy); % Test Statistic for the energy detection
        thresh(m) = (qfuncinv(Pf(m))./sqrt(L))+ 1;
       if(kk>M)
                    Di_avg(kk)=(1/M)*(sum(energy_fin(kk-M:kk)));  %take average of M observation before current observation period
                else 
                    Di_avg(kk)=(1/kk)*(sum(energy_fin(1:kk))); %take whatever samples avaiable before current observation period
       end
        %  thresh(kk) = sig(kk)*((qfuncinv(Pf(m)).*sqrt(2*L))+ L);
        if(Di_avg(kk) >=(thresh(m))  ) %compare average of M energy period with threshold
            thresh_new(kk)=thresh(m)/rho(kk);
           
           
         else 
              thresh_new(kk)=thresh(m)*rho(kk);
        end
              if(energy_fin(kk)>=thresh_new(kk)) % compare current period with new threshold
          ii(m) = ii(m)+1;
              end
    end 
      Pd(m) =ii(m)/N; 
   
 end
    
  %% classical Energy detection alorith  
  for m = 1:length(Pf)
    m
  
   zz(m)=0;
     
    for kk=1:N % 
     
     nc = randn(1,L); % noise 
     sc = (snr).*randn(1,L); % Primary User Signal
     yc= sc + nc; % pu present and adding noise 
     
     
     energy_c = abs(yc).^2; % Energy of received signal over N samples
     energy_fin_c(kk) =(1/L).*sum(energy_c); % Test Statistic for the energy detection
        thresh_c(m) = (qfuncinv(Pf(m))./sqrt(L))+ 1;
     
        %  thresh(kk) = sig(kk)*((qfuncinv(Pf(m)).*sqrt(2*L))+ L);
      
              if(energy_fin_c(kk)>=thresh_c(m))
          zz(m) = zz(m)+1;
              end
    end 
      Pz(m) =zz(m)/N; 
   
 end  
    
figure
plot(smooth(Pf,20),smooth(Pz,20),'b') %Pd of IED
hold on
plot(smooth(Pf,20),smooth(Pd,20),'g')%Pd of Classical Detection
 hold on