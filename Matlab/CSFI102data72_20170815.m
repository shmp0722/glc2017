function CSFI102data72_20170815

%%

filename = 'CSFI10-2data7-2forAnalysis2.csv';

% [status,sheets] = xlsfinfo(filename);

% T = readtable('/CSFI10-2data7-2forAnalysis.xlsx', 'Sheet', 4);
T = readtable(filename);,

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

%% recalcurate RGC_HFA
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
figure; hold on;
plot(T.sum_RGCHFA, T.RGC_HFA__9,'o')

%they are identical
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
for sub = 1:nsub
    [~, RGC_count(sub)] = RGC_HFA_OCT_count(T.QUADRANT_N(sub), 90, T.age(sub), T.MD10_2(sub));
end
T.RGC_QUADRANT_N = RGC_count';

for sub = 1:nsub
    [~, RGC_count(sub)] = RGC_HFA_OCT_count(T.QUADRANT_I(sub), 90, T.age(sub), T.MD10_2(sub));
end
T.RGC_QUADRANT_I = RGC_count';

for sub = 1:nsub
    [~, RGC_count(sub)] = RGC_HFA_OCT_count(T.QUADRANT_S(sub), 90, T.age(sub), T.MD10_2(sub));
end
T.RGC_QUADRANT_S = RGC_count';

for sub = 1:nsub
    [~, RGC_count(sub)] = RGC_HFA_OCT_count(T.QUADRANT_T(sub), 90, T.age(sub), T.MD10_2(sub));
end
T.RGC_QUADRANT_T = RGC_count';


%% CLOCKHOUR
for ii = 246:257
    for sub = 1:nsub
        [~, RGC_count(sub)] = RGC_HFA_OCT_count(T.(fn{ii})(sub), 360/12, T.age(sub), T.MD10_2(sub));
    end
    T.(['RGC_',fn{ii}]) = RGC_count';
end
writetable(T,'CSFI10-2data7-2forAnalysis2.csv')

%%

C = nchoosek(1:length(fn),2);

for  jj = 1:length(C)
    try
        [R(jj),P(jj)] = corr( T.(fn{C(1,jj)}) ,T.(fn{C(2,jj)}));
    catch
        R(jj) = 0;
        P(jj) = 1;
    end
end

