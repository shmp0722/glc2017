function STEPWISE

% CH = readtable(fullfile(pwd,'df_20171002_Turpin.xls'),'Sheet','CH');
% HFA = readtable(fullfile(pwd,'df_20171002_Turpin.xls'),'Sheet','HFA');

%%
[theMessage, description, format] = xlsfinfo(fullfile(pwd,'df_20171002_Turpin.xlsx'))

CH = xlsread(fullfile(pwd,'df_20171002_Turpin.xlsx'),3);
HFA = xlsread(fullfile(pwd,'df_20171002_Turpin.xlsx'), 4);

%% stepwise

for ii = 1:12
[b,se,pval,inmodel,stats,nextstep,history] = stepwisefit(HFA,CH(:, ii),...
            'penter',0.05,'premove',0.10); 
end
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

[Loadings1,specVar1,T,stats] = factoran(HFA,nFact-1);

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
%% 
tp = readtable(fullfile(pwd, '10-2testpoint_displacement.xlsx'));
