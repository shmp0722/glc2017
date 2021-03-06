function STEPWISE

% CH = readtable(fullfile(pwd,'df_20171002_Turpin.xls'),'Sheet','CH');
% HFA = readtable(fullfile(pwd,'df_20171002_Turpin.xls'),'Sheet','HFA');

%% load data
[theMessage, description, format] = xlsfinfo(fullfile(pwd,'df_20171002_Turpin.xlsx'));

CH = xlsread(fullfile(pwd,'df_20171002_Turpin.xlsx'),3);
HFA = xlsread(fullfile(pwd,'df_20171002_Turpin.xlsx'), 4);
m   = xlsread(fullfile(pwd,'df_20171002_Turpin.xlsx'), 2);
mlabel = readtable(fullfile(pwd,'df_20171002_Turpin.xlsx'),'Sheet',2);
% 
addpath(genpath(fullfile(pwd,'Stochastic_Bosque')));

%%  load 10-2 test point
% tp = xlsread(fullfile(pwd, '10-2testpoint.xlsx'));
tp = readtable(fullfile(pwd, '10-2testpoint.xlsx'));

%% Spearman

[R ,P] = corrcoef([HFA,CH]);

SF =  R(1:68,69:80);
sf = zeros(size(SF));
pp = zeros(size(SF));

p = P(1:68,69:80);

% for ii = 1:12
%     sf(:,ii)= SF(:,ii)==max(SF(:,ii));
% end

for ii = 1:68
    sf(ii,:)= SF(ii,:)==max(SF(ii,:));
    pp(ii,:)= p(ii,:)==min(p(ii,:));
end

%%
c= jet(12);
figure;
% subplot(1,2,1);
hold on;

for ii =1 : size(HFA,2)
    if isempty(find(sf(ii,:),1));
        plot(tp.x(ii), tp.y(ii), 's',...
            'MarkerFaceColor','none','MarkerEdgeColor',[0 0 0],...
            'MarkerSize',20)
    else
        plot(tp.x(ii), tp.y(ii), 's',...
            'MarkerFaceColor',c(find(sf(ii,:),1),:),'MarkerEdgeColor',[0 0 0],...
            'MarkerSize',20)
        text(tp.x(ii), tp.y(ii),num2str(find(sf(ii,:),1)))
    end
end
axis equal
names = 1:12;
names = num2str(names);


figure;
% subplot(1,2,1);
hold on;

for ii =1 : size(HFA,2)
    if isempty(find(sf(ii,:),1));
        plot(tp.x(ii), tp.y(ii), 's',...
            'MarkerFaceColor','none','MarkerEdgeColor',[0 0 0],...
            'MarkerSize',20)
    else
        plot(tp.x(ii), tp.y(ii), 's',...
            'MarkerFaceColor',c(find(sf(ii,:),1),:),'MarkerEdgeColor',[0 0 0],...
            'MarkerSize',20)
        text(tp.x(ii), tp.y(ii), num2str(P(ii,find(pp(ii,:),1))))
    end
end
axis equal
names = 1:12;
names = num2str(names);

% legend(names)

% % c= jet(12);
% subplot(1,2,2); hold on;
%
% for ii =1 : size(HFA,2)
%     if isempty(find(sf(ii,:),1));
%         plot(tp.turpin_disp_x(ii), tp.turpin_disp_y(ii), 's',...
%             'MarkerFaceColor','none','MarkerEdgeColor',[0 0 0],...
%             'MarkerSize',20)
%     else
%         plot(tp.turpin_disp_x(ii), tp.turpin_disp_y(ii), 's',...
%             'MarkerFaceColor',c(find(sf(ii,:),1),:),'MarkerEdgeColor',[0 0 0],...
%             'MarkerSize',20)
%         text(tp.turpin_disp_x(ii), tp.turpin_disp_y(ii),num2str(find(sf(ii,:),1)))
%     end
% end
% axis equal


%% stepwise
figure;
for ii = 1:12
    [b,se,pval,inmodel,stats,nextstep,history] = stepwisefit(HFA,CH(:, ii),...
        'penter',0.05,'premove',0.10);
    
    subplot(3,4,ii);
    hold on;
    for jj =1 : size(HFA,2)
        if inmodel(jj)==1
            plot(tp.x(jj), tp.y(jj), 's',...
                'MarkerFaceColor','r','MarkerEdgeColor',[0 0 0],... %c(gr(ii),:),...
                'MarkerSize',12)
        else
            plot(tp.x(jj), tp.y(jj), 's',...
                'MarkerFaceColor','none','MarkerEdgeColor',[0 0 0],... %c(gr(ii),:),...
                'MarkerSize',12)
        end
    end
    hold off;
    set(gca,'YLim', get(gca, 'XLim'))
    axis equal
    title(sprintf('%d Oclock',ii))
end
% set(gca,'YLim', get(gca, 'XLim'))
% axis equal
%
% end
% results
% CH; 1 10 16 29 38 57 62 63 64
% CH2; 16 25 28
% CH3; none
% CH4; none
% CH5; 55
% CH6; 9 64
% CH7; 13 17
% CH8; 12
% CH9; 3 4 7 22 25 33
% CH10; 61
% CH11; 61
% CH12; 25 66

