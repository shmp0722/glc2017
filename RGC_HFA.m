function Gb = RGC_HFA(ecc, Sa )
%
%
% Sa  = dB ; % sensitivity[dB] at the test point
% ecc = ecc ; % eccentricity in [degree]
% Gb %ganglion cell count
%
% ACH@SO 2017.9.20

%% Harwerth et al. nonlinear model (H?NLM)
Gb = 2.95 * 10^( 0.1 * ((Sa - 1 -(-1.5*1.34*ecc-14.8))) / ( 0.054 * 1.34 * ecc + 0.9));

%% 
