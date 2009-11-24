#!/usr/bin/stackless
from optparse import OptionParser 
from math import sqrt, pi


def main():


    fo = r/(2*(n-1)) # mm
    print "Equivalent focal length: ", fo
    sigma_n = 1+d/(2*n*fo) # mm
    
    k = 2*pi/wave
    u1 = k*s1**2

    U1 = u1/(2.0*fo)
    Z1 = z1/(2.0*fo)



    # calculations


    Z3 = sigma_n - (1+Z1)/((1+Z1)**2+U1**2)
    z3 = 2*fo*Z3

    s3 = s1*sqrt((sigma_n-Z3)/(1+Z1))

    s3 = s3*10**3
    
    print "s3:  %f    z3: %f" % (s3, z3)

    
if __name__ == "__main__": # when run as a script
# Doubler
    s1 = 57/sqrt(2)*10**-3 # mm
    z1 = -89.7 # mm
    wave = 0.42604885*10**-3 # mm
    n = 1.50980
    r = -150 # mm
    d = 6.35 # mm
    print "Doubler:"
    main()
    # OPO
    wave = 0.8520997*10**-3
    s1 = 45.5*10**-3
    z1 = -58.36
    r = -100
    print "OPO"
    main()
