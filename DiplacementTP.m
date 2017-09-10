function DiplacementTP 

%% 
tp_disp = readtable('~/Google Drive/CSFI/glc2017/10-2testpoint_displacement.xlsx');

%%
figure; hold on;

plot(tp_disp.x, tp_disp.y,'o');
axis equal

% add circle
R = [3.4, 5.6, 6.8, 8.3, 9.7];

C = jet(length(R));

cx = 0; cy = 0; % ??

t = linspace(0,2*pi,100);

for i = 1: length(R) 
    r = R(i);           % ??
    plot(r*sin(t)+cx,r*cos(t)+cy,'Color',C(i,:), 'LineWidth',2.5)
end

axis square
%%
tp_disp.ecc =[];
tp_disp.ecc(abs(tp_disp.x)>abs(tp_disp.y)) = abs(tp_disp.x);
tp_disp.ecc(abs(tp_disp.x)<abs(tp_disp.y)) = abs(tp_disp.y);


%% conventinal test point
tp  = readtable('~/Google Drive/CSFI/glc2017/10-2testpoint.csv');

figure; hold on;

plot(tp.x, tp.y,'sk','MarkerSize',10)%, 'MarkerFaceColor','k');
axis equal

% add circle
R = [1, 3, 5, 7, 9];

C = jet(length(R));

cx = 0; cy = 0; % ??

t = linspace(0,2*pi,100);

for i = 1: length(R) 
    r = R(i);           % ??
    plot(r*sin(t)+cx,r*cos(t)+cy,'Color',C(i,:), 'LineWidth',2.5)
end

axis square
title 'Conventinal test point'
set(gca, 'FontSize',18)