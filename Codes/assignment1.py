#2019.09.08
#画指数分布和伽马分布

import numpy as np
import matplotlib.pyplot as plt
from scipy import stats as st

#Exponential Distributions
#Densities 
lambd1 = 0.5
lambd2 = 1
lambd3 = 2

x = np.arange(0,15,0.1)
y1 = lambd1*np.exp(-lambd1*x)
y2 = lambd2*np.exp(-lambd2*x)
y3 = lambd1*np.exp(-lambd3*x)

plt.figure(0)
plt.plot(x,y1,color='red')
plt.plot(x,y2,color='black')
plt.plot(x,y3,color='blue')
plt.show()

#DensitiesSemilog
y1 = np.log10(lambd1*np.exp(-lambd1*x))
y2 = np.log10(lambd2*np.exp(-lambd2*x))
y3 = np.log10(lambd1*np.exp(-lambd3*x)) 

plt.figure(1)
plt.plot(x,y1,color='red')
plt.plot(x,y2,color='black')
plt.plot(x,y3,color='blue')
plt.show()

#Gamma Distributions
#Densities
x=np.arange(0,6,0.1)
z1 = st.gamma.pdf(x,1,scale=1)
z2 = st.gamma.pdf(x,3,scale=1/3)
z3 = st.gamma.pdf(x,8,scale=1/8)

plt.figure(2)
plt.plot(x,z1,color='red')
plt.plot(x,z2,color='black')
plt.plot(x,z3,color='blue')
plt.show()

#DensitiesSemilog
z1 = np.log10(st.gamma.pdf(x,1,scale=1))
z2 = np.log10(st.gamma.pdf(x,3,scale=1/3))
z3 = np.log10(st.gamma.pdf(x,8,scale=1/8))

plt.figure(3)
plt.plot(x,z1,color='red')
plt.plot(x,z2,color='black')
plt.plot(x,z3,color='blue')
plt.show()

