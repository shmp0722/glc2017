#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Sun Aug 20 22:35:08 2017

@author: shumpei
"""

from scipy.stats import norm, shapiro, kstest, anderson
import bokeh.plotting as bplt
from bokeh import layouts
from bkcharts import Histogram, Scatter
from bokeh.models import Span
import pandas as pd
import numpy as np
 
 
def vertical_histogram(y):
    vhist, vedges = np.histogram(y, bins=20)
    vzeros = np.zeros(len(vedges)-1)
    vmax = max(vhist)*1.1
     
    pv = bplt.figure(toolbar_location=None, plot_width=200, plot_height=400, x_range=(0, vmax),
                     min_border=10, y_axis_location="right")
    pv.ygrid.grid_line_color = None
    pv.xaxis.major_label_orientation = np.pi/4
    pv.background_fill_color = "#fafafa"
     
    # Plot histogram
    pv.quad(left=0, bottom=vedges[:-1], top=vedges[1:], right=vhist, color="white", line_color="#3A5785")
     
    # Normal fit
    mu, sigma = norm.fit(y)
    xp = np.linspace(y.min(), y.max(), 100)
    pdf = norm.pdf(xp, mu, sigma)
    pdf = (vhist.max()-1)*pdf/pdf.max()    
     
    # Plot pdf of fit
    pv.line(pdf, xp, line_color="#D95B43", line_width=8, alpha=0.7)
     
    return pv
 
 
def bland_altman(df, s1, s2, color=None, marker=None, log_transform=True):
    df = df.copy().dropna()
    if log_transform:
        df[s1] = np.log2(df[s1])
        df[s2] = np.log2(df[s2])
     
    # Calc average and difference
    df = df.assign(x=(df[s1] + df[s2])/2, y=df[s1] - df[s2])
     
    # Test for normality
    print('Shapiro Wilk\n  stats: {}, p: {}'.format(*shapiro(df['y'].values)))
    print('Kolmogorov-Smirnov\n  stats: {}, p: {}'.format(*kstest(df['y'].values, 'norm')))
    print('Anderson-Darling\n  stats: {}, critical_values: {}'.format(*anderson(df['y'].values, 'norm')))
 
    # Make plots
    p = Scatter(df, x='x', y='y', color=color, marker=marker, title='Bland-Altman', 
                plot_width=700, plot_height=400, toolbar_location="above")
     
    mean_y = Span(location=df['y'].mean(), 
                  dimension='width', line_color='green', 
                  line_dash='dashed', line_width=3)
     
    std_y_upper = Span(location=df['y'].mean() + df['y'].std() * 1.96, 
                       dimension='width', line_color='red', 
                       line_dash='dashed', line_width=3)
     
    std_y_lower = Span(location=df['y'].mean() - df['y'].std() * 1.96, 
                       dimension='width', line_color='red', 
                       line_dash='dashed', line_width=3)
 
    p.add_layout(mean_y)
    p.add_layout(std_y_upper)
    p.add_layout(std_y_lower)
 
    p.xaxis.axis_label = 'Average'
    p.yaxis.axis_label = 'Difference ({} - {})'.format(s1, s2)
    p.legend.location = 'top_left'
     
    # Create histogram and norm fit
    pv = vertical_histogram(df['y'])
    p = layouts.Row(p, pv)
    return p