%% Factor analysis
% load examgrades
% [Loadings1,specVar1,T,stats] = factoran(grades,1);

%% eigen value

% e = eig(corr(HFA));
e = eig(corr(HFA));

figure; hold on;
plot(e,'-*')
plot([0,70],[1,1],'--')
xlabel 'N factors'
ylabel 'eigen value'

nFact= sum(e> 1);
nGr = nFact-1;

[Loadings1,specVar1,T,stats] = factoran(HFA, nGr);

LC =Loadings1;

%%
% Sigma = cov(HFA);
%
% e = eig(Sigma);
%
% figure; hold on;
% plot(flip(e),'-*')
% plot([0,70],[1,1],'--')
% xlabel 'N factors'
% ylabel 'eigen value'
%
% [LoadingsCov,specVarCov] = ...
%         factoran(Sigma,nFact-1,'Xtype','cov','rotate','none');
% LC = LoadingsCov

%% devide all into groups
gr = zeros(size(HFA,2),1);
for ii =1 : size(HFA,2)
    gr(ii)= find( LC(ii,:)==max(LC(ii,:))) ;
end


%% by color
c = jet(max(gr));
figure;hold on;
for ii =1 : size(HFA,2)
    plot(tp.turpin_disp_x(ii), tp.turpin_disp_y(ii), 's',...
        'MarkerFaceColor',c(gr(ii),:),'MarkerEdgeColor',[0 0 0],...
        'MarkerSize',12)
end
set(gca,'YLim', get(gca, 'XLim'))
axis equal
title 'Factor analysis by HFA10-2 test point'

figure;hold on;
for ii =1 : size(HFA,2)
    plot(tp.x(ii), tp.y(ii), 's',...
        'MarkerFaceColor',c(gr(ii),:),'MarkerEdgeColor',[0 0 0],...
        'MarkerSize',12)
end
set(gca,'YLim', get(gca, 'XLim'))
axis equal
title 'Factor analysis by HFA10-2 test point'

%%
c = jet(max(gr));
figure
subplot(1,2,1);hold on;
for ii =1 : size(HFA,2)
    plot(tp.x(ii), tp.y(ii), 's',...
        'MarkerFaceColor',c(gr(ii),:),'MarkerEdgeColor',[0 0 0],... %c(gr(ii),:),...
        'MarkerSize',12)
end
set(gca,'YLim', get(gca, 'XLim'))
axis equal

hold off;

subplot(1,2,2); hold on;
for ii =1 : size(HFA,2)
    plot(tp.turpin_disp_x(ii), tp.turpin_disp_y(ii), 's',...
        'MarkerFaceColor',c(gr(ii),:),'MarkerEdgeColor', [0 0 0],... %c(gr(ii),:),...
        'MarkerSize',12)
end
set(gca,'YLim', get(gca, 'XLim'))
axis equal

%% HFA & CH
% eigen value

% e = eig(corr(HFA));
e = eig(corr([HFA,CH]));

figure; hold on;
plot(e,'-*')
plot([0,70],[1,1],'--')
xlabel 'N factors'
ylabel 'eigen value'

nFact= sum(e> 1);
nGr = nFact-1;

[Loadings1,specVar1,T,stats] = factoran([HFA,CH], nGr);

LC =Loadings1;
%% devide all into groups
gr = zeros(size([HFA,CH],2),1);
for ii =1 : size([HFA,CH],2)
    gr(ii)= find( LC(ii,:)==max(LC(ii,:))) ;
end

%%
c = jet(max(gr));
figure;
% subplot(1,2,1)
hold on;
for ii =1 : size(HFA,2)
    plot(tp.turpin_disp_x(ii), tp.turpin_disp_y(ii), 's',...
        'MarkerFaceColor',c(gr(ii),:),'MarkerEdgeColor',[0 0 0],...
        'MarkerSize',12)
end
set(gca,'YLim', get(gca, 'XLim'))
axis equal
title 'Factor analysis by HFA10-2 & CH'


figure;
% subplot(1,2,2)
hold on;
for ii =1 : size(HFA,2)
    plot(tp.x(ii), tp.y(ii), 's',...
        'MarkerFaceColor',c(gr(ii),:),'MarkerEdgeColor', [0 0 0],... %c(gr(ii),:),...
        'MarkerSize',12)
end
set(gca,'YLim', get(gca, 'XLim'))
axis equal
title 'Factor analysis by HFA10-2 & CH'

%% export gr hfa & CH
Gr = gr(69:end);
% xlswrite('gr.xlsx', Gr)


%% CH
angels = [0:30:330 ];
% angels = angels + 15;

% c = jet(max(Gr));

figure; hold on;
for ii = 1: length(angels)
    %     figure
    plot(sin(angels(ii)/180*pi),cos(angels(ii)/180*pi)...
        , 's', 'MarkerFaceColor',c(Gr(ii),:),...
        'MarkerEdgeColor', [0 0 0],... %c(gr(ii),:),...
        'MarkerSize',12)
end
axis equal
axis([-2,2,-2,2])

