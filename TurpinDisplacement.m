function TurpinDisplacement
%% load data

pt = readtable('df_20170918_Turpin.xlsx');

% pt = readtable('df_20170901.xlsx');

% remove OHT
pt(357:358,:) = [];
% writetable(pt, 'df_20170908.csv');

norm = readtable('norm_20170918_Turpin.xlsx');

%% conventional
figure; hold on;
plot(pt.RGC_HFA9, pt.RGC_OCT,'ob','MarkerFaceColor','b')
plot(pt.RGC_HFA9, pt.RGC_OCT2,'or','MarkerFaceColor','r')

% plot(norm.RGC_HFA9, norm.RGC_OCT,'og','MarkerFaceColor','b')
% plot(norm.RGC_HFA9, norm.RGC_OCT2,'og','MarkerFaceColor','r')

title 'RGC HFA vs RGC OCT'
xlabel 'RGC HFA10-2'
ylabel 'RGC OCT'
set(gca, 'FontSize',18)
axis equal
xlim = get(gca,'yLim');
ytick = get(gca,'YTick');
set(gca,'XLim',[0,xlim(2)],'XTick',ytick)
set(gca,'YLim',[0,xlim(2)],'XTick',ytick)
n = legend({'360','180'},'Location','northwest');
plot([0:1280000], [0:1280000],'--k' )

%% save  the fig
saveas(gca, fullfile(pwd,'/Figure/RGC_HFA9vsOCT1.png'))
% saveas(gca, fullfile(pwd,'/Figure/RGC_HFA9vsOCT1_withNorm.png'))

%% Displaced
figure; hold on;
plot(pt.RGC_disp, pt.RGC_OCT,'ob','MarkerFaceColor','b')
plot(pt.RGC_disp, pt.RGC_OCT2,'or','MarkerFaceColor','r')

% plot(norm.RGC_disp, norm.RGC_OCT,'og','MarkerFaceColor','b')
% plot(norm.RGC_disp, norm.RGC_OCT2,'og','MarkerFaceColor','r')

title 'RGC HFA vs RGC OCT'
xlabel 'RGC HFA10-2'
ylabel 'RGC OCT'
set(gca, 'FontSize',18)
axis equal
xlim = get(gca,'yLim');
ytick = get(gca,'YTick');
set(gca,'XLim',[0,xlim(2)],'XTick',ytick)
set(gca,'YLim',[0,xlim(2)],'XTick',ytick)
n = legend({'360','180'},'Location','northwest');
plot([0:1280000], [0:1280000],'--k' )


%% save as figure.png
% saveas(gca, fullfile(pwd,'/Figure','RGC_dispvsOCT2_wNorm.png'))
saveas(gca, fullfile(pwd,'/Figure','RGC_dispvsOCT2_Turpin.png'))

%% boxplot
% patients
figure; hold on;
boxplot([pt.RGC_HFA9,pt.RGC_disp],'notch','on','labels',{'Conventional','Displaced'})
title('Conventional vs Displaced test point')
ylabel('RGC count')
xlabel('Test point')
set(gca, 'FontSize',18)
% 
[h, p] = ttest2(pt.RGC_HFA9,pt.RGC_disp)
%% save plot
saveas(gca, fullfile(pwd,'/Figure','Boxplot_convVsdisp_Turpin.png'))

%% Norms
figure; hold on;
boxplot([norm.RGC_OCT,norm.RGC_OCT2],'notch','on','labels',{'Conventional','Displaced'})
title('Conventional vs Displaced test point')
ylabel('RGC count')
xlabel('Normal subjects')


%% paired t test
[h,p,ci,stats] = ttest(pt.RGC_OCT,pt.RGC_OCT2);

%% degree of cpRNFL
% conventional tesdt point plots
clear p 

figure; hold on;
for ii = 1: 360
    [p{ii}, S{ii}] = polyfit(pt.RGC_HFA9, pt.RGC_OCT*ii/360, 1);
    plot(ii,p{ii}(1),'ob')
end
set(gca,'XLim',[0,360],'XTick',[0,360],'FontSize',18)
set(gca,'YLim',[0,1],'YTick',[0,1],'FontSize',18)

title 'Slope of regression line '
xlabel('degree of cpRNFL')
ylabel('slope r')
legend('conventional')

%%
saveas(gca, fullfile(pwd,'/Figure', 'RGC_HFA9_cpRNFLT_slope.png'))

%% conventinal
c = jet(360);

figure; hold on;
for ii = 90:90:360
    plot(pt.RGC_HFA9, pt.RGC_OCT*ii/360,'o','MarkerEdgeColor',c(ii,:),'MarkerFaceColor',c(ii,:))
    %     lsline
