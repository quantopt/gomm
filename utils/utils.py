#!/usr/bin/python


from math import fabs

def initFromArgs(beingInitted, bJustArgs=False):
    import sys
    codeObject = beingInitted.__class__.__init__.im_func.func_code
    for k,v in sys._getframe(1).f_locals.items():
        if k!='self' and ((not bJustArgs) or k in codeObject.co_varnames[1:codeObject.co_argcount]):
            setattr(beingInitted,k,v)


def n2u(number):
    return u2m(number)

def u2m(number):
    return  float(number)/1000

def m2u(number):
    return number*1000

def m2c(number):
    return number*10

def eq(a, b, tolerance=1):
    return fabs(a-b) < tolerance


