function RGC_density
% 
% SO@ACH 20170920
%% Harwerth 

% HFA
figure; hold on;

x = linspace(0, 30);

for i = 1 : length(x)
    y(i) = RGC_HFA(x(i), 28);
end

plot(x, y,'Linewidth',2)
xlabel 'eccentricity'
ylabel 'RGC count'
set(gca, 'FontSize',18)
title 'Harwerth '

%% 