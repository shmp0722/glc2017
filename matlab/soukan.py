# coding: utf-8

# In[1]:

import numpy as np
import pandas as pd
import scipy as sp


# In[2]:

df  = pd.read_csv('T2.txt')


# In[3]:

df


# In[4]:

df.shape


# In[8]:

correlation_matrix = np.corrcoef(df)


# In[20]:

correlation_matrix


# In[17]:

from matplotlib import pyplot as plt
import seaborn as sns
from sklearn import datasets
get_ipython().magic(u'matplotlib inline')


# In[ ]:

# get all headers
hd =  df.columns.values


# In[ ]:

# 相関行列のヒートマップを描く
sns.heatmap(correlation_matrix, annot=True, xticklabels=hd, yticklabels=hd)
plt.show()


# In[ ]:

# 相関行列のヒートマップを描く
sns.heatmap(correlation_matrix)
plt.show()


# In[ ]:



