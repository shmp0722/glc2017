#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Sun Aug 13 08:18:18 2017

@author: shumpei
"""

import os
import xlrd
import numpy as np
import pandas as pd


book = xlrd.open_workbook('/Users/shumpei/Google Drive/CSFI/glc2017/Test_recalc.xlsx',header=NONE)
print book.nsheets

dB = pd.read_excel('/Users/shumpei/Google Drive/CSFI/glc2017/Test_recalc.xlsx',sheetname='10-2',header=NONE)


books = ['book1.xlsx', 'book2.xlsx']
df_list = []

for book in books:
    file = pd.ExcelFile(book) # bookを読む
    for sheet in file.sheet_names:
        df_list.append(file.parse(sheet)) # シートを順々にデータフレーム化