end
xlabel('RGC from HFA')
ylabel('RGC from OCT')
set(gca, 'FontSize',18)
axis equal
xlim = get(gca,'XLim');
ylim = get(gca,'YLim');

set(gca,'XLim',[0,xlim(2)])
legend({'90','180','270', '360'},'Location','northwest')
title('Conventional test point')

%%
saveas(gcf, 'Conventional_test_point.png')

%% Displaced
% plots
figure; hold on;
slope =zeros(360,1);
for ii = 1: 360
    [p{ii}, S{ii}] = polyfit(pt.RGC_disp, pt.RGC_OCT*ii/360, 1);
    plot(ii,p{ii}(1),'ob')
    slope(ii) = p{ii}(1);
end
set(gca,'XLim',[0,360],'XTick',[0,360],'FontSize',18)
% set(gca,'YLim',[0,1],'YTick',[0,1],'FontSize',18)

xlabel('degree of cpRNFL')
ylabel('slope')
legend('Displaced','Location','northwest')

% find a point slope = 1.0
X = max(slope(slope<=1)) ;
X2 = min(slope(slope<=1)) ;
if 1-X <= X2
    sl = X;
else
    sl = X2;
end

find(slope==sl)

plot([0,find(slope==sl)],[1,1],'-r')
plot([find(slope==sl),find(slope==sl)],[0,1],'-r')
set(gca,'FontSize', 18, 'XTick',[0, find(slope==sl), 360])

%%
saveas(gca, fullfile(pwd,'/Figure','Disp_cpRNFLT_slope.png'))

%% displaced boxplot
% patients
figure; hold on;
boxplot([pt.RGC_disp, pt.RGC_HFA9],'notch','on','labels',{'Conventional','Displaced'})
title('Conventional vs Displaced test point')
ylabel('RGC HFA')
xlabel('Test point')
set(gca, 'FontSize',18)
% 
mean(pt.RGC_OCT)
std(pt.RGC_OCT)


%% save plot
saveas(gca, fullfile(pwd,'/Figure','Boxplot_convVsdisp.png'))

%% Displaced
c = jet(360);

figure; hold on;
for ii = [90, 180, 270 , 360] %[90, 180 , find(slope==sl), 270 , 360]
    plot(pt.RGC_disp, pt.RGC_OCT*ii/360,'o','MarkerEdgeColor',c(ii,:),'MarkerFaceColor',c(ii,:))
    %     lsline
end
xlabel('RGC from HFA')
ylabel('RGC from OCT')
set(gca, 'FontSize',18)
xlim = get(gca,'XLim');
ylim = get(gca,'YLim');

% legend({'90','180','270',num2str(find(slope==sl)), '360'},'Location','northeast')
legend({'90','180','270', '360'},'Location','northeast')

title('Displaced test point')
axis equal
set(gca,'XLim',[0,ylim(2)])
set(gca,'YLim',[0,ylim(2)])

plot([0, ylim(2)], [0, ylim(2)],'-')

%%
saveas(gca, fullfile(pwd,'/Figure', 'Disp_test_point.png'))


%% Displaced and clock hour
figure; hold on;
c = jet(4);

% plot(pt.RGC_disp, pt.RGC_CH1 + pt.RGC_CH2 + pt.RGC_CH12,...
%     'o', 'MarkerFaceColor',c(90,:),'MarkerEdgeColor',c(90,:)) % 90 degree

% plot(pt.RGC_disp, pt.RGC_CH1+pt.RGC_CH2+pt.RGC_CH12, 'o', ...
%     'MarkerFaceColor', c(180,:))
plot(pt.RGC_disp, pt.RGC_CH7 + pt.RGC_CH8 + pt.RGC_CH9...
    + pt.RGC_CH10 + pt.RGC_CH11, 'o',...
    'MarkerFaceColor',c(1,:),'MarkerEdgeColor',c(1,:)) % 150 degree


plot(pt.RGC_disp, pt.RGC_CH7 + pt.RGC_CH8 + pt.RGC_CH9...
    + pt.RGC_CH10 + pt.RGC_CH11...
    + pt.RGC_CH6 ,'o',...
    'MarkerFaceColor',c(2,:),'MarkerEdgeColor',c(2,:)) % 180 degree

plot(pt.RGC_disp, pt.RGC_CH7 + pt.RGC_CH8 + pt.RGC_CH9...
    + pt.RGC_CH10 + pt.RGC_CH11...
    + pt.RGC_CH6 + pt.RGC_CH12, 'o',...
    'MarkerFaceColor',c(3,:),'MarkerEdgeColor',c(3,:)) % 210 degree

