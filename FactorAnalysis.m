function FactorAnalysis

%%
dt10 = xlsread('/Users/shumpei/Google Drive/CSFI/glc2017/CSFI10-2data-7ForAnalysis.xlsx',2);

b = dt10';

[lambda,psi,T,stats,F] = factoran(dt10,7);

[lambda,psi,T,stats,F] = factoran(b,7);


biplot(lambda,'LineWidth',2,'MarkerSize',20)
