module opticsmatrices
  use optics
  implicit none

  interface identity
     module procedure flat_mirror
  end interface  

contains

  function q2_q1(q1, matrix)
    implicit none
    double complex, intent(in) :: q1
    double precision, dimension(2,2), intent(in) :: matrix
    double complex :: q2_q1

    q2_q1 = (matrix(1,1)*q1+matrix(1,2))/(matrix(2,1)*q1+matrix(2,2))
  end function q2_q1


  function distance(d, n_opt)
    implicit none
    double precision :: n = 1.0_8
    double precision, intent(in) :: d
    double precision, intent(in), optional :: n_opt
    double precision, dimension(2,2) :: distance

    if (present(n_opt)) then
       n = n_opt
    end if

    distance = ray_matrix(1.0_8, d/n, 0.0_8, 1.0_8)
  end function distance


  function lens(f)
    implicit none
    double precision, intent(in) :: f
    double precision, dimension(2,2) :: lens
    
    lens = ray_matrix(1.0_8, 0.0_8, -1.0_8/f, 1.0_8)
  end function lens

  function mirror(r)
    implicit none
    double precision, intent(in) :: r
    double precision, dimension(2,2) :: mirror

    mirror = ray_matrix(1.0_8,0.0_8,-2.0/r, 1.0_8)
  end function mirror

  function flat_refraction(n1, n2)
    implicit none
    double precision, intent(in) :: n1, n2
    double precision, dimension(2,2) :: flat_refraction

    flat_refraction = ray_matrix(1.0_8, 0.0_8, 0.0_8, n1/n2)
  end function flat_refraction

  function curved_refraction(n1, n2, r)
    implicit none
    double precision, intent(in) :: n1, n2, r
    double precision, dimension(2,2) :: curved_refraction

    curved_refraction = ray_matrix(1.0_8, 0.0_8, (n1-n2)/(r*n2), n1/n2)
  end function curved_refraction

  
  function flat_mirror()
    implicit none
    double precision, dimension(2,2) :: flat_mirror

    flat_mirror = ray_matrix(1.0_8, 0.0_8, 0.0_8, 1.0_8)
  end function flat_mirror

  function ray_matrix(a,b,c,d)
    implicit none
    double precision, dimension(2,2) :: ray_matrix
    double precision, intent(in) :: a, b, c, d

    ray_matrix = reshape((/a, c, b, d/),  (/2,2/))
  end function ray_matrix

end module opticsmatrices
