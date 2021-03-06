function [RGC_count] = RGC_HFA10_count(dB ,  N_testpoint)
% 
% This function returns number of RGCs on the test point of HFA10-2.  
%
% Based on "Evaluation of a Method for Estimating Retinal Ganglion Cell
% Counts Using Visual Fields and Optical Coherence Tomography" by Raza, Ali S; Hood, Donald C IOVS 2015.
%
%
% dB 
% 
%
% SO@ACH 2017.08.13

%% 
% if is(N_testpoint)

    tp =[-1,1,-5,-3,-1,1,3,5,-7,-5,-3,-1,1,3,5,7,-7,-5,-3,-1,1,3,5,7,-9,-7,-5,-3,-1,1,3,5,7,9,-9,-7,-5,-3,-1,1,3,5,7,9,-7,-5,-3,-1,1,3,5,7,-7,-5,-3,-1,1,3,5,7,-5,-3,-1,1,3,5,-1,1;...
        9,9,7,7,7,7,7,7,5,5,5,5,5,5,5,5,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-3,-3,-3,-3,-3,-3,-3,-3,-5,-5,-5,-5,-5,-5,-5,-5,-7,-7,-7,-7,-7,-7,-9,-9];
    
    for i = 1:length(tp)
        Ecc_tp(i) =sqrt(tp(1,i)^2+tp(2,i)^2);
    end
    ecc = Ecc_tp(N_testpoint);
% end

%%
RGC_count = 10^(0.1*(dB-1-(-1.5*1.34*ecc-14.8))/(0.054*1.34*ecc+0.9))*2.95/9;
