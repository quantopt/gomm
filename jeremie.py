#!/usr/bin/python
# Jeremie's mathematica prog
# Use cases:
#    - have w1, dtot, need w2
#   - have w1, w2, need dtot, lenses (comb, position, 1lens, 2 lenses)
#  - 

from scipy import *
from pylab import *

# Definition and values of variables

lambd = 0.852*10**-3
w1 = 600.0*10**-3
w2 = 46.0*10**-3

f1 = 100
f2 = 100


# Intermediate calculations

alpha = w1/w2
f0 = (pi*w1*w1)/lambd

def rr(d1):
    return sqrt((f0**2)*((f2/f1)**2-(1/(alpha**2)))+(((d1-f1)*f2)/(alpha*f1))**2)

def ss(d1):
    return ((f1**2)*rr(d1)+(f2**2)*(d1-f1))/((d1-f1)*rr(d1)+f0**2)

# Calculation of DTot and d as a function of d1

def dtot(d1):
    print rr(d1)
    print ss(d1)
    return d1-f1+rr(d1)+ss(d1)+2*f1+2*f2

def dd(d1):
    return ss(d1)+f1+f2

# Plot graphs
x = arange(0,400,0.1)
#print dtot(x)
print dtot(1)
# Plot[{Dtot[d1], dd[d1]}, {d1, 0, 400}, PlotRange -> {0, 2000}]
plot(x, dtot(x), '.-', x, dd(x), '.-')
xlim(0,400)
ylim(0,2000)

show()

# Result = Solve[Dtot[d1]] == 1221, d1]
# dd[d1 /. Extract[Result, {2}]]
# Dtot[d1 /. Extract[Result, {2}]] - dd[d1/.Extract[Result, {2}]] - d1/.Extract[Result, {2}]]

