#!/usr/bin/env python

from math import pi, sqrt

class Matching(object):
    def __init__(self, w1, w, f):
	self.lam = 0.000852
	self.f0 = pi*w1*w/self.lam
	self.f = f
	self.w1 = w1
	self.w = w
	self.d1 = d_cal(w1, w)
	self.d = d_cal(w, w1)

	def d_cal(self, w, w1):
	    return [self.f+(w1/w)*sqrt(self.f**2-self.f0**2),
		    self.f -(w1/w)*sqrt(self.f**2-self.f0**2)]

	def __repr__(self):
	    pass
		
