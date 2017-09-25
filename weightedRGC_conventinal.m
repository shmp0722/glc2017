function weightedRGC_conventinal
%% load data

pt = readtable('df_20170910.xlsx');

% pt = readtable('df_20170901.xlsx');

% remove OHT
pt(357:358,:) = [];
% writetable(pt, 'df_20170908.csv');

norm = readtable('norm_20170910.xlsx');

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
set(gca , 'FontSize', 18)

%% save figure
saveas(gca, fullfile(pwd,'Figure/wrgc180VSboth.png'))

%% 
[R, p ] = corrcoef(pt.MD10_2, pt.wrgc360)

[R, p ] = corrcoef(pt.MD10_2, pt.wrgc180)

%% Displaced
%% add wrgc disp 360
% MD = pt.MD10_2;
% OCTrgc = pt.RGC_OCT;
% SAPrgc = pt.RGC_disp;
% 
% wrgc = (1 + MD/30) .*OCTrgc + (-MD/30).*SAPrgc;
% pt.wrgc_disp_360 = wrgc;

%
figure; hold on;

plot(pt.MD10_2, pt.wrgc_disp_360,'o')
xlabel 'MD10-2'
ylabel 'wrgc 360 degree'

set(gca , 'FontSize', 18)

%% add disp 180
% MD = pt.MD10_2;
% OCTrgc = pt.RGC_OCT2;
% SAPrgc = pt.RGC_disp;
% 
% wrgc = (1 + MD/30) .*OCTrgc + (-MD/30).*SAPrgc;
% pt.wrgc_disp_180 = wrgc;

%
figure; hold on;

plot(pt.MD10_2, pt.wrgc_disp_180,'or')
xlabel 'MD10-2'
ylabel 'wrgc 180 degree'

set(gca , 'FontSize', 18)
%% both 360 & 180
figure; hold on;

plot(pt.MD10_2, pt.wrgc_disp_360,'ob')
plot(pt.MD10_2, pt.wrgc_disp_180,'or')

xlabel 'MD10-2'
ylabel 'wrgc'

legend({'360','180'},'Location','northwest')
set(gca , 'FontSize', 18)

%% save figure

saveas(gca, fullfile(pwd,'Figure/wrgcDispVSboth.png'))

%% both 360 & 180
figure; hold on;

plot(pt.MD10_2, pt.wrgc_disp_360,'ob')
plot(pt.MD10_2, pt.wrgc_disp_180,'or')

xlabel 'MD10-2'
ylabel 'wrgc'

legend({'360','180'},'Location','northwest')
set(gca , 'FontSize', 18)

%% vs MD10-2
figure; hold on;
plot(pt.MD10_2, pt.RGC_OCT,'ob')
plot(pt.MD10_2, pt.RGC_OCT2,'or')

plot(pt.MD10_2, pt.wrgc_360,'og')
plot(pt.MD10_2, pt.wrgc_disp_180,'os')