#!/usr/bin/python

import optics as ds

from lensbank import LensBank
from optparse import OptionParser
from utils import *
from numpy import array



def solution_tracker(f1, f2, L1, L2, L3):
    pass

    
def callback(f1, f2, L1avg, L2avg, L3avg, w2avg, count):
    global nonphysical_solutions 
    solutions[(f1, f2)]= array((L1avg, L2avg, L3avg, w2avg, count), dtype = float)
    position_1 = L1avg
    position_2 = L1avg+L2avg
    lens1_min = 1000
    lens2_min = 1000 #absurdly high init value

    print "f1: %4.0f f2: %4.0f Pos 1: %5.1f  Pos 2: %5.1f (BS: %5.1f)  L3: %5.1f  w2: %6.2f um  endseg: %6.2f  click: %6.2f  count: %3.0f" % (f1, f2, L1avg, position_2, position_2-L1avg, L3avg, w2avg,position_2-L1avg+L3avg, L1avg+L2avg, count)



if __name__ == "__main__":
    oParser = OptionParser()
    oParser.add_option('-a', '--w1', type='float', help='size of waist 1 in um')
    oParser.add_option('-b', '--w2', type='float', help='size of waist 2 in um')
    oParser.add_option('-u', '--upper', type='float', default='0', help='Upper Limit - Returns solutions with L3 > upper')
    oParser.add_option('-l', '--length', type='float', help='optical path length in mm')
    oParser.add_option('-o', '--lower', type='float', default='0', help='Lower limit')
    oParser.add_option('-t', '--tolerance', type='float', default='1',
            help='Range for resulting waist  in microns')
    (options, args) = oParser.parse_args()
    
    w1 = options.w1
    w2 = options.w2
    upper_limit = options.upper
    lower_limit = options.lower
    L = options.length
    tolerance = options.tolerance


r = -200
n = 1
step = 1
error = 1

bank = LensBank('lenses.txt')




solutions = {}
nonphysical_solutions = 0
mirror_positions = []
mirror_width = 20

for f1,f2 in bank.perms:
    ds.direct_solve.two_lens_direct_solve(w1, w2, f1, f2, L, r, n, step, tolerance, error, callback, lower_limit, upper_limit)

print "Matching wo: %4.3f um to %4.3f um.  Length:  %4.3f mm " % (w1, w2,L)
if nonphysical_solutions:
	print "Matching: %s nonphysical solutions found.. lens placement blocked by mirrors" % nonphysical_solutions
