module optics
  use utils 
  implicit none

  double precision :: pi =3.1415926535897931
  double precision :: wavelength = 0.85209000000000000
  !double precision :: wavelength = 0.42604885000000000000

contains

  subroutine set_wavelength(lambda)
    implicit none
    double precision, intent(in) :: lambda

    wavelength = n2u(lambda)
  end subroutine set_wavelength

  double precision  function z_w(waist)
    implicit none
    double precision, intent(in) :: waist
    z_w = (pi*u2m(waist)**2)/u2m(wavelength)
  end function z_w


  double precision function waist_z(z)
    implicit none
    double precision, intent(in) :: z
    waist_z = sqrt(m2u(z)*wavelength/pi)
  end function waist_z

  double precision function w_z(w0, z)
    implicit none
    double precision, intent(in) ::w0, z
    w_z = w0*sqrt(1+(z/z_w(w0))**2)    
  end function w_z

  double precision function R_z(w, z)
    implicit none
    double precision, intent(in) :: z, w
    R_z = z*(1+(z_w(w)/z)**2)
  end function R_z

  double complex function q(w)
    implicit none
    double precision, intent(in) :: w
    q = cmplx(0, z_w(w))
  end function q

  double complex function q_z(w, z)
    implicit none
    double precision, intent(in) :: z, w
    q_z = cmplx(z, z_w(w))
  end function q_z

  double precision function w_q(q)
    implicit none
    double complex, intent(in) :: q
    w_q = waist_z(aimag(q))    
  end function w_q

end module optics
