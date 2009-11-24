module matrix_test
  use opticsmatrices
  use pathsim
  implicit none

  double complex :: q1, q2

  double precision :: size, pos


  !q1 = (0, 300)

!   path (0) % matrix = identity()
!   path (0) % q = (0, 300)

!   path (1) % matrix = distance(100.0_8)
!   path (2) % matrix = lens(100.0_8)
!   path (3) % matrix = distance(100.0_8)



!  call process_beam_path(path, q1, q2)

  ! print *, "Input q1: "
  ! print *, q1
  ! print *, "Input matrix: "
  ! call print_matrix(mat)
  ! call waist_data(size, pos, q1)

  ! q2 = q2_q1(q1, mat)

  ! print *,
  ! print *, "Final Data: "
  ! call waist_data(size, pos, q2)
  ! print *, "Output q2: "
  ! print *, q2

contains

  subroutine test()
    implicit none
    print *, "Test subroutine"
  end subroutine test



end module matrix_test