plot(pt.RGC_disp, pt.RGC_CH7 + pt.RGC_CH8 + pt.RGC_CH9...
    + pt.RGC_CH10 + pt.RGC_CH11...
    + pt.RGC_CH6 + pt.RGC_CH12 + pt.RGC_CH5, 'o',...
    'MarkerFaceColor',c(4,:),'MarkerEdgeColor',c(4,:)) % 240 degree

xlabel('RGC from HFA')
ylabel('RGC from OCT')
set(gca, 'FontSize',18)
xlim = get(gca,'XLim');
ylim = get(gca,'YLim');

axis equal

legend({'150','180','210','240'},'Location','northwest')
title('Displaced test point')
axis equal
set(gca,'XLim',[0,ylim(2)])
set(gca,'YLim',[0,ylim(2)])

% plot([0, ylim(2)], [0, ylim(2)],'-')
%%
saveas(gca, fullfile(pwd, 'Figure/Disp_test_point&angle.png'))

%%

[p{1}, S{1}] = polyfit(pt.RGC_disp, pt.RGC_CH7 + pt.RGC_CH8 + pt.RGC_CH9...
    + pt.RGC_CH10 + pt.RGC_CH11, 1);%150

[p{2}, S{2}] = polyfit(pt.RGC_disp, pt.RGC_CH7 + pt.RGC_CH8 + pt.RGC_CH9...
    + pt.RGC_CH10 + pt.RGC_CH11...
    + pt.RGC_CH6 , 1); % 180degree

[p{3}, S{3}] = polyfit(pt.RGC_disp, pt.RGC_CH7 + pt.RGC_CH8 + pt.RGC_CH9...
    + pt.RGC_CH10 + pt.RGC_CH11...
    + pt.RGC_CH6 + pt.RGC_CH12, 1); % 210degree

[p{4}, S{4}] = polyfit(pt.RGC_disp, pt.RGC_CH7 + pt.RGC_CH8 + pt.RGC_CH9...
    + pt.RGC_CH10 + pt.RGC_CH11...
    + pt.RGC_CH6 + pt.RGC_CH12 + pt.RGC_CH5, 1); % 240degree
%%
x = [150:30:240];
y = [p{1}(1),p{2}(1),p{3}(1),p{4}(1)];

[slope, st] = polyfit(x,y, 1);

% Y = slope(1)*X + slope(2);
X = (1-slope(2))/slope(1);
%%
figure; hold on ;
for i = 1: 4
    plot(i,p{i}(1),'ob','MarkerFaceColor','b')
end
plot([0,6],[1,1],'--r')
plot([2.66,2.66],[.4,1.4],'--r')

set(gca,'XTick', [1,2,2.66,3:4],'XLim',[0.5, 4.5])
set(gca, 'XTickLabel',{'150','180','199','210','240'})
xlabel('degree of cpRNFL')
ylabel('slope')
set(gca, 'FontSize',18)
% plot([213,213],[0,2],'-r')
%%
saveas(gca, 'Disp_test_point&CH.png')

%%%%%%%%%%%%%%% 
%% norm
%%%%%%%%%%%%%%%
% Conventional test point
figure; hold on;
% plot(pt.RGC_HFA9, pt.RGC_OCT,'ob','MarkerFaceColor','b')
% plot(pt.RGC_HFA9, pt.RGC_OCT2,'or','MarkerFaceColor','r')

plot(norm.RGC_HFA9, norm.RGC_OCT,'ob','MarkerFaceColor','b')
plot(norm.RGC_HFA9, norm.RGC_OCT2,'or','MarkerFaceColor','r')

title 'RGC HFA vs RGC OCT'
xlabel 'RGC HFA10-2'
ylabel 'RGC OCT'
set(gca, 'FontSize',18)
axis equal
n = legend({'360','180'},'Location','northwest');

plot([0,1400000],[0,1400000],'--')

xlim = get(gca,'yLim');
ytick = get(gca,'YTick');
set(gca,'XLim',[0,xlim(2)],'XTick',ytick)
set(gca,'YLim',[0,xlim(2)],'XTick',ytick)

%% save  the fig
saveas(gca, fullfile(pwd,'Figure/NORM_RGC_HFA9vsOCT1.png'))

%% conventional test point plots
figure; hold on;
for ii = 1: 360
    [p{ii}, S{ii}] = polyfit(norm.RGC_HFA9, norm.RGC_OCT*ii/360, 1);
    plot(ii,p{ii}(1),'ob')
