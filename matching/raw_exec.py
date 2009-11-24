#!/usr/bin/python
from numpy import arange
from optparse import OptionParser
from optics import *
import tforms
from transforms import *

def one_with_focal(): pass
 

def direct_solve(wavelength, w1, w2, f1, f2, L, step, tolerance, error):
    b = BeamInfo(wavelength)
    q1 = b.q_0(w1)
    w_target = w2
    q_target = b.q_0(w_target)
    for L1 in arange(0,L, step):
        for L3 in arange(L1, L, step):
            L2 = L-L1-L3
            #q2 = raw_two_lens(L1, L2, L3, f1, f2, q1)
	    q2 = tforms.transforms.two_lens(L1, L2, L3, f1, f2, q1)
            if eq(q2.imag, q_target.imag, tolerance):
                if ((fabs(q2.real) < error)):
		    print q2
                    print "L1: %s mm    L2: %s mm     L4: %s mm    waist:%9.5f um   q.real: %0.4f   q.imag: %0.6f um" % (L1, L2, L3, b.w_q(q2), q2.real, q2.imag)

if __name__ == "__main__":
    oParser = OptionParser()
    oParser.add_option("-w", "--wavelength", type="float", default="0.852", help="Wavelength of beam")
    oParser.add_option("--w1",type="float", dest="w1", help="size of first waist in um")
    oParser.add_option("--w2", type="float", dest="w2", help="size of second waist in um")
    oParser.add_option("--f1",type="float", dest="f1", help="focal length of first lens mm")
    oParser.add_option("--f2",type="float", dest="f2",  help="focal length of second lens mm")
    oParser.add_option("-t", "--tolerance", type="float", default=1, help="tolerance limit for equality value")
    oParser.add_option("-s", "--step",  type="float", default=1, help="step size for solutions")
    oParser.add_option("-l", "--length", type="float", help="distance between w1 and w2")
    oParser.add_option("-e", "--error", type="float", default=1, help="maximum size on 1/R")
    (options, args) =  oParser.parse_args()
    wavelength = 0.85209# options.wavelength
    tolerance, error = 5, 1 #options.tolerance, options.error
    step, L = 1, 464# options.step, options.length
    f1, f2 = 35, 75 #options.f1, options.f2
    w1, w2 = 400, 28.272#options.w1, options.w2
    direct_solve(wavelength, w1, w2, f1, f2, L,  step, tolerance, error)
