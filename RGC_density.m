function RGC_density
% 
% SO@ACH 20170920
%% Harwerth 

Sa = dB ; % sensitivity[dB] at the test point
ecc = ecc ; % eccentricity in [degree] 

Gb = 2.95 * 10^( 0.1 * ((Sa - 1 -(-1.5*1.34*ecc-14.8))) / ...
    ( 0.054 * 1.34 * ecc + 0.9));

%% figure
figure;l hold on;

x = linspace(0, 30);
y =