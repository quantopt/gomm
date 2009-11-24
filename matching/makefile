FC = g95
FFLAGS =  -M -freal-loops -fPIC -O3 -Wprecision-loss -fshort-circuit -fzero
f2pyflags = -c --fcompiler=g95  -DF2PY_REPORT_ATEXIT --f90flags="$(FFLAGS)" #--g3-numpy

files := $(wildcard *.f90)
objects := $(files:.f90=.o)

programs :=
modules :=

# Executables
test: utils.o optics.o transforms.o direct_solve.o test.o
	$(FC)  $(FFLAGS) $^ -o $@


# F2Py modules
include f2py.mk

# Module dependency tree
matrixtest.o: pathsim.o
pathsim.o: opticsmatrices.o
c2c_solver.o direct_solve.o:  optics.o transforms.o 
opticsmatrices.o: optics.o
optics.o: utils.o


# Implicit rules
%.o: %.f90
	$(FC) -c $(FFLAGS) $< -o $@

.PHONY : all
all: $(programs) $(modules)

.PHONY : clean
clean:
	-rm -f *.o *.mod *~ *.tmp *.so .\#* \#*\# test mattest
