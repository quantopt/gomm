#!/usr/bin/stackless

import c2cmod 
from lensbank import LensBank
#import stackless
from utils import *
from numpy import array
from math import *

bank = LensBank('blue.txt')


def solution_tracker(f1, f2, L1, L2, L3):
    pass

        
def callback(f1, f2, L1avg, L2avg, L3avg, w2avg, count):
    
    solutions[(f1, f2)]= array((L1avg, L2avg, L3avg, w2avg, count), dtype = float)
    print "f1: %s    f2: %s   L1:  %6.2f   L2:  %6.2f  L3:  %6.2f   waist:  %6.2f um  ICLen: %6.2f  count:  %s" %  (f1, f2, L1avg, L2avg, L3avg, w2avg, L1avg+L2avg+L3avg, count)


def callback1(f1, L1avg, L2avg, w2avg, count):
    
    solutions[f1]= array((L1avg, L2avg,  w2avg, count), dtype = float)
    print "f1: %s   L1:  %6.2f   L2:  %6.2f  waist:  %6.2f um  ICLen: %6.2f  count:  %s" %  (f1, L1avg, L2avg, w2avg, L1avg+L2avg, count)

def callbackw2c(L1avg, w1avg, w2avg, count):
    #print "L1:  %6.2f   w1: %6.2f um  w2:  %6.2f um   count:  %s" %  (L1avg, w1avg, w2avg, count)
    print "%6.2f %6.2f %6.2f" %  (L1avg, w1avg, w2avg)


w1 = 57/sqrt(2)
w2 = 46/sqrt(2) 

#Putting in -200 here gives the same result as +100 in beam sim....odd..
L = 910  # THE REAL LENGTH!!!  Length of the 2 lens matching portion only
clickclack1_pos = L
clickclack2_pos = 0

r1 = -75
r2 = -200

step = 1
error = 1
# Lower bound for the closest point to put lens 1 to waist 1 - typically 0
lower = 10
# Upper bound for the closest point to put lens 1 to waist 1 - typically 0
upper = 10 #398.6
solutions = {}
L_low = 450
L_high = 800



c2 = -2*100
c1 = -150.0/2

#for f1,f2 in bank.perms:
#     c2cmod.c2cmod.cmc2_solve(w1, w2, f1, f2, L, c1, c2, step, error, callback, lower, upper)
        
#for f1,f2 in bank.perms:
#    print L_low, L_high
#    c2cmod.c2cmod.c2cw_solve(w1, w2, f1, f2, L, r1, step, error, callback, lower, upper)
                             
## blues = [100, 200, 250, 300, 400, 500]
## for f1 in blues:
##     for L in range(L_low, L_high):   
##         c2cmod.c2cmod.c2c1_solve(w1, w2, f1, L, r1, r2, step, error, callback1, lower, upper)


w_low = 50
w_high= 2000
l_high = 2800

r2=100.0
c2cmod.c2cmod.w2c_solve(w2, w_low, w_high, l_high, r2, step, error, callbackw2c)

f2 = 100
#c2cmod.c2cmod.w2c_solve(w2, w_low, w_high, l_high, f2, step, error, callbackw2c)
#
