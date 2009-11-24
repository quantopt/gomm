#!/usr/bin/python
from optparse import OptionParser 

BK7 = 1.50980
D_typ = 6.35



def eflr(d=D_typ, r1=float('inf'), r2=float('inf'), n=BK7):
    """Returns the effective focal length as a function of the radii of
    curvature r1 and r2, the separation between principal planes d,
    and the index of refraction n
    >>>eflr(100
    """

    try:
        return 1./((n-1)*(1./r1-1./r2+((n-1)*d)/(n*r1*r2)))
    except ZeroDivisionError:
        return float('inf')

def ffl(f, r2, d=D_typ, n=BK7):
    """Returns the front focal distance - the focal length from the front
    principle plane of a thick optic. You provide the index of refraction
    n, the effective focal  length f, the radius of curvature of r2, and
    the seperation distance between principle planes d.

    >>> ffl()
    """

    return f*(1+(n-1)*d/(n*r2))

def bfl(f, r1, d=D_typ, n=BK7):
    """Returns the back focal distance - the focal length from the second
    principle plane of a thick optic. You provide the index of refraction
    n, the effective focal  length f, the radius of curvature of r1, and
    the seperation distance between principle planes d.

    >>> ffl()
    """

    return f*(1-(n-1)*d/(n*r2))
    


def main(f1, f2, d):
    print "The effective focal length is %6.2f mm" % efl(f1, f2, d)

if __name__ == "__main__": # when run as a script
    oParser = OptionParser() 
    
    oParser.add_option('-a', '--f1', type='float', help='focal length of lens one')
    oParser.add_option('-b', '--f2', type='float', help='focal length of lens two')
    oParser.add_option('-d', '--distance', type='float', help='separation distance between lens one and two')
    (options, args) = oParser.parse_args()
    
    main(options.f1, options.f2, options.distance)
