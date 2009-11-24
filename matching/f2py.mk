
python: $(modules) $(files)
	f2py $(f2pyflags) $^ -m optics


c2c: c2c_solver.f90 utils.f90 transforms.f90 optics.f90
	make clean && make c2c_solver.o && f2py $(f2pyflags) $^ -m c2cmod

direct: direct_solve.f90 utils.f90 transforms.f90 optics.f90
	f2py $(f2pyflags) $^ -m optics

pymatrix: mtest.f90
	f2py $(f2pyflags) $^ -m $@

pymat: utils.f90 optics.f90 opticsmatrices.f90 pathsim.f90 matrixtest.f90
	f2py $(f2pyflags) $^ -m $@

pyoptics: utils.f90 optics.f90
	f2py $(f2pyflags) $^ -m opticspy



