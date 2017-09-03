function PlotRGC_20170901

%% load data

pt = readtable('df_20170901.xlsx');
norm = readtable('norm_20170901.xlsx');

%% conventional
figure; hold on;
plot(pt.RGC_HFA9, pt.RGC_OCT,'ob','MarkerFaceColor','b')
plot(pt.RGC_HFA9, pt.RGC_OCT2,'or','MarkerFaceColor','r')

plot(norm.RGC_HFA9, norm.RGC_OCT,'ob','MarkerFaceColor','b')
plot(norm.RGC_HFA9, norm.RGC_OCT2,'or','MarkerFaceColor','r')

title 'RGC HFA vs RGC OCT'
xlabel 'RGC HFA10-2'
ylabel 'RGC OCT'
set(gca, 'FontSize',18)
axis equal
xlim = get(gca,'yLim');
ytick = get(gca,'YTick');
set(gca,'XLim',[0,xlim(2)],'XTick',ytick)
set(gca,'YLim',[0,xlim(2)],'XTick',ytick)
l = legend({'360','180'},'Location','northwest');

%% save  the fig
saveas(gca, 'RGC_HFA9vsOCT1.png')

%% Displaced
figure; hold on;
plot(pt.RGC_disp, pt.RGC_OCT,'ob','MarkerFaceColor','b')
plot(pt.RGC_disp, pt.RGC_OCT2,'or','MarkerFaceColor','r')

plot(norm.RGC_disp, norm.RGC_OCT,'ob','MarkerFaceColor','b')
plot(norm.RGC_disp, norm.RGC_OCT2,'or','MarkerFaceColor','r')

title 'RGC HFA vs RGC OCT'
xlabel 'RGC HFA10-2'
ylabel 'RGC OCT'
set(gca, 'FontSize',18)
axis equal
xlim = get(gca,'yLim');
ytick = get(gca,'YTick');
set(gca,'XLim',[0,xlim(2)],'XTick',ytick)
set(gca,'YLim',[0,xlim(2)],'XTick',ytick)
l = legend({'360','180'},'Location','northwest');

%% save as figure.png
saveas(gca, 'RGC_dispvsOCT2.png')

%% degree of cpRNFL
% conventional tesdt point plots
figure; hold on;
for ii = 1: 360
    [p{ii}, S{ii}] = polyfit(pt.RGC_HFA9, pt.RGC_OCT*ii/360, 1);
    plot(ii,p{ii}(1),'ob')
end
set(gca,'XLim',[0,360],'XTick',[0,360],'FontSize',18)
set(gca,'YLim',[0,1],'YTick',[0,1],'FontSize',18)

xlabel('degree of cpRNFL')
ylabel('slope')
legend('conventional')

%%
saveas(gca, 'RGC_HFA9_cpRNFLT_slope.png')

%%
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
set(gca,'XLim',[0,xlim(2)])
legend({'90','180','270', '360'},'Location','northwest')
title('Conventional test point')

saveas(gcf, 'Conventional_test_point.png')

%% Displaced
% plots
figure; hold on;
for ii = 1: 360
    [p{ii}, S{ii}] = polyfit(pt.RGC_disp, pt.RGC_OCT*ii/360, 1);
    plot(ii,p{ii}(1),'ob')
end
set(gca,'XLim',[0,360],'XTick',[0,360],'FontSize',18)
% set(gca,'YLim',[0,1],'YTick',[0,1],'FontSize',18)

xlabel('degree of cpRNFL')
ylabel('slope')
legend('Displaced','Location','northwest')
plot([0,360],[1,1],'-r')
plot([213,213],[0,2],'-r')
set(gca,'FontSize', 18, 'XTick',[0, 213, 360])

%%
saveas(gca, 'Disp_cpRNFLT_slope.png')

%% Displaced
c = jet(360);

figure; hold on;
for ii = [90, 180 , 213, 270 , 360]
    plot(pt.RGC_disp, pt.RGC_OCT*ii/360,'o','MarkerEdgeColor',c(ii,:),'MarkerFaceColor',c(ii,:))
    %     lsline
end
xlabel('RGC from HFA')
ylabel('RGC from OCT')
set(gca, 'FontSize',18)
xlim = get(gca,'XLim');
ylim = get(gca,'YLim');

legend({'90','180','213','270', '360'},'Location','northeast')
title('Displaced test point')
axis equal
set(gca,'XLim',[0,ylim(2)])
set(gca,'YLim',[0,ylim(2)])

plot([0, ylim(2)], [0, ylim(2)],'-')

%%
saveas(gcf, 'Disp_test_point.png')


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
saveas(gca, 'Disp_test_point&angle.png')

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
Y = [p{1}(1),p{2}(1),p{3}(1),p{4}(1)];


%%
figure; hold on ;
for i = 1: 4

    plot(i,p{i}(1),'ob','MarkerFaceColor','b')
end
plot([0,5.5],[1,1],'--r')
plot([4,4],[.4,1.1],'--r')

set(gca,'XTick', 1:5,'XLim',[0.5, 5.5])
set(gca, 'XTickLabel',{'150','180','210','240'})
xlabel('degree of cpRNFL')
ylabel('slope')
set(gca, 'FontSize',18)
% plot([213,213],[0,2],'-r')
%%
saveas(gca, 'Disp_test_point&CH.png')

%%%%%%%%%%%%%%% 
%% norm
%%%%%%%%%%%%%%%
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
l = legend({'360','180'},'Location','northwest');

plot([0,1400000],[0,1400000],'--')

xlim = get(gca,'yLim');
ytick = get(gca,'YTick');
set(gca,'XLim',[0,xlim(2)],'XTick',ytick)
set(gca,'YLim',[0,xlim(2)],'XTick',ytick)

%% save  the fig
saveas(gca, 'NORM_RGC_HFA9vsOCT1.png')

%% conventional tesdt point plots
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
l = legend({'360','180'},'Location','northeast');
axis equal

%%
saveas(gca, 'NORM_Disp_RGC_HFA9vsOCT1.png')