end
set(gca,'XLim',[0,360],'XTick',[0,360],'FontSize',18)
set(gca,'YLim',[0,1],'YTick',[0,1],'FontSize',18)

xlabel('degree of cpRNFL')
ylabel('slope')
legend('conventional')

%%
saveas(gca, 'Norm_RGC_HFA9_cpRNFLT_slope.png')

%% Displaced
figure; hold on;
plot(norm.RGC_disp, norm.RGC_OCT,'ob','MarkerFaceColor','b')
plot(norm.RGC_disp, norm.RGC_OCT2,'or','MarkerFaceColor','r')

title 'RGC HFA vs RGC OCT'
xlabel 'RGC HFA10-2'
ylabel 'RGC OCT'
set(gca, 'FontSize',18)
xlim = get(gca,'yLim');
ytick = get(gca,'YTick');
% set(gca,'XLim',[0,xlim(2)],'XTick',ytick)
plot([0,1400000],[0,1400000],'--')

% set(gca,'XLim',[0,xlim(2)])
% set(gca,'YLim',[0,ylim(2)])


% set(gca,'YLim',[0,xlim(2)],'XTick',ytick)
n = legend({'360','180'},'Location','northeast');
axis equal

%%
saveas(gca, 'NORM_Disp_RGC_HFA9vsOCT1.png')

%%
[R,P,RL,RU] = corrcoef(pt.RGC_disp, pt.AVERAGETHICKNESS);

%%
% Pick up POAG
for n = 1: length(pt.disease);
 rows(n) = strcmp(pt.disease(n),'POAG');
 rows    = logical(rows);
end

POAG = pt(rows, :);

% NTG
for n = 1: length(pt.disease);
 rows(n) = strcmp(pt.disease(n),'NTG');
 rows    = logical(rows);
end

NTG = pt(rows, :);

% PPG
for n = 1: length(pt.disease);
 rows(n) = strcmp(pt.disease(n),'PPG');
 rows    = logical(rows);
end
PPG = pt(rows, :);

[a,b] = size(NTG);

%% box plot across diseases
figure; hold on;
boxplot(pt.RGC_OCT,pt.disease, 'notch','on' )
xlabel 'disease'
ylabel 'RGC OCT'
title 'RGC OCT'

figure; hold on;
boxplot(pt.RGC_disp, pt.disease, 'notch','on' )
xlabel 'disease'
ylabel 'RGC HFA displaced'
title 'RGC OCT'

%% disease stage
early =   pt.MD10_2 > -6; 
middle =  pt.MD10_2 < -6 & pt.MD10_2 >= -12; 
advanced = pt.MD10_2 < -12;

figure; hold on;
A =  max([sum(early), sum(middle), sum(advanced)]) ;
B = nan(A, 1);
E = B;
M = B;
A = B;

for i = length(early)
    E(i) = pt.RGC_disp(early);
end

% boxplot([pt.RGC_disp(early), pt.RGC_disp(middle),...
%     pt.RGC_disp(advanced)],'notch','on')
%%
figure; hold on; 
x = 1:4;

% RGC HFA conventional
w(1) = mean(pt.RGC_HFA9(early));
w(2) = mean(pt.RGC_HFA9(middle));
w(3) = mean(pt.RGC_HFA9(advanced));
w(4) = mean(norm.RGC_HFA9);

% RGC HFA displaced
y(1) = mean(pt.RGC_disp(early));
y(2) = mean(pt.RGC_disp(middle));
y(3) = mean(pt.RGC_disp(advanced));
y(4) = mean(norm.RGC_disp);

% RGC OCT
z(1) = mean(pt.RGC_OCT(early));
z(2) = mean(pt.RGC_OCT(middle));
z(3) = mean(pt.RGC_OCT(advanced));
z(4) = mean(norm.RGC_OCT);

% RGC OCT/2
n(1) = mean(pt.RGC_OCT2(early));
n(2) = mean(pt.RGC_OCT2(middle));
n(3) = mean(pt.RGC_OCT2(advanced));
n(4) = mean(norm.RGC_OCT2);

% drow
bar(x - 0.3, w, 0.1)
bar(x-.1, y, 0.1,'r')
bar(x + .1, z, 0.1,'g')
bar(x + 0.3, n, 0.1,'y')


legend({'conv','displ','OCT360','OCT180'},'Location' ,'northwest')
set(gca, 'XTick', x, 'XTickLabel',{'Early','Middle','Advanced','Healthy'}...
    ,'Fontsize',18)
% bar(x+0.4, w, 0.3,'b')
xlabel 'stage'
ylabel 'RGC count'

%% 
saveas(gca, fullfile(pwd,'Figure/bar.png'))




