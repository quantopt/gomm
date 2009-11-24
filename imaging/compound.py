#!/usr/bin/python
from optparse import OptionParser 
"""Handles thin compount lenses"""
 

def effective_focal_length_config(f, f1, f2):
    """Returns the spacing d between the lens principal planes which is required
    in order to produce a compound lens of the effective focal length f
    >>>efl_config(100, 200, 250)

    """

    return f1+f2-(f1*f2)/float(f)

class CompoundLens(object):
    def __init__(self, f1='inf', f2='inf', d='inf'):
        self.f1 = float(f1)
        self.f2 = float(f2)
        self.d = float(d)
        self.f = self.effective_focal_length(self.f1, self.f2, self.d)
        self.s2 = self.focal_point_location(self.f1, self.f2, self.d)
        self.z = self.secondary_principal_point_location()


    def effective_focal_length(self, f1, f2, d):
        """Returns the effective focal length of two thin lenses.  You specify
        the lens focal lengths in f1 and f2, and the distance between the second
        principal plane of lens one, and the first principle plane of lens two.
        this function returns to you the effective focal length of this combination

        >>>efl(100,100,200)
        inf
        """
        try:
            return (f1*f2)/(f1+f2-d)
        except ZeroDivisionError:
            return float("inf")

    def focal_point_location(self, f1, f2, d):
        """Returns the focal point location for the combined system as measured
        from the secondary principal point of the second lens"""

        return f2*(f1-d)/(f1+f2-d)

    def secondary_principal_point_location(self):
        """Returns the combination's secondary principal point location.  This
        tells us how far the secondary principle point for the second element
        has moved due to being a part of the combination"""
        return self.s2 - self.f


if __name__ == "__main__": # when run as a script
    oParser = OptionParser()

    
    (options, args) = oParser.parse_args()
    
