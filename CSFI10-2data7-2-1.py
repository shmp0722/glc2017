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
    df['RGC_CH'+str(ii+1)] = get_RGC_OCT_count(df['CLOCKHOUR_'+str(ii+1)],\
      360/12, df.age, df.MD10_2)

# RGC_OCT2
df['RGC_OCT2'] = df.RGC_OCT/2
df.to_excel('CSFI10-2data_0823.xlsx')
#df.to_csv('CSFI10-2data7-2-2.csv')

toukei =  df.describe()
#toukei.to_csv('Describe.csv')

# corralation_matrix
Corr = df.corr()
#Corr.to_csv('Corr_mat.csv')

#del(df2,df3,df4)

def RGC_HFA30_count(dB, testpoint_n):
    tp = pd.read_excel("~/Google Drive/CSFI/glc2017/30-2testpoint.xlsx")
  
    # Ecc; test point location in visual angle 
    Ecc = np.sqrt(tp.x[testpoint_n]**2 + tp.y[testpoint_n]**2) 
    
    RGC_count = 10**(0.1*(dB-1-(-1.5*1.34*Ecc-14.8))/(0.054*1.34*Ecc+0.9))*2.95;
    return RGC_count


def RGC_HFA10_count(dB, testpoint_n ):
    tp = pd.read_excel("~/Google Drive/CSFI/glc2017/10-2testpoint_displacement.xlsx")
    Ecc = np.sqrt(tp.x[testpoint_n]**2 + tp.y[testpoint_n]**2)
    
    RGC_count = 10**(0.1*(dB-1-(-1.5*1.34*Ecc-14.8))/(0.054*1.34*Ecc+0.9))*2.95/9;
    return RGC_count

#RGC_displ_P1 = RGC_HFA10_count(df.P1, 0)
for ii in range(0, 68):
    df['RGC_disp'+'_P'+str(ii+1)] = RGC_HFA10_count(df['P'+str(ii+1)], ii)

df.to_excel('df_20170826.xlsx')


df = pd.read_excel('/Users/shumpei/Google Drive/CSFI/glc2017/\
df_20170826.xlsx')

df['RGC_OCT135'] = df.RGC_OCT*135/360
df.to_excel('df_20170901.xlsx')


  

'''
normal subjects
'''

DF = pd.read_excel('Normal_CSFI10-2data-2.xlsx')

# calcurate quadrant RGC from cpRNFLT
DF['RGC_QUADRANT_I'] = get_RGC_OCT_count(DF.QUADRANT_I, 90, DF.age, DF.MD10_2)
DF['RGC_QUADRANT_N'] = get_RGC_OCT_count(DF.QUADRANT_N, 90, DF.age, DF.MD10_2)
DF['RGC_QUADRANT_S'] = get_RGC_OCT_count(DF.QUADRANT_S, 90, DF.age, DF.MD10_2)
DF['RGC_QUADRANT_T'] = get_RGC_OCT_count(DF.QUADRANT_T, 90, DF.age, DF.MD10_2)

## Clock hour RGC_c
for ii in range(0,12):
    DF['RGC_CH'+str(ii+1)] = get_RGC_OCT_count(DF['CLOCKHOUR_'+str(ii+1)],\
      360/12, DF.age, DF.MD10_2)

# RGC_OCT2
DF['RGC_OCT2'] = DF.RGC_OCT/2

  
#RGC_displ_P1 = RGC_HFA10_count(df.P1, 0)
for ii in range(0, 68):
    DF['RGC_disp'+'_P'+str(ii+1)] = RGC_HFA10_count(DF['P'+str(ii+1)], ii)

DF.to_excel('norm_20170826.xlsx')
DF = pd.read_excel('norm_20170826.xlsx')


DF['RGC_OCT135'] = DF.RGC_OCT*135/360

DF.to_excel('norm_20170901.xlsx')


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
