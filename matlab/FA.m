function FA

%% load 30-2 data
cd '/Users/shumpei/Google Drive/CSFI/glc2017';

% checking the excel file
[status,sheets] = xlsfinfo('30-10-6forMatlab.xlsx');

% read raw data
T= readtable('30-10-6forMatlab.xlsx','sheet','Cluster');

S = xlsread('30-10-6forMatlab.xlsx',5);
%% 
% [V,D,W] = eig(S)
nfactors = 2;
[Loadings,specVar,rotation,stats,preds] = factoran(S,nfactors,'rotate','promax');

biplot(Loadings, 'varlabels',num2str((1:76)'), 'Scores',preds);

biplot(Loadings, 'varlabels',num2str((1:76)'));

%%
nfactors = 3;

[Loadings,specVar,rotation,stats,preds] = factoran(S,nfactors,'rotate','promax');

%% PCA

[coeff,score,latent,tsquared,explained] = pca(S)
explained
