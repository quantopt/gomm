#!/usr/bin/python
"""thin lens imaging module.  Doesn't actually do anything"""


from math import pi, sqrt, fabs 
from optparse import OptionParser
from gomm.utils.pyoptics import BeamInfo
from gomm.utils import *
#from pylabs import *


BK7=1.50980
AIR=1




# if BiConvex:
#     p = ((d-d1)**2+d0**2)/(4*(d-d1))
# elif BiConcave:
#     p = ((d2-d)**2+d0**2)/(4*(d2-d))
# elif PlanoConvex:
#     p = (4*(d-d3)**2+d0**2)/(8*(d-d3))
# elif PlanoConcave:
#     p = (4*(d4-d)**2+d0**2)/(8*(d4-d))
# f0 = p/(2*(n-1))

class Image(BeamInfo):
    """Calculates the position of the image waist when provided with the
    object waist position so in mm, the focal length in mm, wavelength in um,
    and object waist size in um"""
    
    def __init__(self, d=1, s1 = None, z1=None, f = None, r=None, n=BK7, n_medium=AIR, wavelength = 0.85209, lens_shape='biconvex'):

        BeamInfo.__init__(self, wavelength)
        print "Imaging wavelength is %8.2f nm" % m2u(self.wavelength)
        self.z1 = z1
        self.s1 = u2m(s1)
        self.n = n    
        self.fo = r/(2*(n-1)) # mm

        self.f_n = -self.fo/(1+d/(4*n*self.fo))
        self.f_p = self.fo/(1-d/(4*n*self.fo))

        self.sigma_n = 1+d/(2*n*self.fo) # mm
        self.sigma_p = 1-d/(2*n*self.fo) # mm

        self.tau_p = 2*self.sigma_p/(self.sigma_p+1)
        self.tau_n = 2*self.sigma_n/(self.sigma_n+1)

        self.nu_p = (2/(self.sigma_p+1))**2
        self.nu_n = (2/(self.sigma_n+1))**2
        
        self.k = 2*pi/wavelength
        self.u1 = n_medium*self.k*s1**2
        if lens_shape in ['biconcave', 'biconvex']:
            self.U1 = self.u1/self.fo
            self.Z1 = z1/self.fo
        else:
            self.U1 = self.u1/(2*self.fo)
            self.Z1 = z1/(2*self.fo)


        if lens_shape == 'biconvex':    # lens (i)
            self.Z3 = self.nu_p*(self.tau_p - self.Z1)/((self.tau_p - self.Z1)**2 + self.U1**2) - self.tau_p
            self.m_squared = (self.tau_p + self.Z3)/(self.tau_p - self.Z1)
        elif lens_shape == 'biconcave': # lens (ii)
            self.Z3 = self.tau_n - self.nu_n*(self.tau_n + self.Z1)/((self.tau_n + self.Z1)**2 + self.U1**2)
            self.m_squared = (self.tau_n - self.Z3)/(self.tau_n + self.Z1)
        elif lens_shape == 'plano_convex_neg':  # lens (iii)
            self.Z3 = (self.sigma_p - self.Z1)/((self.sigma_p - self.Z1)**2 + self.U1**2) - 1
            self.m_squared = (1 + self.Z3)/(self.sigma_p - self.Z1)
        elif lens_shape == 'plano_concave_pos': # lens (iv)
            self.Z3 = 1 - (self.sigma_n + self.Z1)/((self.sigma_n + self.Z1)**2 + self.U1**2)
            self.m_squared = (1 - self.Z3)/(self.sigma_n + self.Z1)
        elif lens_shape == 'plano_convex_pos':  # lens (v)
            self.Z3 = (1 - self.Z1)/((1 - self.Z1)**2 + self.U1**2) - self.sigma_p
            self.m_squared = (self.sigma_p + self.Z3)/(1 - self.Z1)
        elif lens_shape == 'plano_concave_neg': # lens (vi)
            self.Z3 = self.sigma_n - (1 + self.Z1)/((1 + self.Z1)**2 + self.U1**2) - self.sigma_p
            self.m_squared = (self.sigma_n - self.Z3)/(1 + self.Z1)

        
        if lens_shape in ['biconcave', 'biconvex']:
            self.z3 = self.Z3*self.fo
        else:
            self.z3 = self.Z3*self.fo*2

        self.s3 = self.s1*sqrt(self.m_squared)
        

    def __repr__(self):
        return """
        The object waist of %8.2f um is located at %8.2f mm    
        The image waist of %8.2f um is located at %8.2f mm"""  % (self.s1, self.z1, self.s3, self.z3)
    
def main():
    so = options.object
    si = options.image
    f = options.focal
    r = options.radius
    print "Focal is ", f 
    wavelength = u2m(options.wavelength)
    wo = options.waist
    wi = options.image_waist
    print "So: ", so
    if (so and wo and (f or r)):
        print Image(z1=so, s1=wo, r=r, wavelength=wavelength)


if __name__ == "__main__": # when run as a script
    oParser = OptionParser()
    oParser.add_option('-o', '--object', type='float', help='object distance from lens in mm')
    oParser.add_option('-i', '--image', type='float', help='image distance from lens in mm')
    oParser.add_option('-f', '--focal', type='float', help='focal length of lens in mm')
    oParser.add_option('-r', '--radius', type='float', help='radius of curvature of mirror in mm')
    oParser.add_option('-w', '--wavelength', type='float', default='0.85209',help='wavelength of beam in um')
    oParser.add_option('-u', '--waist', type='float', help='size of object waist in um')
    oParser.add_option('-v', '--image-waist', type='float', help='size of image waist in um')
    
    (options, args) = oParser.parse_args()
    main()
