#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Sun Aug 20 13:23:11 2017

@author: shumpei
"""

import os
import numpy as np
import pandas as pd
import seaborn as sb
import xlrd
import matplotlib.pyplot as plt

'''
load data 
'''

#book = xlrd.open_workbook('/Users/shumpei/Google Drive/CSFI/glc2017/CSFI10-2data7-2-1.xlsx')

df = pd.read_excel('/Users/shumpei/Google Drive/CSFI/glc2017/CSFI10-2data7-2-2.xlsx')

def get_RGC_OCT_count(RNFLT, angle, age, MD):   # Medeiros 
    w = np.pi*3.46*10**3*angle/360 #
    d = (-0.007 * age) + 1.4
    c = (-0.26 * MD)+ 0.12
    a = RNFLT * w * d

    RGC_count = 10**(((np.log10(a))*10-c)*0.1);
    return RGC_count

field_names = df.columns # get columns

# calcurate quadrant RGC from cpRNFLT
QUADRANT_I = get_RGC_OCT_count(df.QUADRANT_I,90, df.age, df.MD10_2)
QUADRANT_N = get_RGC_OCT_count(df.QUADRANT_N,90, df.age, df.MD10_2)
QUADRANT_S = get_RGC_OCT_count(df.QUADRANT_S,90, df.age, df.MD10_2)
QUADRANT_T = get_RGC_OCT_count(df.QUADRANT_T,90, df.age, df.MD10_2)

# data frames
df2 = df

df3 = pd.DataFrame(QUADRANT_I)
df3.columns = ['RGC_QUADRANT_I']

df2 = pd.concat([df2, df3],axis=1)

df3 = pd.DataFrame(QUADRANT_N)
df3.columns = ['RGC_QUADRANT_N']

df2 = pd.concat([df2, df3],axis=1)

df3 = pd.DataFrame(QUADRANT_S)
df3.columns = ['RGC_QUADRANT_S']

df2 = pd.concat([df2, df3],axis=1)

df3 = pd.DataFrame(QUADRANT_T)
df3.columns = ['RGC_QUADRANT_T']

df2 = pd.concat([df2, df3],axis=1)

df = df2

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

'''
Figures
'''




 