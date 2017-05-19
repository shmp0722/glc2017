function RGCfrom10_2
%% read data
cd '/Users/shumpei/Google Drive/CSFI/glc2017';
[status,sheets] = xlsfinfo('10-2-5.xlsx');

T = readtable('10-2-5.xlsx','Sheet',2);

%% remove subjects HFA reliability is not enough
rows =  T.FP< .15 & T.FN<.33 & T.FixLoss_pcnt<.2;
T2 = T(rows,:);
clear T rows

%%


T2.RGC_HFA_adj = T2.RGC_HFA./9;
T2.RGC_HFA_adj2 = T2.RGC_HFA./64.*12;

T2.wRGC_adj = (1+T2.MD10_2/30).*T2.RGC_OCT+(-T2.MD10_2/30).*T2.RGC_HFA_adj;
T2.wRGC_adj2 = (1+T2.MD10_2/30).*T2.RGC_OCT+(-T2.MD10_2/30).*T2.RGC_HFA_adj2;

%%
figure;hold on;
plot(T2.RGC_HFA_adj,T2.RGC_HFA_adj2,'o')

addpath(genpath('BlandAltman'))
label ={'HFA1','HFA2'};
[rpc, fig, stats] = BlandAltman(T2.RGC_HFA_adj,T2.RGC_HFA_adj2,label)
%% plot 1
figure; hold on;
plot(T2.MD10_2,T2.RGC_OCT,'ob')
plot(T2.MD10_2,T2.RGC_HFA_adj,'or')
% plot(T2.MD10_2,T2.RGC_HFA_adj2,'o')

plot(T2.MD10_2,T2.wRGC_adj,'og')
xlabel('MD value')
ylabel('estimated num of RGC')
legend({'OCT','HFA','weighted'})

%% plot 2
figure; hold on;
plot(T2.MD10_2,T2.RGC_OCT,'ob')
plot(T2.MD10_2,T2.RGC_HFA_adj2,'or')
% plot(T2.MD10_2,T2.RGC_HFA_adj2,'o')

plot(T2.MD10_2,T2.wRGC_adj2,'og')
xlabel('MD value')
ylabel('estimated num of RGC')
legend({'OCT','HFA','weighted'})


%% Bland Altman

addpath(genpath('BlandAltman'))
label ={'RGC HFA','RGC OCT'};
[rpc, fig, stats] = BlandAltman(T2.RGC_OCT,T2.RGC_HFA_adj,label)



%% lowess X= MD
figure; hold on;
span = 0.5;
[xx, inds] = sort(T2.MD10_2);
yy1 = smooth(T2.MD10_2, T2.RGC_HFA_adj, span,'rloess');
plot(xx,yy1(inds),'r.');
% clear xx inds

% [xx, inds] = sort(T2.RGC_OCT);
yy2 = smooth(T2.MD10_2,T2.RGC_OCT,span,'rloess');
plot(xx,yy2(inds),'b.')
% clear xx inds

% [xx, inds] = sort(T2.wRGC_adjusted);
yy3 = smooth(T2.MD10_2,T2.wRGC_adj,span,'rloess');
plot(xx,yy3(inds),'g.')
clear xx inds

xlabel 'RGC count'
ylabel MD
legend({'RGC HFA','RGC OCT','wRGC'})

