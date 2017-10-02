function OneEach
%% load data

pt = readtable('df_20170922_Turpin.xlsx');

% pt = readtable('df_20170901.xlsx');

% remove OHT
% pt(357:358,:) = [];
% writetable(pt, 'df_20170908.csv');

norm = readtable('norm_20170918_Turpin.xlsx');

%% Pick up POAG

for m = 1 : length(pt.ID)
    for n = 1: length(pt.ID);
        rows(n) = strcmp(pt.ID(n), pt.ID(m));
        rows    = logical(rows);
    end
    samePt = find(rows);
    SamePt = pt(rows, :);

end