function RGCfrom10_2
%% read data
% to working directory
cd '/Users/shumpei/Google Drive/CSFI/glc2017';

% checking the excel file
[status,sheets] = xlsfinfo('10-2-8.xlsx');

% read raw data
T= readtable('10-2-8.xlsx');

% %%
% cd /Users/shumpei/Google Drive/CSFI
% 
% [status,sheets] = xlsfinfo('CSFI 10-2.xlsx');
% 
% T= readtable('CSFI 10-2.xlsx','Sheet',2);
%%
figure; hold on;
plot(T.age,T.RGC_HFA./9,'o')
xlabel age
ylabel RGC_HFA
mdl = fitlm(T.age,T.RGC_HFA./9)
lsline
%% remove subjects HFA reliability is not enough
% remove low fixation HFA
rows =  T.FP< .15 & T.FN<.33 & T.FixLoss_pcnt<.2;
T2 = T(rows,:);
clear T rows

%% gender
% whole
mean(T2.age)

% find group by disease 
[G, disease] = findgroups(T2.Disease_type);

sum(G==1)
sum(G==2)
sum(G==3)

% age 
splitapply(@mean,T2.age,G)
splitapply(@std,T2.age,G)

% MD 
splitapply(@mean,T2.MD10_2,G)
splitapply(@std,T2.MD10_2,G)


% gender
[G2, sex] = findgroups(T2.Gender);


p = anova1(T2.Gender,G)
p = anova1(T2.MD10_2,G)
p = anova1(T2.age,G)

[g, ID] = findgroups(T2.ID);


%% adjust 
T2.RGC_HFA_adj = T2.RGC_HFA./9;
T2.RGC_HFA_adj2 = T2.RGC_HFA./64.*12;

T2.wRGC_adj = (1+T2.MD10_2/30).*T2.RGC_OCT+(-T2.MD10_2/30).*T2.RGC_HFA_adj;
T2.wRGC_adj2 = (1+T2.MD10_2/30).*T2.RGC_OCT+(-T2.MD10_2/30).*T2.RGC_HFA_adj2;

% %% BlandAltman between RGC_HFA_adj,T2.RGC_HFA_adj2  
% figure;hold on;
% plot(T2.RGC_HFA_adj,T2.RGC_HFA_adj2,'o')
% 
% addpath(genpath('BlandAltman'))
% label ={'RGC_HFA','HFA2'};
% [rpc, fig, stats] = BlandAltman(T2.RGC_HFA_adj,T2.RGC_HFA_adj2,label)
%% plot 1
figure; hold on;
plot(T2.MD10_2,T2.RGC_OCT,'ob')
plot(T2.MD10_2,T2.RGC_HFA_adj,'or')
% plot(T2.MD10_2,T2.RGC_HFA_adj2,'o')

plot(T2.MD10_2,T2.wRGC_adj,'og')
xlabel('MD value','fontsize',14)
ylabel('estimated num of RGC','fontsize',14)
legend({'OCT','HFA','weighted'},'fontsize',14)

% lowess X= MD
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

xlabel('MD value','fontsize',14)
ylabel('estimated num of RGC','fontsize',14)
legend({'RGC HFA','RGC OCT','wRGC'},'fontsize',14)


%% Bland Altman

addpath(genpath('BlandAltman'))
label ={'RGC HFA','RGC OCT'};
[rpc, fig, stats] = BlandAltman(T2.RGC_OCT,T2.RGC_HFA_adj,label)

corr(T2.RGC_OCT,T2.RGC_HFA_adj)

%% plot 2
figure; hold on;

plot(T2.MD10_2,T2.RGC_OCT,'ob')
plot(T2.MD10_2,T2.RGC_HFA_adj2,'or')
% plot(T2.MD10_2,T2.RGC_HFA_adj2,'o')

plot(T2.MD10_2,T2.wRGC_adj2,'og')
xlabel('MD value')
ylabel('estimated num of RGC')
legend({'OCT','HFA','weighted'})

