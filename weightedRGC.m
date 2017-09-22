function weightedRGC
%% load data

pt = readtable('df_20170918_Turpin.xlsx');

% pt = readtable('df_20170901.xlsx');

% remove OHT
pt(357:358,:) = [];
% writetable(pt, 'df_20170908.csv');

norm = readtable('norm_20170918_Turpin.xlsx');

%% add wrgc 360
MD = pt.MD10_2;
OCTrgc = pt.RGC_OCT;
SAPrgc = pt.RGC_HFA9;

wrgc = (1 + MD/30) .*OCTrgc + (-MD/30).*SAPrgc;
pt.wrgc360 = wrgc;

% 
figure; hold on;

plot(pt.MD10_2, pt.wrgc360,'o')
xlabel 'MD10-2'
ylabel 'wrgc 360 degree'

set(gca , 'FontSize', 18)
%% save figure
saveas(gca, fullfile(pwd,'Figure/wrgc360VSmd10_2.png'))

%% add wrgc 180
MD = pt.MD10_2;
OCTrgc = pt.RGC_OCT2;
SAPrgc = pt.RGC_HFA9;

wrgc = (1 + MD/30) .*OCTrgc + (-MD/30).*SAPrgc;
pt.wrgc180 = wrgc;

%% 
figure; hold on;

plot(pt.MD10_2, pt.wrgc180,'o')
xlabel 'MD10-2'
ylabel 'wrgc 180 degree'

set(gca , 'FontSize', 18)
%% save figure
saveas(gca, fullfile(pwd,'Figure/wrgc180VSmd10_2.png'))

%% both 360 & 180
figure; hold on;

plot(pt.MD10_2, pt.wrgc360,'ob')
plot(pt.MD10_2, pt.wrgc180,'or')

xlabel 'MD10-2'
ylabel 'wrgc'

legend({'360','180'},'Location','northwest')

%% save figure
saveas(gca, fullfile(pwd,'Figure/wrgc180VSboth.png'))

%%
