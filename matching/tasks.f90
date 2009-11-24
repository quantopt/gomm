module direct_solve
use transforms
use optics
implicit none


contains


  subroutine two_lens_direct_solve( w1, w2, f1, f2, L, step, tolerance, error)
    implicit none
    double precision, intent(in) :: w1, w2, f1, f2, L, step, tolerance, error
    double precision :: L1, L2, L3
    double complex :: q1, q_target, q2

    q1 = q(w1)
    q_target = q(w2)

    do L1 = 0, L, step
       do L3 = L1, L, step
          L2 = L-L1-L3
          q2 = two_lens(L1, L2, L3, f1, f2, q1)
          if (abs(aimag(q2)- aimag(q_target)) <  tolerance) then
                if (abs(real(q2)) < error) then
                   print *,  "L1: %0.4f mm    L2: %s mm     L4: %s mm    waist:%s um  q.real: %0.4f   q.imag: %0.6f um", &
                            L1,L2, L3, w_q(q2), real(q2), aimag(q2)
                end if
          end if
       end do 
    end do
   end subroutine two_lens_direct_solve

end module direct_solve
