module utils
  implicit none

  interface u2m
     module procedure up
  end interface

  interface n2u
     module procedure up
  end interface

  interface m2u
     module procedure down
  end interface

contains

  logical function eq(a, b, tmp_tol)
    implicit none
    double precision, intent(in) :: a, b
    double precision, optional, intent(in) ::tmp_tol
    double precision :: tolerance=1
    
    if (present(tmp_tol)) then
       tolerance = tmp_tol
    end if

    if (abs(a-b) < tolerance) then
       eq = .true.
    else
       eq = .false.
    end if
  end function eq

  double precision function up(number)
    implicit none
    double precision, intent(in) :: number
    up = number/1000
  end function up


  double precision function down(number)
    implicit none
    double precision, intent(in) :: number
    down = number*1000
  end function down


end module utils
