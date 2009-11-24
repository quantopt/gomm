module operator

        type matrix
          real elem
        end type matrix

contains

        subroutine matrix_from_real(X, Y)
        ! copy a 2D array of reals to a 2D array of type matrix
          real, intent(in), dimension(:,:) :: Y
!          type(matrix), intent(out), dimension(size(Y,1),size(Y,2)) :: X
          type(matrix), intent(out) :: X
          X %elem = 5.0
        end subroutine matrix_from_real

end module operator