% lowess X= MD
figure;hold on;
span = 0.5;
[xx, inds] = sort(T2.MD10_2);
yy1 = smooth(T2.MD10_2, T2.RGC_HFA_adj2, span,'rloess');
plot(xx,yy1(inds),'r.');
% clear xx inds

% [xx, inds] = sort(T2.RGC_OCT);
yy2 = smooth(T2.MD10_2,T2.RGC_OCT,span,'rloess');
plot(xx,yy2(inds),'b.')
% clear xx inds

% [xx, inds] = sort(T2.wRGC_adjusted);
yy3 = smooth(T2.MD10_2,T2.wRGC_adj2,span,'rloess');
plot(xx,yy3(inds),'g.')
clear xx inds

xlabel 'MD value'
ylabel 'RGC count'
legend({'RGC HFA','RGC OCT','wRGC'})


%%
S = readtable('30-2,10-2-6.xlsx','Sheet',2);

%% remove low HFA fixation
rows =  S.FP_30< .15 & S.FN_30<.33 & S.FixLoss_pcnt_30<.2;
S2 = S(rows,:);

rows =  S2.FP_10< .15 & S2.FN_10<.33 & S2.FixLoss_pcnt_10<.2;
S2 = S2(rows,:);
% clear T rows

%% wrgc
S2.RGC_HFA_10_adj = S2.RGC_HFA_10./9;
S2.wRGC_adj = (1+S2.MD10_2/30).*S2.RGC_OCT_10+(-S2.MD10_2/30).*S2.RGC_HFA_10_adj;

%% plot 1
figure; hold on;
plot(S2.MD10_2,S2.RGC_HFA_10_adj,'ob')
plot(S2.MD10_2,S2.RGC_OCT_10,'or')
% plot(T2.MD10_2,T2.RGC_HFA_adj2,'o')

plot(S2.MD10_2,S2.wRGC_adj,'og')
xlabel('MD value','fontsize',14)
ylabel('estimated num of RGC','fontsize',14)
legend({'OCT','HFA','weighted'},'fontsize',14)
title('estimated RGC from HFA10-2','fontsize',14)

[r,p] = corr(S2.RGC_HFA_10_adj,S2.RGC_OCT_10)

% lowess X= MD
figure; hold on;
span = 0.5;
[xx, inds] = sort(S2.MD10_2);
yy1 = smooth(S2.MD10_2, S2.RGC_HFA_10_adj, span,'rloess');
plot(xx,yy1(inds),'r.');
% clear xx inds

% [xx, inds] = sort(T2.RGC_OCT);
yy2 = smooth(S2.MD10_2,S2.RGC_OCT_10,span,'rloess');
plot(xx,yy2(inds),'b.')
% clear xx inds

% [xx, inds] = sort(T2.wRGC_adjusted);
yy3 = smooth(S2.MD10_2,S2.wRGC_adj,span,'rloess');
plot(xx,yy3(inds),'g.')
clear xx inds

xlabel('MD','fontsize',14) 
ylabel('RGC count','fontsize',14)
legend({'RGC HFA','RGC OCT','wRGC'},'fontsize',14)
title('estimated RGC from HFA10-2','fontsize',14)


%% RGC HFA30-2 and HFA10-2 adj
figure; hold on;
plot(S2.MD30_2,S2.RGC_HFA_10_adj,'ob')
plot(S2.MD30_2,S2.RGC_OCT_10,'or')
% plot(T2.MD10_2,T2.RGC_HFA_adj2,'o')
plot(S2.MD30_2,S2.wRGC_adj,'og')
xlabel('MD30-2 value','fontsize',14)
ylabel('estimated num of RGC from HFA10-2','fontsize',14)
legend({'OCT','HFA','weighted'},'fontsize',14)
title('MD from HFA30-2, RGC from 10-2','fontsize',14)


[r,p]=corr(S2.MD30_2,S2.RGC_HFA_10_adj)
[r,p]=corr(S2.MD10_2,S2.RGC_HFA_10_adj)

%%

