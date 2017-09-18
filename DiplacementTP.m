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


% add circle
R = [1, 3, 5, 7, 9]; % radious
C = jet(length(R));  % color for lines

cx = 0; cy = 0; % center

t = linspace(0,2*pi,100);

for i = 1: length(R) 
    r = R(i);           % ??
    plot(r*sin(t)+cx,r*cos(t)+cy,'Color',C(i,:), 'LineWidth',2.5)
end

legend(num2str(R(1)),num2str(R(2)),num2str(R(3)),num2str(R(4)),num2str(R(5)))


plot(tp.x, tp.y,'sk','MarkerSize',10)%, 'MarkerFaceColor','k');
axis equal

axis square
title 'Conventinal test point'
set(gca, 'FontSize',18)


%% Sj?strand J. Graefe?s Arch Clin Exp Ophthalmol 1999
% x = Cone ecc [mm]
% X = x/3.6 [degree]


M_angle = atan2(tp.y(i),tp.x(i))*180/pi; % sita = atan2(Y,X)

M_angle = atan2(tp.y(i),tp.x(i)); % sita = atan2(Y,X)

% disp_y = 0.37*exp(-((x-0.67)/1.12)^2);

%% Sjostrand formula

disp_mm = 1.29*(tp.ecc+0.046).^0.67; %in [mm]

disp_deg = disp_mm./3.6; % convert mm in deg 

tp.disp_mm  = disp_mm; % distance displacement
tp.disp_deg = disp_deg; % convert to deg

tp.Theta =  atan2(tp.y,tp.x); % angle of each test point

tp.disp_x = (tp.ecc+disp_deg) .* cos(tp.Theta); % 
tp.disp_y = (tp.ecc+disp_deg) .* sin(tp.Theta); % 

%% make figure to show this Sjostrand's model
figure; hold on;

% add circle
R = [1, 3, 5, 7, 9];

C = jet(length(R));

cx = 0; cy = 0; % ??

t = linspace(0,2*pi,100);

for i = 1: length(R)
    r = R(i);           % ??
    plot(r*sin(t)+cx,r*cos(t)+cy,'Color',C(i,:), 'LineWidth',2.5)
end

legend(num2str(R(1)),num2str(R(2)),num2str(R(3)),num2str(R(4)),num2str(R(5)))

plot(tp.disp_x, tp.disp_y,'or','MarkerSize',10)%, 'MarkerFaceColor','k');
plot(tp.x, tp.y,'sk','MarkerSize',8)%, 'MarkerFaceColor','k');

axis equal
title 'Sjostrand model'
set(gca,'FontSize',18)
%% make figure to show this Sjostrand's model
figure; hold on;

% add circle
R = [1, 3, 5, 7, 9];

C = jet(length(R));

cx = 0; cy = 0; % ??

t = linspace(0,2*pi,100);

for i = 1: length(R)
    r = R(i);           % ??
    plot(r*sin(t)+cx,r*cos(t)+cy,'Color',C(i,:), 'LineWidth',2.5)
end

legend(num2str(R(1)),num2str(R(2)),num2str(R(3)),num2str(R(4)),num2str(R(5)))

plot(tp.disp_x, tp.disp_y,'sk','MarkerSize',10)%, 'MarkerFaceColor','k');
% plot(tp.x, tp.y,'sk','MarkerSize',8)%, 'MarkerFaceColor','k');

axis equal
title 'Sjostrand model'
set(gca,'FontSize',18)

%% Sjostrand J. Graefe?s Arch Clin Exp Ophthalmol 1999 
% x = Cone ecc [mm] 
% X = x/3.6 [degree]


M_angle = atan2(tp.y(i),tp.x(i));% *180/pi; % sita = atan2(Y,X)

ecc_deg = sqrt(tp.y(i)^2+tp.x(i)^2);
ecc_mm  = 3.6*ecc_deg;

