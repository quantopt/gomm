#!/usr/bin/python

from numpy import matrix


class Matrix(matrix):
    def __init__(self):
        super(matrix, self).__init__()

class DistanceMatrix(Matrix):
    def __init__(self, d):
        self.matrix = matrix(([1, d], [0,1]))

class LensMatrix(Matrix):
    def __init__(self, f):
        self.matrix = matrix(([1, 0], [-1./f,1]))

class DielectricMatrix(Matrix):
    def __init__(self, d, n):
        self.matrix = DistanceMatrix(d/n)

class DistanceLens(Matrix):
    def __init__(self, d, f):
        self.matrix = DistanceMatrix(d)*LensMatrix(f)

class TwoLens(Matrix):
    def __init__(self, d1, f1, d2, f2):
        self.matrix = DistanceLens(d1,f1)*DistanceLens(d2,f2)


class MediumMatrix(Matrix):
    pass

