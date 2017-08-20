#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Sun Aug 20 13:23:11 2017

@author: shumpei
"""

import os
import numpy as np
import pandas as pd
#import seaborn as sb
import xlrd
import matplotlib.pyplot as plt

'''
load data 
'''

#book = xlrd.open_workbook('/Users/shumpei/Google Drive/CSFI/glc2017/CSFI10-2data7-2-1.xlsx')

df = pd.read_excel('/Users/shumpei/Google Drive/CSFI/glc2017/\
CSFI10-2data7-2-2.xlsx')

def get_RGC_OCT_count(RNFLT, angle, age, MD):   # Medeiros 
    w = np.pi*3.46*10**3*angle/360 #
    d = (-0.007 * age) + 1.4
    c = (-0.26 * MD)+ 0.12
    a = RNFLT * w * d

    RGC_count = 10**(((np.log10(a))*10-c)*0.1);
    return RGC_count

field_names = df.columns # get columns

# calcurate quadrant RGC from cpRNFLT
QUADRANT_I = get_RGC_OCT_count(df.QUADRANT_I, 90, df.age, df.MD10_2)
QUADRANT_N = get_RGC_OCT_count(df.QUADRANT_N, 90, df.age, df.MD10_2)
QUADRANT_S = get_RGC_OCT_count(df.QUADRANT_S, 90, df.age, df.MD10_2)
QUADRANT_T = get_RGC_OCT_count(df.QUADRANT_T, 90, df.age, df.MD10_2)

df2 = pd.DataFrame([QUADRANT_I,QUADRANT_N,QUADRANT_S,QUADRANT_T]).T
df2.columns = ['RGC_QUADRANT_I','RGC_QUADRANT_N','RGC_QUADRANT_S',\
'RGC_QUADRANT_T']

df = pd.concat([df, df2],axis=1)

## Clock hour RGC_c
CH1 = get_RGC_OCT_count(df.CLOCKHOUR_1, 360/12, df.age, df.MD10_2)
CH2 = get_RGC_OCT_count(df.CLOCKHOUR_2, 360/12, df.age, df.MD10_2)
CH3 = get_RGC_OCT_count(df.CLOCKHOUR_3, 360/12, df.age, df.MD10_2)
CH4 = get_RGC_OCT_count(df.CLOCKHOUR_4, 360/12, df.age, df.MD10_2)
CH5 = get_RGC_OCT_count(df.CLOCKHOUR_5, 360/12, df.age, df.MD10_2)
CH6 = get_RGC_OCT_count(df.CLOCKHOUR_6, 360/12, df.age, df.MD10_2)
CH7 = get_RGC_OCT_count(df.CLOCKHOUR_7, 360/12, df.age, df.MD10_2)
CH8 = get_RGC_OCT_count(df.CLOCKHOUR_8, 360/12, df.age, df.MD10_2)
CH9 = get_RGC_OCT_count(df.CLOCKHOUR_9, 360/12, df.age, df.MD10_2)
CH10 = get_RGC_OCT_count(df.CLOCKHOUR_10, 360/12, df.age, df.MD10_2)
CH11 = get_RGC_OCT_count(df.CLOCKHOUR_11, 360/12, df.age, df.MD10_2)
CH12 = get_RGC_OCT_count(df.CLOCKHOUR_12, 360/12, df.age, df.MD10_2)

df4 = pd.DataFrame([CH1,CH2,CH3,CH4,CH5,CH6,CH7,CH8,CH9,CH10,CH11,CH12]).T
df4.columns = ['RGC_CH1','RGC_CH2','RGC_CH3','RGC_CH4','RGC_CH5',\
               'RGC_CH6','RGC_CH7','RGC_CH8','RGC_CH9','RGC_CH10',\
               'RGC_CH11','RGC_CH12']

df4.to_csv('ClockHour.csv')

df = pd.concat([df, df4],axis=1) # latest df
df.to_csv('CSFI10-2data7-2-2.csv')

toukei =  df.describe()
toukei.to_csv('Describe.csv')

# corralation_matrix
Corr = df.corr()
Corr.to_csv('Corr_mat.csv')

#del(df2,df3,df4)

'''
Figures
'''

fig = plt.figure()
plt.plot(df.RGC_HFA9,df.RGC_OCT,'.')
plt.title('RGC_HFA10-2 vs RGC_OCT')
plt.xlabel('RGC_HFA10-2')
plt.ylabel('RGC_OCT')
plt.axis('square')

fig.set_dpi(300)
#fig.savefig('RGC_HFA10-2vsRGC_OCT.png')
fig.savefig('RGC_HFA10-2vsRGC_OCT.png', dpi=300, orientation='portrait', \
            transparent=False, pad_inches=0.0)
#plt.savefig('RGC_HFA10-2vsRGC_OCT.pdf', orientation='portrait', transparent=False, bbox_inches=None, frameon=None)

np.corrcoef(df.RGC_HFA9,df.RGC_OCT)

'''
if HFA30 
'''

def RGC_HFA30_count(dB, testpoint_n):
    x_tp = [-9,-3,3,9,-15,-9,-3,3,9,15,-21,-15,-9,-3,3,9,15,-27,-21,-15,-9,\
            -3,3,9,15,21,27,-27,-21,-15,-9,-3,3,9,15,21,27,-27,-21,-15,-9,-3,\
            3,9,15,21,27,-27,-21,-15,-9,-3,3	,9,15,21,27,-21,-15,-9	,-3,3,9,21,\
            -15,-9,-3,3,9,15,-9,-3,3,9]
    y_tp = [27,27	,27,27,21,21,21,21,21,21,15,15,15,15,15,15,15,9,9,9,9,9,9,9,\
            9,9,9,3,3,3,3,3,3,3,3,3,3,-3,-3,-3,-3,-3,-3,-3,-3,-3,-3,-9,-9,-9,\
            -9,-9,-9,-9,-9,-9,-9,-15,-15,-15,-15,-15,-15,-15,-15,-21,-21,-21,\
            -21,-21,-21,-27,-27,-27,-27]
    # Ecc; test point location in visual angle 
    Ecc = np.sqrt(x_tp[testpoint_n]**2 + y_tp[testpoint_n]**2) 
    
    RGC_count = 10**(0.1*(dB-1-(-1.5*1.34*Ecc-14.8))/(0.054*1.34*Ecc+0.9))*2.95;
    return RGC_count


'''
Factor analysis
'''



                   
