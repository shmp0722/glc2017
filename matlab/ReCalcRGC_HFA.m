function ReCalcRGC_HFA

%% laod data

dB = xlsread('/Users/shumpei/Google Drive/CSFI/glc2017/Test_recalc.xlsx',1);
tp = xlsread('/Users/shumpei/Google Drive/CSFI/glc2017/Test_recalc.xlsx',2);

%% eccentricity
[N,~] = size(dB);
RGC_HFA = nan(N,length(tp));
for sub = 1:N
    for i = 1:length(tp)
        ec(i)  =  sqrt(tp(1,i)^2+tp(2,i)^2);
        
        RGC_HFA(sub,i) = 10^(0.1*(dB(sub,i)-1-(-1.5*1.34*ec(i)-14.8))/(0.054*1.34*ec(i)+0.9))*2.95/9;
    end
end

Total_RGC_HFA =  sum(RGC_HFA,2)