figure; hold on;
plot(S2.RGC_HFA_30,S2.RGC_HFA_10_adj,'ob')
xlabel('RGC HFA30-2','fontsize',14)
ylabel('RGC HFA10-2','fontsize',14)
% legend({'OCT','HFA','weighted'},'fontsize',14)
title('estimated RGC from HFA30-2,10-2','fontsize',14)
axis equal

[r,p]=corr(S2.RGC_HFA_30,S2.RGC_HFA_10_adj)

label ={'RGC HFA30-2','RGC HFA10-2'};
[rpc, fig, stats] = BlandAltman(S2.RGC_HFA_30,S2.RGC_HFA_10_adj,label)

%% RGC HFA 30-2, MD from 30-2
figure; hold on;
plot(S2.MD30_2,S2.RGC_HFA_30,'ob')
plot(S2.MD30_2,S2.RGC_OCT_30,'or')
% plot(T2.MD10_2,T2.RGC_HFA_adj2,'o')

corr(S2.RGC_HFA_30,S2.RGC_OCT_30)

plot(S2.MD30_2,S2.wRGC_30,'og')
xlabel('MD value','fontsize',14)
ylabel('estimated num of RGC','fontsize',14)
legend({'OCT','HFA','weighted'},'fontsize',14)
title('RGC HFA 30-2, MD from 30-2','fontsize',14)

%% lowess X= MD
figure; hold on;
span = 0.5;
[xx, inds] = sort(S2.MD10_2);
yy1 = smooth(S2.MD10_2, S2.RGC_HFA_10_adj, span,'rloess');
plot(xx,yy1(inds),'r.');
% clear xx inds

% [xx, inds] = sort(T2.RGC_OCT);
yy2 = smooth(S2.MD10_2,S2.RGC_OCT_10,span,'rloess');
plot(xx,yy2(inds),'b.')
% clear xx inds

% [xx, inds] = sort(T2.wRGC_adjusted);
yy3 = smooth(S2.MD10_2,S2.wRGC_adj,span,'rloess');
plot(xx,yy3(inds),'g.')
clear xx inds

xlabel 'RGC count'
ylabel MD
legend({'RGC HFA','RGC OCT','wRGC'})

%%
[R, p] = corr(S2.GC_AVERAGE, S2.RGC_HFA_10_adj)
[R, p] = corr(S2.GC_AVERAGE, S2.RGC_HFA_30)
[R, p] = corr(S2.GC_AVERAGE, S2.cpRNFL)
[R, p] = corr(S2.GC_AVERAGE, S2.cpRNFL_10)
[R, p] = corr(S2.GC_AVERAGE, S2.wRGC_adj)

figure;hold on;
plot(S2.GC_AVERAGE, S2.RGC_HFA_10_adj,'o')
plot(S2.GC_AVERAGE, S2.wRGC_adj,'o')
%%
[R, p] = corr(S2.GC_MINIMUM, S2.RGC_HFA_10_adj)
[R, p] = corr(S2.GC_MINIMUM, S2.RGC_HFA_30)
[R, p] = corr(S2.GC_MINIMUM, S2.cpRNFL)
[R, p] = corr(S2.GC_MINIMUM, S2.cpRNFL_10)
[R, p] = corr(S2.GC_MINIMUM, S2.wRGC_adj)
[R, p] = corr(S2.GC_MINIMUM, S2.wRGC_30)

figure;hold on;
plot(S2.GC_MINIMUM, S2.RGC_HFA_10_adj,'o')
%%
[R, p] = corr(S2.GC_INF, S2.RGC_HFA_10_adj)
[R, p] = corr(S2.GC_INF, S2.RGC_HFA_30)
[R, p] = corr(S2.GC_INF, S2.cpRNFL)
[R, p] = corr(S2.GC_INF, S2.cpRNFL_10)
[R, p] = corr(S2.GC_INF, S2.wRGC_adj)
[R, p] = corr(S2.GC_INF, S2.wRGC_30)


