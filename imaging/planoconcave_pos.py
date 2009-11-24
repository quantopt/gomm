#!/usr/bin/stackless
from optparse import OptionParser 
from math import sqrt, pi


def image():


    fo = r/(2*(n-1)) # mm
    sigma_n = 1+d/(2*n*fo) # mm
    
    k = 2*pi/wave
    u1 = k*s1**2

    U1 = u1/(2.0*fo)
    Z1 = z1/(2.0*fo)



    # calculations


    Z3 = 1-(sigma_n+Z1)/((sigma_n+Z1)**2+U1**2)
    z3 = 2*fo*Z3

    s3 = s1*sqrt((1-Z3)/(sigma_n+Z1))

    s3 = s3*10**3
    print "Image from Object"
    print "s3:  %f    z3: %f" % (s3, z3)


#def object():
#    fo = r/(2*(n-1)) # mm
#    sigma_n = 1+d/(2*n*fo) # mm
    
#    k = 2*pi/wave
#    u1 = k*s1**2

#    U1 = u1/(2.0*fo)
#    Z1 = z1/(2.0*fo)



#    Z3 = z3/(2*fo)
#    Z1 = -1./(2*(Z3-1))+sqrt(1./(4*(Z3-1)**2)-U1**2
#    print "Object from Image:"
#    print "s1:  %f    z1: %f" % (s1, z1)

    
if __name__ == "__main__": # when run as a script
    s1 = 201*10**-3 # mm
    z1 = 209.2 # mm
    z3 = 0
    wave = 0.85209885*10**-3 # mm
    n = 1.50980
    r = 100 # mm
    d = 6.35 # mm
    image()
