#!/usr/bin/python
#
#  This program returns the returns the location and size of the waist
#  produced from a gaussian laser source
#
#  uses intensity-based knife-edge formulas, taken from
#  Shojiro Nemoto,
#  Determination of waist parameters of a Gaussian Beam
#  Applied Optics, November 1 1986, Vol. 25, No. 21

import sys
from operator import itemgetter
from optparse import OptionParser
from math import *
from pylab import *
#import scipy


def calc_params(data_points,k):
    p1,p2 = data_points[0], data_points[1]
    z1,z2=p1[0], p2[0]
    s1,s2=p1[1], p2[1]
    p=s1/s2+s2/s1
    q=s1/s2-s2/s1
    r=((z1-z2)/(k*s1*s2))**2
    t=z1*s2/s1-z2*s1/s2
    u=z1+z2
    v=z1-z2
    s_ = sqrt(s1*s2)
    return {'p':p,'q':q, 'r':r, 't':t, 'u':u, 'v':v, 's_':s_} 
    
def z_plus(params):
    p,q,r,t,u,v,s_=params['p'],params['q'],params['r'],params['t'],params['u'],params['v'],params['s_']
    pos = (2*u*r-q*(t+v*sqrt(1-r)))/(q**2+4*r) 
    size = s_*sqrt((r*(p+2*sqrt(1-r)))/(q**2+4*r))
    return [pos, size]

def z_minus(params):
    p,q,r,t,u,v,s_=params['p'],params['q'],params['r'],params['t'],params['u'],params['v'],params['s_']
    pos = (2*u*r-q*(t-v*sqrt(1-r)))/(q**2+4*r) 
    size = s_*sqrt((r*(p-2*sqrt(1-r)))/(q**2+4*r))
    return [pos, size]

def get_data():
    g=10**-4
    filename = sys.argv[1]
    data = sorted([line.strip().split() for line in file(filename)], key=itemgetter(0))
    return [[float(i[0]), float(i[1])*g] for i in data]

def make_piles(data):
    #edge cases
    # smallest is 1st or last element *
    # only two data points  *
    # equal distance from min to next *
    left_hand, right_hand = [], []
    smallest = data.index(min(data, key=itemgetter(1)))
    if (smallest == 0)  or (smallest == len(data)-1):
        #if the minimum is at the beginning or end of data
        left_hand = data
    else:
        #if there is minimum in the middle of the data
        distance_left  = abs(data[smallest][0] - data[smallest-1][0])
        distance_right = abs(data[smallest][0] - data[smallest+1][0])
        if distance_right < distance_left:
            switch_point = smallest
        elif distance_right > distance_left:
            switch_point = smallest+1
        elif distance_right == distance_left:
            #assign point to side with fewest entries
            if len(data)-smallest < smallest:
                switch_point = smallest
            else:
                switch_point = smallest+1
        for i,v in enumerate(data):
            if i < switch_point:
                left_hand.append(v)
            else:
                right_hand.append(v)

    print len(right_hand)
    print right_hand
    if len(right_hand) == 0:
        print "Using Z+ solutions"
        return [(a,b) for a in left_hand for b in left_hand if (a != b and a[0] < b[0])], z_plus
    else:
        print "Using Z- solutions"
        return [(a,b) for a in left_hand for b in right_hand if (a != b and a[0] < b[0])], z_minus


def hyper(z,z0,s0,k):
    return s0*sqrt(1+((z-z0)/(k*s0*s0))**2) 
    
def main():
    usage = "usage: %prog [options] input_file"
    description = "Waist finding program"
    parser = OptionParser(usage=usage, description=description)
    parser.set_defaults(freq=852.2, solver="0")
    parser.add_option("-f", "--freq", help="set frequency of laser in nm", type="float")
    parser.add_option("-m", "--minus", help="use z_minus solutions", dest="solver", action="store_const", const=1)
    parser.add_option("-p", "--plot", help="show plot of resulting fit", action="store_true")
    (options, args) = parser.parse_args()
    return options
    
def show_plot():
    return True

if __name__ == "__main__":
    options = main()

f = options.freq*10**-7
#solver = (z_plus, z_minus)[int(options.solver)]
g=10**4
k=2*pi/f
data = get_data()
data_points, solver = make_piles(data)

a,o = [],[]
for set in data_points:
    params = calc_params(set,k)
    if params['r'] < 1:
        results = solver(params)
        a.append(results[0])
        o.append(results[1])

z0,s0 = sum(a)/len(a),sum(o)/len(o)
print "Position is %s cm and size is %s um" % (z0, s0*g)

width  = max(data, key=itemgetter(0))[0]
ymax = max(data, key=itemgetter(1))[1]*g
xlabel('position [cm]')
ylabel(r'$ size [\mu m]$')
title('Gaussian waist parameters')
xmin, xmax = -50, 1000
z = arange(xmin,xmax,(xmax-xmin)/120.0)
plot (z,g*hyper(z,z0,s0,k), 'r', z, -g*hyper(z,z0,s0,k),'r', [p[0] for p in data],[g*p[1] for p in data],'bo')
xlim(xmin, xmax)
ylim(-ymax, ymax)
show()
