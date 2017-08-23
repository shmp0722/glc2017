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
load data and edit data frame for stats 
'''

#book = xlrd.open_workbook('/Users/shumpei/Google Drive/CSFI/glc2017/CSFI10-2data7-2-1.xlsx')

df = pd.read_excel('/Users/shumpei/Google Drive/CSFI/glc2017/\
CSFI10-2data7-2-2.xlsx')

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
df['RGC_QUADRANT_I'] = get_RGC_OCT_count(df.QUADRANT_I, 90, df.age, df.MD10_2)
df['RGC_QUADRANT_N'] = get_RGC_OCT_count(df.QUADRANT_N, 90, df.age, df.MD10_2)
df['RGC_QUADRANT_S'] = get_RGC_OCT_count(df.QUADRANT_S, 90, df.age, df.MD10_2)
df['RGC_QUADRANT_T'] = get_RGC_OCT_count(df.QUADRANT_T, 90, df.age, df.MD10_2)


## Clock hour RGC_c
for ii in range(0,12):
    CH = get_RGC_OCT_count(df['CLOCKHOUR_'+str(ii+1)])
    df['RGC_CH'+str(ii+1)] = get_RGC_OCT_count(df['CLOCKHOUR_'+str(ii+1)])

#CH1 = get_RGC_OCT_count(df.CLOCKHOUR_1, 360/12, df.age, df.MD10_2)
#CH2 = get_RGC_OCT_count(df.CLOCKHOUR_2, 360/12, df.age, df.MD10_2)
#CH3 = get_RGC_OCT_count(df.CLOCKHOUR_3, 360/12, df.age, df.MD10_2)
#CH4 = get_RGC_OCT_count(df.CLOCKHOUR_4, 360/12, df.age, df.MD10_2)
#CH5 = get_RGC_OCT_count(df.CLOCKHOUR_5, 360/12, df.age, df.MD10_2)
#CH6 = get_RGC_OCT_count(df.CLOCKHOUR_6, 360/12, df.age, df.MD10_2)
#CH7 = get_RGC_OCT_count(df.CLOCKHOUR_7, 360/12, df.age, df.MD10_2)
#CH8 = get_RGC_OCT_count(df.CLOCKHOUR_8, 360/12, df.age, df.MD10_2)
#CH9 = get_RGC_OCT_count(df.CLOCKHOUR_9, 360/12, df.age, df.MD10_2)
#CH10 = get_RGC_OCT_count(df.CLOCKHOUR_10, 360/12, df.age, df.MD10_2)
#CH11 = get_RGC_OCT_count(df.CLOCKHOUR_11, 360/12, df.age, df.MD10_2)
#CH12 = get_RGC_OCT_count(df.CLOCKHOUR_12, 360/12, df.age, df.MD10_2)
#
#df4 = pd.DataFrame([CH1,CH2,CH3,CH4,CH5,CH6,CH7,CH8,CH9,CH10,CH11,CH12]).T
#df4.columns = ['RGC_CH1','RGC_CH2','RGC_CH3','RGC_CH4','RGC_CH5',\
#               'RGC_CH6','RGC_CH7','RGC_CH8','RGC_CH9','RGC_CH10',\
#               'RGC_CH11','RGC_CH12']
#
#df4.to_csv('ClockHour.csv')
#
#df = pd.concat([df, df4],axis=1) # latest df

RGC_OCT2 = pd.DataFrame(df.RGC_OCT/2)
RGC_OCT2.columns = ['RGC_OCT2']

df = pd.concat([df, RGC_OCT2],axis=1) # latest df


#df.to_csv('CSFI10-2data7-2-2.csv')

toukei =  df.describe()
toukei.to_csv('Describe.csv')

# corralation_matrix
Corr = df.corr()
Corr.to_csv('Corr_mat.csv')

#del(df2,df3,df4)

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


def RGC_HFA10_count(dB, testpoint_n ):
    tp = pd.read_excel("~/Google Drive/CSFI/glc2017/10-2testpoint_displacement.xlsx")
    Ecc = np.sqrt(tp.x[testpoint_n]**2 + tp.y[testpoint_n]**2)
    
    RGC_count = 10**(0.1*(dB-1-(-1.5*1.34*Ecc-14.8))/(0.054*1.34*Ecc+0.9))*2.95/9;
    return RGC_count

#RGC_displ_P1 = RGC_HFA10_count(df.P1, 0)
df2 = df.copy()

for ii in range(0, 68):
    df2['RGC_disp'+'_P'+str(ii)] = RGC_HFA10_count(df2['P'+str(ii+1)], ii)

cl =[]
for ii in range(0, 68):
    cl += ['RGC_disp'+'_P'+str(ii)]

RGC_HFA10_disp =  df[cl]
Sum = RGC_HFA10_disp.sum()
df['RGC_HFA10_disp']= RGC_HFA10_disp.sum()

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

fig = plt.figure()
plt.plot(df.RGC_HFA9, df.RGC_OCT2,'.r')
plt.title('RGC_HFA10-2 vs RGC_OCT2')
plt.xlabel('RGC_HFA10-2')
plt.ylabel('RGC_OCT')
plt.axis('square')

fig.set_dpi(300)
#fig.savefig('RGC_HFA10-2vsRGC_OCT.png')
fig.savefig('RGC_HFA10-2vsRGC_OCT2.png', dpi=300, orientation='portrait', \
            transparent=False, pad_inches=0.0)

#
fig = plt.figure()
plt.plot(df.RGC_HFA9, df.RGC_OCT,'.b')
plt.plot(df.RGC_HFA9, df.RGC_OCT2,'.r')
plt.title('RGC_HFA10-2 vs RGC_OCT')
plt.xlabel('RGC_HFA10-2')
plt.ylabel('RGC_OCT')
plt.axis('square')
plt.legend(['360','180'])

fig.set_dpi(300)
#fig.savefig('RGC_HFA10-2vsRGC_OCT.png')
fig.savefig('RGC_HFA10-2vsRGC_OCT3.png', dpi=300, orientation='portrait', \
            transparent=False, pad_inches=0.0)


'''
# chekc HFA_RGC9 vs GCC

