close all;clear all;
L=15;   %Number of samples in an observation period
M=5;    % average energy of M consecuitve periods of N periods of Observations.
snr_dB=-10.83; %Siganl to noise ration in db
N=1000; %Total number observations for a single Pf value

snr = 10.^(snr_dB./10); % Linear Value of SNR
Pf = 0.01:0.01:1; % Pf = Probability of False Alarm



%% Simulation to plot Probability of Detection (Pd) vs. Probability of False Alarm (Pf) 
% using Improved energy detection algorithm
for m = 1:length(Pf)
    m
     zz(m)=0;
     ii(m)=0;
     % Theoretical value of Threshold,fgfnhb refer, Sensing Throughput Tradeoff in Cognitive Radio, Y. C. Liang
    for kk=1:N % 
      
     n = randn(1,L); % noise 
     sig(kk) =var(n);  %noise variance
     s = (snr).*randn(1,L); % Primary User Signal
    
     
     y = (s) + (n); % H1 hypothesis testing
     energy = abs(y).^2; % Energy of received signal over L samples
     energy_fin(kk) =(1/L).*(sum(energy)); % average energy for an observation period
     thresh(m) = (qfuncinv(Pf(m))./sqrt(L))+ 1; %average threshold value of L samples 
       
            
          if (energy_fin(kk)>(thresh(m))) %compare current observation period energy with threshold
                ii(m)=ii(m)+1; %H1 of IED
                zz(m)=zz(m)+1; %classical energy detection
            else
                if(kk>M) %take average of M observation before current observation period
                    Ti_avg(kk)=(1/M)*(sum(energy_fin(kk-M:kk)));
                else %take whatever samples avaiable before current observation period
                    Ti_avg(kk)=(1/kk)*(sum(energy_fin(1:kk)));
                end
                    if(Ti_avg(kk)>thresh(m)) %compare average of M energy period with threshold
                        if(kk~=1)

                            if energy_fin(kk-1)>thresh(m) % compare previous penultimate period with threshold
                             ii(m)=ii(m)+1; %decision H1 of IED
                            end
                        end
                    end
         end
            
    
    
    end
  
   Pd(m)=ii(m)/N; %Pd of IED
   Pz(m)=zz(m)/N; %Pd of Classical Detection

end 


figure
plot(smooth(Pf,2),smooth(Pd,30),'g')
 hold on
 plot(smooth(Pf,2),smooth(Pz,30),'b')
 hold on
 axis([0 1 0 1])
 legend('IED','CED');
 
figure
plot(energy_fin);
hold on
axis([0 40 0 5])
 