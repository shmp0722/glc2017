%% load data
[theMessage, description, format] = xlsfinfo(fullfile(pwd,'df_20171002_Turpin.xlsx'));

CH = xlsread(fullfile(pwd,'df_20171002_Turpin.xlsx'),3);
HFA = xlsread(fullfile(pwd,'df_20171002_Turpin.xlsx'), 4);

% 
addpath(genpath(fullfile(pwd,'Stochastic_Bosque')));

%%  load 10-2 test point
% tp = xlsread(fullfile(pwd, '10-2testpoint.xlsx'));
tp = readtable(fullfile(pwd, '10-2testpoint.xlsx'));

%%
load ionosphere % Contains X and Y variables
Mdl = fitctree(X,Y);
view(Mdl,'mode','graph') % graphic description

load carsmall % Contains Horsepower, Weight, MPG
X = [Horsepower Weight];
Mdl = fitrtree(X,MPG);
view(Mdl,'mode','graph') % graphic description


load fisheriris % load the sample data
ctree = fitctree(meas,species); % create classification tree
view(ctree) % text description

view(ctree,'mode','graph') % graphic description

%% 
load ionosphere
CMdl = fitctree(X,Y);
view(CMdl,'mode','graph') % graphic description

Ynew = predict(CMdl,mean(X))

%%
load carsmall
idxNaN = isnan(MPG + Weight);
X = Weight(~idxNaN);
Y = MPG(~idxNaN);
n = numel(X);

rng(1) % For reproducibility
idxTrn = false(n,1);
idxTrn(randsample(n,round(0.5*n))) = true; % Training set logical indices
idxVal = idxTrn == false;                  % Validation set logical indices

Mdl = fitrtree(X(idxTrn),Y(idxTrn));
view(Mdl,'Mode','graph')

m = max(Mdl.PruneList);
pruneLevels = 0:2:m; % Pruning levels to consider
z = numel(pruneLevels);
Yfit = predict(Mdl,X(idxVal),'SubTrees',pruneLevels);

figure;
sortDat = sortrows([X(idxVal) Y(idxVal) Yfit],1); % Sort all data with respect to X
plot(sortDat(:,1),sortDat(:,2),'*');
hold on;
plot(repmat(sortDat(:,1),1,size(Yfit,2)),sortDat(:,3:end));
lev = cellstr(num2str((pruneLevels)','Level %d MPG'));
legend(['Observed MPG'; lev])
title 'Out-of-Sample Predictions'
xlabel 'Weight (lbs)';
ylabel 'MPG';
h = findobj(gcf);
axis tight;
set(h(4:end),'LineWidth',3) % Widen all lines
