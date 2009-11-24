!       matrix.f90
!
!       Module for matrix type and operations
!       by Paul H. Hargrove
!       May 13, 1996
!
module operator

        type matrix
          real elem
        end type matrix

!         interface assignment(=)
!           module procedure matrix_from_real, matrix_from_matrix, &
!                            vector_from_real, vector_from_vector
!         end interface
                
!         interface operator(+)
!           module procedure matrix_add, vector_add
!         end interface

!         interface operator(-)
!           module procedure matrix_sub, vector_sub
!         end interface

!         interface operator(*)
!           module procedure matrix_mul, vector_mul, matrix_vector_mul
!         end interface

!         interface operator(/)
!           module procedure matrix_div, matrix_vector_div
!         end interface

contains

        !
        ! ASSIGNMENT OPERATORS: X = Y
        !

        subroutine matrix_from_real(X, Y)
        ! copy a 2D array of reals to a 2D array of type matrix
          real, intent(in), dimension(:,:) :: Y
          type(matrix), intent(out), dimension(size(Y,1),size(Y,2)) :: X

!          X(:,:)%elem = Y(:,:)
        end subroutine matrix_from_real

!         subroutine matrix_from_matrix(X, Y)
!         ! copy a 2D array of type matrix
!           type(matrix), intent(in), dimension(:,:) :: Y
!           type(matrix), intent(out), dimension(size(Y,1),size(Y,2)) :: X

!           X(:,:)%elem = Y(:,:)%elem
!         end subroutine matrix_from_matrix

!         subroutine vector_from_real(X, Y)
!         ! copy a 1D array of reals to a 1D array of type matrix
!           real, intent(in), dimension(:) :: Y
!           type(matrix), intent(out), dimension(size(Y,1)) :: X

!           X(:)%elem = Y(:)
!         end subroutine vector_from_real

!         subroutine vector_from_vector(X, Y)
!         ! copy a 1D array of type matrix
!           type(matrix), intent(in), dimension(:) :: Y
!           type(matrix), intent(out), dimension(size(Y,1)) :: X

!           X(:)%elem = Y(:)%elem
!         end subroutine vector_from_vector

!         !
!         ! ADDITION OPERATORS: X = Y + Z
!         !

!         function matrix_add(Y, Z) result(X)
!         ! add 2D arrays of type matrix
!           type(matrix), intent(in), dimension(:,:) :: Y
!           type(matrix), intent(in), dimension(size(Y,1),size(Y,2)) :: Z
!           type(matrix), dimension(size(Y,1),size(Y,2)) :: X

!           X(:,:)%elem = Y(:,:)%elem + Z(:,:)%elem
!         end function matrix_add

!         function vector_add(Y, Z) result(X)
!         ! add 1D arrays of type matrix
!           type(matrix), intent(in), dimension(:) :: Y
!           type(matrix), intent(in), dimension(size(Y,1)) :: Z
!           type(matrix), dimension(size(Y,1)) :: X

!           X(:)%elem = Y(:)%elem + Z(:)%elem
!         end function vector_add

!         !
!         ! SUBTRACTION OPERATORS: X = Y - Z
!         !

!         function matrix_sub(Y, Z) result(X)
!         ! subtract 2D arrays of type matrix
!           type(matrix), intent(in), dimension(:,:) :: Y
!           type(matrix), intent(in), dimension(size(Y,1),size(Y,2)) :: Z
!           type(matrix), dimension(size(Y,1),size(Y,2)) :: X

!           X(:,:)%elem = Y(:,:)%elem - Z(:,:)%elem
!         end function matrix_sub

!         function vector_sub(Y, Z) result(X)
!         ! subtract 1D arrays of type matrix
!           type(matrix), intent(in), dimension(:) :: Y
!           type(matrix), intent(in), dimension(size(Y,1)) :: Z
!           type(matrix), dimension(size(Y,1)) :: X

!           X(:)%elem = Y(:)%elem - Z(:)%elem
!         end function vector_sub

!         !
!         ! MULTIPLICATION OPERATORS: X = Y * Z
!         !