displ_mm = 0.37*exp(-((ecc_mm-0.67)/1.12)^2);
displ_deg = displ_mm/3.6;


%% Drasdo model
% Drasdo N. "The length of Henle fibers in the human retina and a model of
% ganglion receptive field density in the visual field." 
% Vison Research 2007. 
%
% Lateral displacement at a location in the ganglion cell layer (GCL) 
% is calculated using the coefficients ai, bi, ci, and di
% and a temporary variable T as follows: 
% for an eccentricity in the ganglion cell layer (eccGCL) falling
% between xi and xi + 1, 
%
% T = eccGCL - xi;
% Displacement = ((ai/6 ?T + bi/2) ?T + ci) ?T + di 
% Eccentricity in the layer of inner segments 
%
% (eccIS) = eccGCL ? displacement.

%% polynomals
% sheet = 1;
Nasal = readtable('Drasdo.xlsx','Sheet','Nasal');

% sheet = 2;
Temporal = readtable('Drasdo.xlsx','Sheet','Temporal');

%% Trupin described Drasdo's formula like this
% 1. Dc(r, Theta) ; density of RGCs abd Df(r,Theta) density of RGC
% receptive fields at some retinal location(r, Theta) in polar coordinates.
% Btoh functions give density in [cells/mm^2]

% 2. Assume we wish to estimate the displacement for receptive field 
% location (R,h), and that alpha(degree) and K are chosen so that the sector subtending
% alpha degrees centered on h is tiled into K subsectors (as in the left panel
% of Figure 1).

% 3. Compute the number of receptive fields in the sector out to 
% radius R mm: 
% 
% Nf = symsum((alpha*pi/360)*(2*iR^2/K^2)*Df(iR/K, theta), k , 1, K)
%
% 4.Compute the number of RGCs in the sector out to radius kR/K mm,
% for some k >= 1:
%
% Nc = symsum((alpha*pi/360)*(2*iR^2/K^2)*Dc(iR/K, theta), k , 1, K)
%
% This is the RGC curve in the right of Figure 1.
%
% 5. Find k so that jNc(k)  Nfj is minimized.
%
% 6. Report displacement as kR/K  R mm.
%
% In this paper, we used the equations of Drasdo et al.6 to
% compute Df, at angular eccentricity (E) as follows:
%
% Rve = Rv0(1 + r/E2v(theta)); 
%
% Roe = Ro0(1 + r/E2o(theta));
%
% k(r) = 1+(1.004 - 0.007209*r + 0.001694*r^2 - 0:00003765^r^3)^-2;
%
% Df(r/theta) = (1.12 + 0.0273*r)*k/1.155/(Rve^2-Roe^2);

%%
% tp  = readtable('10-2testpoint.csv');
tp.Theta =  atan2(tp.y,tp.x); % angle of each test point

tp.turpin_disp_x = (tp.ecc+tp.turpin_disp) .* cos(tp.Theta); % 
tp.turpin_disp_y = (tp.ecc+tp.turpin_disp) .* sin(tp.Theta); % 

writetable(tp,'10-2testpoint.csv')
%% figure
figure; hold on;

% add circle
R = [1, 3, 5, 7, 9];

C = jet(length(R));

cx = 0; cy = 0; % ??

t = linspace(0,2*pi,100);

for i = 1: length(R)
    r = R(i);           % ??
    plot(r*sin(t)+cx,r*cos(t)+cy,'Color',C(i,:), 'LineWidth',2.5)
end

legend(num2str(R(1)),num2str(R(2)),num2str(R(3)),num2str(R(4)),num2str(R(5)))

plot(tp.turpin_disp_x , tp.turpin_disp_y,'sk','MarkerSize',10)%, 'MarkerFaceColor','k');
% plot(tp.x, tp.y,'sk','MarkerSize',8)%, 'MarkerFaceColor','k');

axis equal
title 'Turpin model'
set(gca,'FontSize',18)