'''

field_names = df.columns # get columns

np.corrcoef(df.RGC_HFA9,df.RGC_OCT)
np.corrcoef(df.RGC_HFA9, df.GC_AVERAGE)
np.corrcoef(df.RGC_HFA9, df.GC_MINIMUM)

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


FA10 = pd.read_csv("/Users/shumpei/Google Drive/CSFI/glc2017/Results_FactorAnalysis.csv")

from scipy import linalg
from sklearn.decomposition import PCA, FactorAnalysis
from sklearn.covariance import ShrunkCovariance, LedoitWolf
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import GridSearchCV


# Fit the models
n_features = 5;
n_components = np.arange(0, n_features, 5)  # options for n_components


def compute_scores(X):
    pca = PCA(svd_solver='full')
    fa = FactorAnalysis()

    pca_scores, fa_scores = [], []
    for n in n_components:
        pca.n_components = n
        fa.n_components = n
        pca_scores.append(np.mean(cross_val_score(pca, X)))
        fa_scores.append(np.mean(cross_val_score(fa, X)))

    return pca_scores, fa_scores


def shrunk_cov_score(X):
    shrinkages = np.logspace(-2, 0, 30)
    cv = GridSearchCV(ShrunkCovariance(), {'shrinkage': shrinkages})
    return np.mean(cross_val_score(cv.fit(X).best_estimator_, X))


def lw_score(X):
    return np.mean(cross_val_score(LedoitWolf(), X))


for X, title in [(X_homo, 'Homoscedastic Noise'),
                 (X_hetero, 'Heteroscedastic Noise')]:
    pca_scores, fa_scores = compute_scores(X)
    n_components_pca = n_components[np.argmax(pca_scores)]
    n_components_fa = n_components[np.argmax(fa_scores)]

    pca = PCA(svd_solver='full', n_components='mle')
    pca.fit(X)
    n_components_pca_mle = pca.n_components_

    print("best n_components by PCA CV = %d" % n_components_pca)
    print("best n_components by FactorAnalysis CV = %d" % n_components_fa)
    print("best n_components by PCA MLE = %d" % n_components_pca_mle)

'''
figure
'''

plt.figure()
plt.plot(n_components, pca_scores, 'b', label='PCA scores')
plt.plot(n_components, fa_scores, 'r', label='FA scores')
plt.axvline(rank, color='g', label='TRUTH: %d' % rank, linestyle='-')
plt.axvline(n_components_pca, color='b',
                label='PCA CV: %d' % n_components_pca, linestyle='--')
plt.axvline(n_components_fa, color='r',
               label='FactorAnalysis CV: %d' % n_components_fa,
                linestyle='--')
plt.axvline(n_components_pca_mle, color='k',
                label='PCA MLE: %d' % n_components_pca_mle, linestyle='--')

 # compare with other covariance estimators
plt.axhline(shrunk_cov_score(X), color='violet',
                label='Shrunk Covariance MLE', linestyle='-.')
plt.axhline(lw_score(X), color='orange',
                label='LedoitWolf MLE' % n_components_pca_mle, linestyle='-.')

plt.xlabel('nb of components')
plt.ylabel('CV scores')
plt.legend(loc='lower right')
plt.title(title)

plt.show()
