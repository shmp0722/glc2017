function CSFI102data72_20170814

%%

filename ='/Users/shumpei/Google Drive/CSFI/glc2017/CSFI10-2data7-2forAnalysis.xlsx';


[status,sheets] = xlsfinfo(filename);

T = readtable('/Users/shumpei/Google Drive/CSFI/glc2017/CSFI10-2data7-2forAnalysis.xlsx', 'Sheet', 4);

%% summary
summary(T)
%%
[G, disease] = findgroups(T.disease);


%% plot 1
figure; hold on;
plot(T.MD10_2,T.RGC_OCT_,'ob')
plot(T.MD10_2,T.RGC_HFA__9,'or')
plot(T.MD10_2,T.wRGC_9,'og')
xlabel('MD value')
ylabel('estimated num of RGC')
legend({'OCT','HFA','weighted'})

%% RGC_HFA
fn = fieldnames(T);
nsub = length(T.age);

RGC_HFA = nan(nsub,68);

for sub = 1:nsub
    for i = 19:19+68-1
        [RGC_HFA(sub,i-18)] = RGC_HFA10_count(T.(fn{i})(sub) , i-18);
    end
end

T.sum_RGCHFA = sum(RGC_HFA,2);        

%%
for sub = 1:nsub
    [RGC_count1(sub), RGC_count2(sub)] = RGC_HFA_OCT_count(T.cpRNFL(sub), 360, T.age(sub), T.MD10_2(sub));
end

figure; hold on;
% plot(T.sum_RGCHFA,  RGC_count2(sub)','o')

% plot(RGC_count1)
plot(RGC_count2)
plot(T.RGC_OCT_)

%%
figure; hold on;
plot(T.sum_RGCHFA,  RGC_count2(sub)','or')

