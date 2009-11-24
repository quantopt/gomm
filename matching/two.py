#!/usr/bin/python

from utils import *
from itertools import *
from pylab import *
from lensbank import LensBank
from math import pi, sqrt, fabs 
from optparse import OptionParser
from plots import ParametricPlot
from pyoptics import BeamInfo


class MidfocusMatching(BeamInfo):

    def __init__(self, w1= None , w2 = None, w3 = None, f1=None, f2=None, L=None, L1=None, L2 = None, L3=None, L4 = None, d1 = None, d2=None, wavelength=0.85209):
        super(MidfocusMatching, self).__init__(wavelength)
        initFromArgs(self)
        try:
            self.z1, self.z3 = self.z(w1), self.z(w3)
        except TypeError:
            pass
        self.LA = self.LB = self.wa = self.wb = self.solutions = self.steps = None
        

    def set_steps(self, size=1):
        self.steps = arange(0, self.L+1, size)
    
    def calculate_forward_param(self):
        self.LA, self.wa = self.generate(self.w1, self.f1, self.steps)    
    
    def calculate_back_param(self):
        LB, self.wb = self.generate(self.w3, self.f2, self.steps)
        self.LB = [self.L+10 - i for i in LB]
        

    def generate(self, w, f, steps, z=None):
        z = z or self.z(w)
        L = [self.calculate_L(w, f, Li, z)+Li for Li in steps]
        wo = [self.calculate_waist(w, f, Li, z) for Li in steps]
        return (L, wo)        
                                     
    def calculate_L(self, w, f, L, z=None):
        return float((L-f)*f**2)/((L-f)**2+z**2)+f

    def calculate_waist(self, w, f, L, z=None):
        return float(w*fabs(f))/sqrt((L-f)**2+z**2)
        


   
class ForwardWaist(MidfocusMatching):
    def __init__(self, waist, f1, L1):
        MidfocusMatching.__init__(self)
        initFromArgs(self)        
        self.calculate_forward()


    def calculate_forward(self):
        L2, waist = self.generate(self.waist, self.f1, [self.L1])
        self.waist = waist[0]
        self.L2 = L2[0]
        return (self.L2, self.waist)

    def __repr__(self):
        return "Waist position is at %s and has is %s um" % (self.L2, self.waist)
    
class BackwardWaist(MidfocusMatching):
    def __init__(self, waist, f, L2):
        MidfocusMatching.__init__(self)
        initFromArgs(self)
        self.calculate_back()
        
    
    def calculate_back(self):
        L1, waist = self.generate(self.waist, self.f, [self.L2])
        self.waist = waist[0]
        self.L1 = L1[0]
        return (self.L1, self.waist)
    
    def __repr__(self):
        return "Waist position is at %s and has is %s um" % (self.L1, self.waist)


class TwoLensWithLength(MidfocusMatching):
    def __init__(self, w1=None, w3=None, f1=None, f2=None, L=None, wavelength=0.665):
        initFromArgs(self)
        u = MidfocusMatching.__init__(self, w1=400, w3=28.276, f1=f1, f2=f2, L=950.5, wavelength=.85209)

        self.set_steps(10)
        self.calculate_forward_param()
        self.calculate_back_param()
        self.parametric = ParametricPlot(self.LA, self.wa, self.LB, self.wb, self.steps)
        #self.direct_solve()
        self.parametric.show()

    
    
def main():
    m = TwoLensWithLength(f1=options.f1, f2=options.f2, L=options.length)
    
    
if __name__ == "__main__":
    oParser = OptionParser()
    oParser.add_option("--f1", type="float", dest="f1", help="focal length of first lens mm")
    oParser.add_option("--f2", type="float", dest="f2",  help="focal length of second lens mm")
    oParser.add_option("-l", type="float", dest="length",  help="focal length of second lens mm")
    (options, args) = oParser.parse_args()

    main()


