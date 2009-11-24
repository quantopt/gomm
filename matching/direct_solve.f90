module direct_solve
use utils
use transforms
use optics
implicit none

double precision :: L1sum, L2sum, L3sum, wsum, count, L1avg, L2avg, L3avg, wavg


contains

  subroutine solution_handler(L1, L2, L3, w2)
    implicit none
    double precision, intent(in) :: L1, L2, L3, w2
    
    wsum  = wsum + w2
    L1sum = L1sum + L1
    L2sum = L2sum + L2
    L3sum = L3sum + L3
    count  = count+ 1
    L1avg = L1sum/count
    L2avg = L2sum/count
    L3avg = L3sum/count
    wavg = wsum/count
    
  end subroutine solution_handler

  subroutine two_lens_direct_solve( w1, w2, f1, f2, L, r, n, step, tolerance, error, func, lower, upper)
    implicit none
    double precision, intent(in) :: f1, f2, w1, w2, L, r, n, step, tolerance, error
    double precision, intent(inout), optional :: lower, upper
    double precision :: L1, L2, L3, L4=58.36, f3=-196, L1tmp, L2tmp, L3tmp, wtmp, ctmp, Leff, w2_calc
    
    double complex :: q1, q_target, q2
    external func

    count = 0
    L1sum = 0; L2sum = 0; L3sum = 0;  wsum = 0
    L1avg = 0; L2avg = 0; L3avg = 0; wavg = 0

    if (.not. present(lower)) then
       lower = 0
    end if

    if (.not. present(upper)) then
       upper = 0
    end if

    q1 = q(w1)
    q_target = q(w2)
    Leff = L
    do L1 = 0, Leff, step
       do L3 = 0, Leff-L1, step
          L2 = Leff-L1-L3
          q2 = two_lens(L1, L2, L3, f1, f2, q1)
!          q2 = three_lens(L1, L2, L3, L4, f1, f2, f3, q1)
          w2_calc = w_q(q2)
          if (eq(aimag(q2),aimag(q_target)))  then
                if ((abs(real(q2)) < error) .and. eq(w2,w2_calc)) then
                   if (L1 > lower .and. L2 > 8 .and. L3 > upper ) then
                      call solution_handler(L1, L2, L3, w2_calc)
                      ! need to make an array of raw solns o pass to python
                   end if
                end if
          end if
       end do 
    end do                
 
    if (count > 0) then
       L1tmp = L1avg;  L2tmp = L2avg; L3tmp = L3avg; wtmp = wavg; ctmp = count
       call func(f1, f2, L1tmp, L2tmp, L3tmp, wtmp, ctmp)
    end if

   end subroutine two_lens_direct_solve



end module direct_solve
