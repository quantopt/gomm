#!/usr/bin/python
from numpy import *


list = [line.strip().split() for line in file("jia_avg")]
for measure in list:
	res = sum(int(measure[i]) for i in range(1,5))/4
	print "%s %s" % (measure[0],res)

