function [RGC_count1, RGC_count2] = RGC_HFA_OCT_count(RNFLT, angle, age, MD )
% 
% This function returns number of RGCs on the test point of HFA10-2 from OCT cpRNFLT measurement.  
%
% Based on "Evaluation of a Method for Estimating Retinal Ganglion Cell
% Counts Using Visual Fields and Optical Coherence Tomography" by Raza, Ali S; Hood, Donald C IOVS 2015.
%
% 
% age; 
% totalDeviation; %from age-matched normative data  
% 
%
% SO@ACH 2017.08.13

%% main 

t = RNFLT; %in [um].
w = pi*3.46*10^3*angle/360;

RGC_count1 = t*w*(-0.007*age + 1.4)*10^0.1*(-0.28*MD+0.18);

%% Medeiros

d = (-0.007 * age) + 1.4;
c = (-0.26 * MD)+ 0.12;
a = RNFLT * w * d;

RGC_count2 = 10^(((log10(a))*10-c)*0.1);