!         function matrix_mul(Y, Z) result(X)
!         ! multiply 2D arrays of type matrix
!         ! NOTE: NAG's F90 demo won't deal w/ "half constrained" dimensions
!           type(matrix), intent(in), dimension(:,:) :: Y
!           type(matrix), intent(in), dimension(:,:) :: Z
!           type(matrix), dimension(size(Y,1),size(Z,2)) :: X

!           X(:,:)%elem = MATMUL(Y(:,:)%elem, Z(:,:)%elem)
!         end function matrix_mul

!         function vector_mul(Y, Z) result(X)
!         ! multiply 1D arrays of type matrix
!           type(matrix), intent(in), dimension(:) :: Y
!           type(matrix), intent(in), dimension(size(Y,1)) :: Z
!           real X

!           X = DOT_PRODUCT(Y(:)%elem, Z(:)%elem)
!         end function vector_mul

!         function matrix_vector_mul(Y, Z) result(X)
!         ! multiply 2D array times 1D array of type matrix
!           type(matrix), intent(in), dimension(:,:) :: Y
!           type(matrix), intent(in), dimension(size(Y,2)) :: Z
!           type(matrix), dimension(size(Y,1)) :: X

!           X(:)%elem = MATMUL(Y(:,:)%elem, Z(:)%elem)
!         end function matrix_vector_mul

!         !
!         ! DIVISION OPERATORS: X = Y/Z = INV(Z) * Y
!         !

!         function matrix_div(Y, Z) result(X)
!         ! "divide" 2D arrays of type matrix
!           type(matrix), intent(in), dimension(:,:) :: Y
!           type(matrix), intent(in), dimension(:,:) :: Z
!           type(matrix), dimension(size(Y,1),size(Y,2)) :: X
!           real, dimension(size(Z,1),size(Z,2)) :: W
!           integer i, j, k, n
        
!         ! copy arguments so they aren't modified
!           W(:,:) = Z(:,:)%elem
!           X(:,:)%elem = Y(:,:)%elem

!         ! perform Gauss elimination on augmented matrix (W|X)
!           n = size(Z,2)
!           do k = 1,n-1
!             do i=k+1,n
!               W(i,k) = W(i,k)/W(k,k)
!               X(i,:)%elem = X(i,:)%elem - W(i,k) * X(k,:)%elem
!             end do
!             do j=k+1,n
!               do i=k+1,n
!                 W(i,j) = W(i,j) - W(i,k) * W(k,j)
!               end do
!             end do
!           end do

!         ! perform back substitution on X
!           do k = n,1,-1
!             X(k,:)%elem = X(k,:)%elem / W(k,k)
!             do i=1,k-1
!               X(i,:)%elem = X(i,:)%elem - W(i,k) * X(k,:)%elem
!             end do
!           end do
!         end function matrix_div

!         function matrix_vector_div(Y, Z) result(X)
!         ! "divide" 1D array by 2D array of type matrix
!           type(matrix), intent(in), dimension(:) :: Y
!           type(matrix), intent(in), dimension(:,:) :: Z
!           type(matrix), dimension(size(Y,1)) :: X
!           real, dimension(size(Z,1),size(Z,2)) :: W
!           integer i, j, k, n
        
!         ! copy arguments so they aren't modified
!           W(:,:) = Z(:,:)%elem
!           X(:)%elem = Y(:)%elem

!         ! perform Gauss elimination on augmented matrix (W|X)
!           n = size(Z,2)
!           do k = 1,n-1
!             do i=k+1,n
!               W(i,k) = W(i,k)/W(k,k)
!               X(i)%elem = X(i)%elem - W(i,k) * X(k)%elem
!             end do
!             do j=k+1,n
!               do i=k+1,n
!                 W(i,j) = W(i,j) - W(i,k) * W(k,j)
!               end do
!             end do
!           end do

!         ! perform back substitution on X
!           do k = n,1,-1
!             X(k)%elem = X(k)%elem / W(k,k)
!             do i=1,k-1
!               X(i)%elem = X(i)%elem - W(i,k) * X(k)%elem
!             end do
!           end do
!         end function matrix_vector_div

end module operator
