function DiplacementTP 

%%
tp_disp = readtable('10-2testpoint_displacement.xlsx');

%% SO displaced test point
figure; hold on;

plot(tp_disp.x, tp_disp.y,'sk','MarkerSize',10);
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

tp_disp.ecc(abs(tp_disp.x)>abs(tp_disp.y)) = abs(tp_disp.x(abs(tp_disp.x)>abs(tp_disp.y)));
tp_disp.ecc(abs(tp_disp.x)<abs(tp_disp.y)) = abs(tp_disp.y(abs(tp_disp.x)<abs(tp_disp.y)));


%% conventinal test point
tp  = readtable('10-2testpoint.csv');

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


%%

M_angle = atan2(tp.y(i),tp.x(i)); %*180/pi; % sita = atan2(Y,X)
Displacement = M_angle;

%% Trupin's formula
% 1. Dc(r, Theta) ; density of RGCs abd Df(r,Theta) density of RGC
% receptive fields at some retinal location(r, Theta) in polar coordinates.
% Btoh functions give density in [cells/mm^2]

% 2. Assume

%% Sj?strand J. Graefe?s Arch Clin Exp Ophthalmol 1999
% x = Cone ecc [mm]
% X = x/3.6 [degree]


M_angle = atan2(tp.y(i),tp.x(i))*180/pi; % sita = atan2(Y,X)

M_angle = atan2(tp.y(i),tp.x(i)); % sita = atan2(Y,X)

disp_y = 0.37*exp(-((x-0.67)/1.12)^2);

%% Sjostrand formula

disp_mm = 1.29*(tp.ecc+0.046).^0.67; %in [mm]

disp_deg = disp_mm./3.6; % convert mm in deg 

tp.disp_mm  = disp_mm; % distance displacement
tp.disp_deg = disp_deg; % convert to deg

tp.Theta =  atan2(tp.y,tp.x); % angle of each test point

tp.disp_x = (tp.ecc+disp_deg) .* cos(Theta); % 
tp.disp_y = (tp.ecc+disp_deg) .* sin(Theta); % 

%% make figure to show this Sjostrand's model
figure; hold on;
plot(tp.disp_x, tp.disp_y,'or','MarkerSize',10)%, 'MarkerFaceColor','k');
plot(tp.x, tp.y,'sk','MarkerSize',8)%, 'MarkerFaceColor','k');

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

%% Medeiros
sort(tp.ecc)
G = findgroups(tp.ecc);

R = [3.4, 5.6, 6.8, 8.3, 9.7];

figure; hold on;
disp_mm = 1.29*(tp.ecc./3.6+0.046).^0.67; %in [mm]
plot(disp_mm)


%% Sjostrand J. Graefe?s Arch Clin Exp Ophthalmol 1999 
% x = Cone ecc [mm] 
% X = x/3.6 [degree]


M_angle = atan2(tp.y(i),tp.x(i));% *180/pi; % sita = atan2(Y,X)

ecc_deg = sqrt(tp.y(i)^2+tp.x(i)^2);
ecc_mm  = 3.6*ecc_deg;

displ_mm = 0.37*exp(-((ecc_mm-0.67)/1.12)^2);
displ_deg = displ_mm/3.6;
