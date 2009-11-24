module pathsim
  use opticsmatrices
  implicit none 

  type element
     double complex :: q
     double precision :: waist_size
     double precision :: waist_position
     double precision, dimension(2,2) :: matrix
  end type element





!  type (element), dimension(0:30) :: path 
  integer :: element_count = 0

contains
!   subroutine add_element(path, element, position)
!     implicit none
    
!     path(position) % matrix  = element
!     if position == end then

!     else if position == midddle then
!        copy 0-position-1 to new path
!        put element into position
!        element_count = element_count + 1
!        copy position_old-element_count_old to new path (position+1) element count+_1
!     end if


!   end subroutine add_element

!   subroutine remove_element(path, position)
!     implicit none
!   end subroutine remove_element

!   subroutine update_element(path, position)
!     implicit none
!   end subroutine update_element


  subroutine process_beam_path(path, q1, q2)
    implicit none
    type (element), dimension(0:), intent(inout) :: path
    double precision, dimension(2,2) :: mat = reshape((/1, 0, 0, 1/), (/2, 2/)) 
    double complex, intent(inout) :: q1, q2
    double complex :: qi
    integer :: i, n

    n = size(path)
    qi = q1

    do i = 0,3
       print "('Element matrix for step ', i3)", i
       call print_matrix(path(i) % matrix)

       mat = matmul(mat, path(i) % matrix)
       path(i) % q = q2_q1(qi, mat)
       qi = path(i) % q
       call data_at_point(mat, i, qi)
    end do

  end subroutine process_beam_path

  subroutine data_at_point(mat, point, qi)
    implicit none
    integer, intent(in) :: point
    double precision :: size, pos
    double precision, dimension(2,2), intent(in) :: mat
    double complex, intent (in) :: qi

    print "('q after element', i2,': ', f6.2, bn, f8.2)",point, qi
    call waist_data(qi, size, pos)
  end subroutine data_at_point

  function plot_data(start,finish, q)
    implicit none
    integer  :: i
    double precision :: z, w0
    double complex, intent(in) :: q
    integer, intent(in) :: start, finish
    double precision, dimension(start: finish+1, 2)  :: plot_data

    w0 = w_q(q)
    do i = start, finish+1
       z = real(i, 8)
       plot_data(1,i) = z
       plot_data(2,i) = w_z(w0, z)
    end do

  end function plot_data

  subroutine waist_data(q, size, pos)
    implicit none
    double precision, intent(out) :: size, pos
    double complex, intent(in) :: q
    size = w_q(q)
    pos = real(q)
    print "('Position:  ', f6.2, ' mm')", pos
    print "('Size:  ', f6.2, ' um')", size
  end subroutine waist_data

  subroutine print_matrix(m)
    implicit none
    double precision, dimension(2,2), intent(in) :: m
    10  format(f6.2, t10, f6.2)

    print 10, m(1,1), m(1,2)
    print 10, m(2,1), m(2,2)
  end subroutine print_matrix



end module pathsim
