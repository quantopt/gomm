#!/usr/bin/python

class Element(object):
    def __init__(self):
        pass

#    def position(self):
#        pass
#   in reality, position is dependant on path... therefore not a property of the element
#   so we must decouple the position from the element
# if path changes, no need ot change element

class RefractingElement(Element):

    def __init__(self):
        pass

    def waist(self):
        pass

    def waist_position(self):
        pass

    def index(self):
        pass

    

class Lens(RefractingElement):
    def __init__(self, focal=100):
        self.focal = 100



class BiConvexLens(Lens): pass
class PlanoConvex(Lens): pass
class ConvexConcave(Lens): pass
class Meniscus(Lens): pass
class BiConcave(Lens): pass


class Distance(Element):
    def __init__(self, length=100):
        self.length = length

class Mirror(RefractingElement):
    def __init__(self, roc=100):
        self.radius_of_curvature = roc
        self.focal = self.radius_of_curvature/2

class Dielectric(Element):
    def __init__(self, index):
        self.index = index

