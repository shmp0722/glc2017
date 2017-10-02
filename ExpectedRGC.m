function rgc = ExpectedRGC(age, OpticDiscArea )
%
% 
%
%
%
% SO@ACH 20170929

%% formula
a   = -9249; % age/y;
ODA = 11607; %  optic disc area;
constant = 1301098; % constant;
rgc = a*age + OpticDiscArea * 10 * ODA + constant;
