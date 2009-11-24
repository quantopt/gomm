#!/usr/bin/python


from utils import *
from scipy import *
from math import pi, sqrt

class BeamInfo(object):
    def __init__(self, wavelength=0.85209):
        initFromArgs(self)

    def z(self, waist):
        """Calculates the Rayleigh range for given waist.
        Waist is input in um, result is returned in mm

        >>> b=BeamInfo()
        >>> round(b.z(300))
        332.0
        """
        waist = u2m(waist)
        wavelength = u2m(self.wavelength)
        return (pi*waist**2)/wavelength

    def waist_z(self, z):
        """Returns w0 waist associated witha given Rayleigh range zr  

        >>> b = BeamInfo()
        >>> round(b.waist_z(500))
        368.0
        """
        
        return sqrt(m2u(z)*self.wavelength/pi)
    
    def w_z(self, w, z):
        """Returns w(z) (spot size radius) at a give distance 'z' from waist
        >>> b = BeamInfo()
        >>> round(b.w_z(400, 1000))
        787.0
        """
        
        return w*sqrt(1+(z/self.z(w))**2)
    
    def R_z(self, w0, z):
        """ Returns the radius of curvature R(z) at a distance 'z' from a waist of
        size w0

        >>> b = BeamInfo()
        >>> round(b.R_z(400, 1000), 5)
        1347.99161
        """
        return z*(1+(self.z(w0)/z)**2)
        
    def q_0(self, w0):
        """Returns the complex beam parameter q0 which describes a waist of size w0

        >>> b = BeamInfo()
        >>> b.q_0(400)
        589.908137139j
        """
        
        return complex128(0+self.z(w0)*1j)
    
    def q_z(self, w0, z):
        """Returns the complex beam parameter for a beam at a distance 'z'
        for a waist of size 'w0'

        >>> b = BeamInfo()
        >>> b.q_z(400, 1000)
        (1000+589.908137139j)
        """
        return complex128(z+self.z(w0)*1j)

    

    def w_q(self, q):
        """Returns the waist size w0 for a given complex beam parameter q

        >>> b = BeamInfo()
        >>> q = b.q_z(400, 100)
        >>> round(b.w_q(q))
        400.0
        """
        return self.waist_z(q.imag)


if __name__ == "__main__":
    import doctest, optics
    doctest.testmod(optics)
