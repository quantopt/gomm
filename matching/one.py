#!/usr/bin/env python

from math import pi, sqrt, fabs 
from optparse import OptionParser
from pyoptics import BeamInfo
from utils import *



class Matching(BeamInfo):

    def __init__(self, w1= None , w2 = None, L=None, d1 = None, d2=None, f=None, wavelength=0.85209):
        initFromArgs(self)
        BeamInfo.__init__(self, wavelength)
        print "Matching wavelength is %8.2f nm" % m2u(self.wavelength)
        try:
            self.f0 = self.f_lower_bound()
            print "Minimum focal length for this matching: %8.2f mm" % self.f0
        except TypeError:
            pass
        
       
        
    def f_lower_bound(self):
        """Calculates lower bound of matching focal length, f0,
        and stores the result in millimeters to self.f0

        w1, w2 provided in um
        """
        f0 = pi*self.w1*self.w2/self.wavelength
        return u2m(f0)    

    def calculate_focal_length(self):
        """Calculates the focal length necessary to do a single lens  matching
        by using the distances d1 and d2 to waists w1 and w2.  Result is stored
        to self.focal in millimeters"""

        self.f = 1/(self.__R_inverse(self.w1, self.d1) + self.__R_inverse(self.w2, self.d2))
        
    def __R_inverse(self, waist, distance):
        """Calculates 1/R for a given distance from a given waist.
        Waist is input in um, Distance input in mm.   Result is returned in 1/mm"""
    
        return distance/(self.z(waist)**2+distance**2)

    def calculate_distances(self):
        """Calculates the distance from the first waist to the lens position
        necessary for single lens matching.  User specifies the waist sizes
        and the total contrained distance between the waists.  Assumes
        that object data contains
        w1, w2, L, and wavelength in um"""

        self.L = m2u(self.L)
        if fabs(self.w1/self.w2-1) < 0.5:
            print "Using distance approximation"
            self.d1 = self.__distance_calc_approximation(self.w1, self.w2)
            self.d2 = self.__distance_calc_approximation(self.w2, self.w1)
        else:
            print "Using exact distance calc"
            self.d1 = self.__distance_calc_exact(self.w1, self.w2)
            self.d2 = self.__distance_calc_exact(self.w2, self.w1)
        self.L = u2m(self.L)
        self.d1 = u2m(self.d1)
        self.d2 = u2m(self.d2)
        
    def __distance_calc_exact(self, a,b):
        """Calculates the exact distance from waists to lens position,
        for two given waists, and a distance fixed by self.L
        when the waists are largely different in size.
        w1, w2 input in um, distance output in mm"""

        return (a**2*self.L-self.__distance_exact_radical())/(a**2-b**2)
    
    def __distance_exact_radical(self):
        return self.w1*self.w2*sqrt(self.L**2+(pi**2)*((self.w1**2-self.w2**2)**2)/self.wavelength)

    def __distance_calc_approximation(self,a,b):
        """Calculates the approximate distance from waists to lens position,
        for two given waists, and a distance fixed by self.L
        when the waists are approximately the same size.
        w1, w2 input in um, distance output in mm"""
        
        return (self.L/2)*(1-(a-b)*self.__distance_approx_radical())

    def __distance_approx_radical(self):
        """ Input in um,  output in 1/um"""
        return (1/(self.w1+self.w2))*(4*((self.f0**2)/(self.L**2))-1)


    def calculate_length(self):
        """Calculates the length necessary to match waists w1 to w2
        when provided with a lens of focal length f"""
        self.d1 = self.f+(self.w1/self.w2)*sqrt(self.f**2-self.f0**2)
        self.d2 = self.f+(self.w2/self.w1)*sqrt(self.f**2-self.f0**2)
        self.L = self.d1+self.d2

    def calculate_image(self):
        self.d2 = self.f*(1+(self.d1/self.f-1)/((self.d1/self.f-1)**2+(self.z(self.w1)/self.f)**2))
        self.w2 = self.w1/sqrt((1-self.d1/self.f)**2+(self.z(self.w1)/self.f)**2)
        
class WaistToWaistWithLength(Matching):
    """ Calculates the focal length needed to match a waist w1 to a waist w2
    using only a single lens.  The waists are seperated by the specified
    length L"""
     
    def __init__(self, w1, w2, L, wavelength=0.85209):
        Matching.__init__(self, w1=w1, w2=w2, L=L, wavelength=wavelength)
        
        self.calculate_distances()
        self.calculate_focal_length()
        assert round(self.d1+self.d2) == round(self.L), 'length calculation error'
        
    def __repr__(self):
        return "To match w1: %0.2f um to w2: %0.2f um \n    \
        place a lens of f=%0.6f mm at a distance of  %0.4f mm from w1 \
        and %0.4f mm from w2" % (self.w1, self.w2, self.f, self.d1, self.d2)

class WaistToWaistWithLens(Matching):
    """Calculates the length necessary to match a waist w1 to w2 position and size of a waist produced for a given
    waist and lens combination"""

    def __init__(self, w1, w2, f, wavelength=0.85209):
        Matching.__init__(self, w1=w1, f=f, w2=w2, wavelength=wavelength)

        self.calculate_length()
        print "Total length: %8.2f mm" % self.L
        
    def __repr__(self):
        return """A lens of focal length %0.2f at distance of %0.2f from a waist of %0.2f um
        produces a waist of %0.2f um and a distance of %0.2f mm from the lens""" % (self.f, self.d1, self.w1, self.w2, self.d2)

        
class WaistFromWaistLensAndD1(Matching):
    """Calcuates the size of the waist w2 produced from a lens of focal length f,
    placed at a distance d1 from a waist w1.  Also returns the distance d2 of
    this new waist"""

    def __init__(self, w1, d1, f, wavelength=0.85209):
        Matching.__init__(self, w1=w1, f=f, d1=d1, wavelength=wavelength)
        self.calculate_image()
        
    def __repr__(self):
        return """A lens of focal length %8.2f at distance of %8.2f from a waist of %0.2f um
        produces a waist of %8.2f um and a distance of %8.2f mm from the lens
        for a total length of %6.2f mm""" % (self.f, self.d1, self.w1, self.w2, self.d2, self.d1+self.d2)

    
def main():
    
    w1 = options.w1
    w2 = options.w2
    d1 = options.d1
    L = options.length
    f = options.focal
    wavelength = u2m(options.wavelength)
    print wavelength
    if (w1 and w2 and L):
        print WaistToWaistWithLength(w1=w1, w2=w2, L=L, wavelength=wavelength)
    elif (w1 and w2 and f):
        print WaistToWaistWithLens(w1=w1, w2=w2, f=f, wavelength=wavelength)
    elif (w1 and d1 and f):
        print WaistFromWaistLensAndD1(w1=w1, d1=d1, f=f, wavelength=wavelength)



if __name__ == "__main__":
    oParser = OptionParser()
    oParser.add_option('-f', '--focal', type='float', help='focal length of specified lens in mm')
    oParser.add_option('-a', '--w1', type='float', help='size of waist 1 in um')
    oParser.add_option('-b', '--w2', type='float', help='size of waist 2 in um')
    oParser.add_option('-d', '--d1', type='float', help='distance of lens from waist 1 in mm')
    oParser.add_option('-l', '--length', type='float', help='optical path length in mm')
    oParser.add_option('-w', '--wavelength', type='float', default='852.09', help='beam wavelength in nm')
    (options, args) = oParser.parse_args()


    main()


