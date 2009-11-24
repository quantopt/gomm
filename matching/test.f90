program test
use direct_solve
implicit none

double precision :: w1, w2, f1, f2, L, r, n, step, tolerance, error

w1 = 400
w2 = 201
f1 = 150
f2 = 150
L = 907.5
r = -200
n = 1.7
step = 1
tolerance = 1
error = 1
call two_lens_direct_solve( w1, w2, f1, f2, L, r, n, step, tolerance, error, pass)
print *, "Done"
end program test

!     wavelength = 0.852# options.wavelength
!     tolerance, error = 5, 1 #options.tolerance, options.error
!     step, L = 0.1, 464# options.step, options.length
!     f1, f2 = 35, 75 #options.f1, options.f2
!     w1, w2 = 400, 28.272#options.w1, options.w2
!     direct_solve(wavelength, w1, w2, f1, f2, L,  step, tolerance, error)
