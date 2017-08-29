#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Tue Aug 29 18:07:20 2017

@author: ganka
"""
# =============================================================================
# import packages
# =============================================================================

import os
import numpy as np
import pandas as pd
#import seaborn as sb
import xlrd
import matplotlib.pyplot as plt

# =============================================================================
# 
# =============================================================================
norm = pd.read_excel('Normal_CSFI10-2data-2.xlsx')


""" 
get RGC_OCT 
"""
def get_RGC_OCT_count(RNFLT, angle, age, MD):   # Medeiros 
    w = np.pi*3.46*10**3*angle/360 #
    d = (-0.007 * age) + 1.4
    c = (-0.26 * MD)+ 0.12
    a = RNFLT * w * d

    RGC_count = 10**(((np.log10(a))*10-c)*0.1);
    return RGC_count


# calcurate quadrant RGC from cpRNFLT
norm['RGC_QUADRANT_I'] = get_RGC_OCT_count(norm.QUADRANT_I, 90, norm.age, norm.MD10_2)
norm['RGC_QUADRANT_N'] = get_RGC_OCT_count(norm.QUADRANT_N, 90, norm.age, norm.MD10_2)
norm['RGC_QUADRANT_S'] = get_RGC_OCT_count(norm.QUADRANT_S, 90, norm.age, norm.MD10_2)
norm['RGC_QUADRANT_T'] = get_RGC_OCT_count(norm.QUADRANT_T, 90, norm.age, norm.MD10_2)


## Clock hour RGC_c
for ii in range(0,12):
    norm['RGC_CH'+str(ii+1)] = get_RGC_OCT_count(norm['CLOCKHOUR_'+str(ii+1)],\
      360/12, norm.age, norm.MD10_2)
    
# RGC_OCT2
norm['RGC_OCT2'] = norm.RGC_OCT/2

# RGC_HFA10-2
def RGC_HFA10_count(dB, testpoint_n ):
    tp = pd.read_excel("10-2testpoint_displacement.xlsx")
    Ecc = np.sqrt(tp.x[testpoint_n]**2 + tp.y[testpoint_n]**2)
    
    RGC_count = 10**(0.1*(dB-1-(-1.5*1.34*Ecc-14.8))/(0.054*1.34*Ecc+0.9))*2.95/9;
    return RGC_count

#RGC_displ_P1 = RGC_HFA10_count(df.P1, 0)
for ii in range(0, 68):
    norm['RGC_disp'+'_P'+str(ii+1)] = RGC_HFA10_count(norm['P'+str(ii+1)], ii)


list = 
norm['RGC_disp'] = sum([])