[R, p] = corr(S2.GC_NASINF, S2.RGC_HFA_10_adj)
[R, p] = corr(S2.GC_NASINF, S2.RGC_HFA_30)
[R, p] = corr(S2.GC_NASINF, S2.cpRNFL)
[R, p] = corr(S2.GC_NASINF, S2.cpRNFL_10)
[R, p] = corr(S2.GC_NASINF, S2.wRGC_adj)
[R, p] = corr(S2.GC_NASINF, S2.wRGC_30)


[R, p] = corr(S2.GC_NASSUP, S2.RGC_HFA_10_adj)
[R, p] = corr(S2.GC_NASSUP, S2.RGC_HFA_30)
[R, p] = corr(S2.GC_NASSUP, S2.cpRNFL)
[R, p] = corr(S2.GC_NASSUP, S2.cpRNFL_10)
[R, p] = corr(S2.GC_NASSUP, S2.wRGC_adj)
[R, p] = corr(S2.GC_NASSUP, S2.wRGC_30)

[R, p] = corr(S2.GC_SUP, S2.RGC_HFA_10_adj)
[R, p] = corr(S2.GC_SUP, S2.RGC_HFA_30)
[R, p] = corr(S2.GC_SUP, S2.cpRNFL)
[R, p] = corr(S2.GC_SUP, S2.cpRNFL_10)
[R, p] = corr(S2.GC_SUP, S2.wRGC_adj)
[R, p] = corr(S2.GC_SUP, S2.wRGC_30)


[R, p] = corr(S2.GC_TEMPINF, S2.RGC_HFA_10_adj)
[R, p] = corr(S2.GC_TEMPINF, S2.RGC_HFA_30)
[R, p] = corr(S2.GC_TEMPINF, S2.cpRNFL)
[R, p] = corr(S2.GC_TEMPINF, S2.cpRNFL_10)
[R, p] = corr(S2.GC_TEMPINF, S2.wRGC_adj)

[R, p] = corr(S2.GC_TEMPSUP, S2.RGC_HFA_10_adj)
[R, p] = corr(S2.GC_TEMPSUP, S2.RGC_HFA_30)
[R, p] = corr(S2.GC_TEMPSUP, S2.cpRNFL)
[R, p] = corr(S2.GC_TEMPSUP, S2.cpRNFL_10)
[R, p] = corr(S2.GC_TEMPSUP, S2.wRGC_adj)

%%
[R, p] = corr(S2.RNFL_AVERAGE, S2.RGC_HFA_10_adj)
[R, p] = corr(S2.RNFL_AVERAGE, S2.RGC_HFA_30)
[R, p] = corr(S2.RNFL_AVERAGE, S2.cpRNFL)
[R, p] = corr(S2.RNFL_AVERAGE, S2.cpRNFL_10)
[R, p] = corr(S2.RNFL_AVERAGE, S2.wRGC_adj)

[R, p] = corr(S2.RNFL_MINIMUM, S2.RGC_HFA_10_adj)
[R, p] = corr(S2.RNFL_MINIMUM, S2.RGC_HFA_30)
[R, p] = corr(S2.RNFL_MINIMUM, S2.cpRNFL)
[R, p] = corr(S2.RNFL_MINIMUM, S2.cpRNFL_10)
[R, p] = corr(S2.RNFL_MINIMUM, S2.wRGC_adj)

[R, p] = corr(S2.PSD_10, S2.RGC_HFA_10_adj)
[R, p] = corr(S2.PSD_10, S2.RGC_HFA_30)
[R, p] = corr(S2.PSD_10, S2.cpRNFL)
[R, p] = corr(S2.PSD_10, S2.cpRNFL_10)
[R, p] = corr(S2.RNFL_MINIMUM, S2.wRGC_adj)


[R, p] = corr(S2.PSD_30, S2.RGC_HFA_10_adj)
[R, p] = corr(S2.PSD_30, S2.RGC_HFA_30)
[R, p] = corr(S2.PSD_30, S2.cpRNFL)
[R, p] = corr(S2.PSD_30, S2.cpRNFL_10)

