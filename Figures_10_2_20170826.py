#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Sat Aug 26 12:11:32 2017

@author: shumpei
"""


import os
import numpy as np
import pandas as pd
#import seaborn as sb
import xlrd
import matplotlib.pyplot as plt

df = pd.read_excel('df_20170826.xlsx')
norm = pd.read_excel('norm_20170826.xlsx')


Corr = df.corr()
cor_norm = norm.corr()

toukei =  df.describe()


'''
plot figures
'''



# plot RGC_HFA10-2 vs RGC_OCT
fig = plt.figure()
plt.plot(df.RGC_HFA9,df.RGC_OCT,'.')
plt.title('RGC_HFA10-2 vs RGC_OCT')
plt.plot(range(0,1400000),range(0,1400000),'-b')
plt.xlabel('RGC_HFA10-2')
plt.ylabel('RGC_OCT')
plt.axis('square')
#
#fig.set_dpi(300)
##fig.savefig('RGC_HFA10-2vsRGC_OCT.png')
#fig.savefig('RGC_HFA10-2vsRGC_OCT.png', dpi=300, orientation='portrait', \
#            transparent=False, pad_inches=0.0)
##plt.savefig('RGC_HFA10-2vsRGC_OCT.pdf', orientation='portrait', transparent=False, bbox_inches=None, frameon=None)

# plot RGC_HFA10-2 vs RGC_OCT2 180degree
fig = plt.figure()
plt.plot(df.RGC_HFA9, df.RGC_OCT2,'.r')
plt.plot(range(0,1400000),range(0,1400000),'-b')

plt.title('RGC_HFA10-2 vs RGC_OCT2')
plt.xlabel('RGC_HFA10-2')
plt.ylabel('RGC_OCT')
plt.axis('square')
#
#fig.set_dpi(300)
##fig.savefig('RGC_HFA10-2vsRGC_OCT.png')
#fig.savefig('RGC_HFA10-2vsRGC_OCT2.png', dpi=300, orientation='portrait', \
#            transparent=False, pad_inches=0.0)
#==============================================================================
# 
#==============================================================================

fig = plt.figure()
plt.plot(df.RGC_disp, df.RGC_HFA9,'.')
plt.title('RGC_disp vs RGC_HFA')
plt.xlabel('RGC_disp')
plt.ylabel('RGC_10-2')
plt.axis('square')




# compare HFA_OCT360 with OCT180
fig = plt.figure()
plt.plot(df.RGC_disp, df.RGC_OCT,'.b')
plt.plot(df.RGC_disp, df.RGC_OCT2,'.r')
plt.xlabel('RGC_HFA_displacement')
plt.ylabel('RGC_OCT')
plt.axis('square')


'''
'''
fig = plt.figure()
#plt.plot(df.RGC_disp, df.RGC_OCT,'.b')
plt.plot(df.RGC_disp, df.RGC_OCT2,'.r')
plt.xlabel('RGC_HFA_displacement')
plt.ylabel('RGC_OCT2')
plt.axis('square')


'''
'''
fig = plt.figure()
plt.plot(df.RGC_HFA9, df.RGC_OCT2,'.b')
plt.plot(df.RGC_disp, df.RGC_OCT2,'.r')
plt.xlabel('RGC_HFA_displacement')
plt.ylabel('RGC_OCT2')
plt.axis('square')
plt.legend(['convensional','displaced'])

fig.set_dpi(300)
#fig.savefig('RGC_HFA10-2vsRGC_OCT.png')
fig.savefig('RGC_dispvsConvensional.png', dpi=300, orientation='portrait', \
            transparent=False, pad_inches=0.0)




# compare HFA_OCT360 with OCT180
fig = plt.figure()
plt.plot(df.RGC_HFA9, df.RGC_OCT,'.b')
plt.plot(df.RGC_HFA9, df.RGC_OCT2,'.r')

#plt.plot(df.RGC_HFA9, df.)
plt.title('RGC_HFA10-2 vs RGC_OCT')
plt.xlabel('RGC_HFA10-2')
plt.ylabel('RGC_OCT')
plt.axis('square')
plt.legend(['360','180'])

fig.set_dpi(300)
#fig.savefig('RGC_HFA10-2vsRGC_OCT.png')
fig.savefig('RGC_HFA10-2vsRGC_OCT3.png', dpi=300, orientation='portrait', \
            transparent=False, pad_inches=0.0)


# RGC_HFA9 vs HFA_displacement
fig = plt.figure()
ax1 = plt.plot(df.RGC_HFA9, Sum,'.b')
plt.title('convensional vs displaced')
plt.xlabel('con')
plt.ylabel('disp')
plt.axis('square')
#plt.legend(['360','180'])

"""
normal
"""

norm = pd.read_excel('norm_20170826.xlsx')

