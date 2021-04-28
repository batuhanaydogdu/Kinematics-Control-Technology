M = xlsread('Mali19_EMG_rdh1');

for n = 2: 9
    MM = M(: ,n);
    SF = 1000;       %SF is sampling frequency of singal we want to filter
    lf = 20;         %lf is the frequency below which we filter out the sinus compoents
    hf = 400;        %hf is the highest frequency above which we filter out the sinus compoents
    [b,a] = butter(4,[lf,hf]/(SF)/2);
    FilteredMM = filter(b,a,MM);
    figure(n-1);
    subplot(3,1,1);
    plot(FilteredMM)
   
    drawnow
    hold on

    [c,d] = butter(4,[49,51]/(SF)/2,'stop');    %this line is used for the cut off the (sinus) componedt with 50 HZ
    FilteredMM2 = filter(c,d,FilteredMM);                %this should be dine to cut off
    subplot(3,1,2);
    
    plot(FilteredMM2)     
  
       

 
    length = size(MM);

    a = 40;% a is the length of the averaging window

    for i = a+1 : length(1) - a
        rms(i) = sqrt(sum(MM(i-a:i+a).^2)/(2*a+1)); % smoothing the signal with a sliding window 
    end
    subplot(3,1,3);
    plot(rms(a+1:length-a))
  filename=['Mali19_EMG_rdh1',num2str(n)]
  
 xlswrite('filenev,rms');
end