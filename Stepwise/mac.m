%% load data
[theMessage, description, format] = xlsfinfo(fullfile(pwd,'df_20171002_Turpin.xlsx'));

CH  = xlsread(fullfile(pwd,'df_20171002_Turpin.xlsx'),3);
HFA = xlsread(fullfile(pwd,'df_20171002_Turpin.xlsx'), 4);
m   = xlsread(fullfile(pwd,'df_20171002_Turpin.xlsx'), 2);
mlabel = readtable(fullfile(pwd,'df_20171002_Turpin.xlsx'),'Sheet',2);
%
addpath(genpath(fullfile(pwd,'Stochastic_Bosque')));

%%  load 10-2 test point
% tp = xlsread(fullfile(pwd, '10-2testpoint.xlsx'));
tp = readtable(fullfile(pwd, '10-2testpoint.xlsx'));

%% Examples

for ii = 1:12
    mdl_tr{ii} = fitctree(HFA(1:60,:), CH(1:60, ii)); % training 
    
    figure; hold on;
    plot(CH(61:end,ii), predict( mdl_tr{ii}, HFA(61:end,:)), 'o') % prediction
    xlabel 'measured'
    ylabel 'predicted'
    title(sprintf('%d oclock', ii))
    
    fitlm(CH(61:end,ii), predict( mdl_tr{ii}, HFA(61:end,:)))
end



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
