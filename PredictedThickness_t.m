function t =  PredictedThickness_t(Sa , ecc, w, age, D)
% 
%
% Sa  = dB ; % sensitivity[dB] at the test point
% ecc = ecc ; % eccentricity in [degree]
% w = width ; % the width the region of interest in [?m] for the entire 
%               circle scan, about 10,870 ?m given a circle diameter of
%               3.46 mm, but note this value will be smaller for local 
%               regions of the circle);
% age [year]; 
% D;          % total deviation from age?matched normative data 
%               (averaged over each point in the region of the visual field)
%
% SO@ACH 2017.9.20

%% 
GbfromHFA = RGC_HFA(ecc, Sa );

t = GbfromHFA/(w * (-0.007*age + 1.4)*10^(0.1*(-0.28*D+0.18)));



