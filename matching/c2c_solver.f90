module c2cmod
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


  subroutine c1solution_handler(L1, L2, w2)
    implicit none
    double precision, intent(in) :: L1, L2, w2
    
    wsum  = wsum + w2
    L1sum = L1sum + L1
    L2sum = L2sum + L2
    count  = count+ 1
    L1avg = L1sum/count
    L2avg = L2sum/count
    wavg = wsum/count
    
  end subroutine c1solution_handler

  subroutine w2c_handler(L, w2)
    implicit none
    double precision, intent(in) :: L, w2
    
    wsum = wsum + w2
    L1sum = L1sum + L
    count = count+1
    wavg = wavg/count
    L1avg = L1avg/count
  end subroutine w2c_handler


  subroutine w2c_solve(w2, w_low, w_high, l_high, r2, step, error, func)
    implicit none
    double precision, intent(in) :: w2, w_low, w_high, r2, l_high, step, error
    double precision :: w1, w2_calc, L, L1tmp, wtmp, ctmp, d_crys=10, d_opo=52.8, d_d=83.7, n=1.8
    
    double complex :: q1, q_target, q2
    external func

    count = 0
    L1sum = 0; wsum = 0
    L1avg = 0; wavg = 0

    q_target = q(w2)
    do L = 10, l_high
       do w1 = w_low, w_high
          q1 = q(w1)                 
          q2 = w2c(L, d_crys, d_opo, n, r2, q1)
          w2_calc = w_q(q2)
          if (eq(aimag(q2),aimag(q_target)))  then
             if ((abs(real(q2)) < error) .and. eq(w2,w2_calc)) then
                call w2c_handler(L,  w2_calc)
                call func(L, w1, w2_calc, count)
             end if
          end if
       end do
    end do

!!$    if (count > 0) then
!!$       L1tmp = L1avg;  wtmp = wavg; ctmp = count
!!$       call func(L1tmp, wtmp, ctmp)
!!$    end if

  end subroutine w2c_solve

  subroutine w2cm_solve(w2, w_low, w_high, l_high, f2, step, error, func)
    implicit none
    double precision, intent(in) :: w2, w_low, w_high, f2, l_high, step, error
    double precision :: w1, w2_calc, L, L1tmp, wtmp, ctmp, d_crys=10, d_opo=52.8, n=1.8
    
    double complex :: q1, q_target, q2
    external func

    count = 0
    L1sum = 0; wsum = 0
    L1avg = 0; wavg = 0

    q_target = q(w2)
    do L = 10, l_high
       do w1 = w_low, w_high
          q1 = q(w1)                 
          q2 = w2cm(L, d_crys, d_opo, n, f2, q1)
          w2_calc = w_q(q2)
          if (eq(aimag(q2),aimag(q_target)))  then
             if ((abs(real(q2)) < error) .and. eq(w2,w2_calc)) then
                call w2c_handler(L,  w2_calc)
                call func(L, w1, w2_calc, count)
             end if
          end if
       end do
    end do

!!$    if (count > 0) then
!!$       L1tmp = L1avg;  wtmp = wavg; ctmp = count
!!$       call func(L1tmp, wtmp, ctmp)
!!$    end if

  end subroutine w2cm_solve


  subroutine c2c1_solve(w1, w2, f1, L, r1, r2, step, error, func, lower, upper)
    implicit none
    double precision, intent(in) :: f1, w1, w2, L, r1, r2, step, error
    double precision, intent(inout), optional :: lower, upper
    double precision :: L1, L2, L1tmp, L2tmp, wtmp, ctmp, Leff, w2_calc, d_crys=10, d_opo=52.8, d_d=83.7, n=1.8
    
    double complex :: q1, q_target, q2
    external func

    
    count = 0
    L1sum = 0; L2sum = 0;  wsum = 0
    L1avg = 0; L2avg = 0;  wavg = 0

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
       L2 = Leff-L1                   
       q2 = c2c_1lens(L1, L2, d_crys, d_opo, d_d, n, r2, r1, f1, q1)
          w2_calc = w_q(q2)
          if (eq(aimag(q2),aimag(q_target)))  then
                if ((abs(real(q2)) < error) .and. eq(w2,w2_calc)) then
                   if (L1 > lower .and. L2 > upper ) then
                      call c1solution_handler(L1, L2, w2_calc)
                   end if
                end if
          end if
    end do                
 
    if (count > 0) then
       L1tmp = L1avg;  L2tmp = L2avg; wtmp = wavg; ctmp = count
       call func(f1, L1tmp, L2tmp, wtmp, ctmp)
    end if
  end subroutine c2c1_solve

  subroutine c2c2_solve(w1, w2, f1, f2, L, r1, r2, step, error, func, lower, upper)

    implicit none
    double precision, intent(in) :: f1, f2, w1, w2, r1, r2, step, error, L
    double precision, intent(inout), optional :: lower, upper
    double precision :: L1, L2, L3, L1tmp, L2tmp, L3tmp, wtmp, ctmp, Leff, w2_calc, d_crys=10, d_opo=52.8, d_d=83.7, n=1.8, &
         L_low=800, L_high=1100, L_start, L_end, L_loop
    
    double complex :: q1, q_target, q2
    external func

    do L_loop = L_low, L_high
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
    Leff = L_loop
    L_start = d_crys+d_d
    L_end = L-d_crys-d_opo
    do L1 = 0, Leff, step
       do L3 = 0, Leff-L1, step
          L2 = Leff-L1-L3                   
          q2 = c2c_2lens(L1, L2, L3, d_crys, d_opo, d_d, n, r2, r1, f2, f1, q1)
          w2_calc = w_q(q2)
          if (eq(aimag(q2),aimag(q_target)))  then
                if ((abs(real(q2)) < error) .and. eq(w2,w2_calc)) then
                   if (L1 > lower .and. L2 > 8 .and. L3 > upper ) then
                      call solution_handler(L1, L2, L3, w2_calc)
                   end if
                end if
          end if
       end do 
    end do                
 

    if (count > 0) then
       L1tmp = L1avg;  L2tmp = L2avg; L3tmp = L3avg; wtmp = wavg; ctmp = count
       call func(f1, f2, L1tmp, L2tmp, L3tmp, wtmp, ctmp)
    end if

    end do
  end subroutine c2c2_solve




  subroutine cmc1_solve(w1, w2, f1, L, c1, c2, step, error, func, lower, upper)
    implicit none
    double precision, intent(in) :: f1, w1, w2, L, c1, c2, step, error
    double precision, intent(inout), optional :: lower, upper
    double precision :: L1, L2, L1tmp, L2tmp, wtmp, ctmp, Leff, w2_calc, d_crys=10, d_opo=52.8, d_d=83.7, n=1.8
    
    double complex :: q1, q_target, q2
    external func

    
    count = 0
    L1sum = 0; L2sum = 0;  wsum = 0
    L1avg = 0; L2avg = 0;  wavg = 0

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
       L2 = Leff-L1                   
       q2 = cmc_1lens(L1, L2, d_crys, d_opo, d_d, n, c2, c1, f1, q1)
          w2_calc = w_q(q2)
          if (eq(aimag(q2),aimag(q_target)))  then
                if ((abs(real(q2)) < error) .and. eq(w2,w2_calc)) then
                   if (L1 > lower .and. L2 > upper ) then
                      call c1solution_handler(L1, L2, w2_calc)
                   end if
                end if
          end if
    end do                
 
    if (count > 0) then
       L1tmp = L1avg;  L2tmp = L2avg; wtmp = wavg; ctmp = count
       call func(f1, L1tmp, L2tmp, wtmp, ctmp)
    end if
  end subroutine cmc1_solve





  subroutine cmc2_solve(w1, w2, f1, f2, L, c1, c2, step, error, func, lower, upper)

    implicit none
    double precision, intent(in) :: f1, f2, w1, w2, c1, c2, step, error, L
    double precision, intent(inout), optional :: lower, upper
    double precision :: L1, L2, L3, L1tmp, L2tmp, L3tmp, wtmp, ctmp, Leff, w2_calc, d_crys=10, d_opo=52.8, d_d=83.7, n=1.8, &
         L_low=800, L_high=1100, L_start, L_end, L_loop
    
    double complex :: q1, q_target, q2
    external func

    !do L_loop = L_low, L_high
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
    L_start = d_crys+d_d
    L_end = L-d_crys-d_opo
    do L1 = 0, Leff, step
       do L3 = 0, Leff-L1, step
          L2 = Leff-L1-L3                   
          q2 = cmc_2lens(L1, L2, L3, d_crys, d_opo, d_d, n, c2, c1, f2, f1, q1)
          w2_calc = w_q(q2)
          if (eq(aimag(q2),aimag(q_target)))  then
                if ((abs(real(q2)) < error) .and. eq(w2,w2_calc)) then
                   if (L1 > lower .and. L2 > 8 .and. L3 > upper ) then
                      call solution_handler(L1, L2, L3, w2_calc)
                   end if
                end if
          end if
       end do 
    end do                
 

    if (count > 0) then
       L1tmp = L1avg;  L2tmp = L2avg; L3tmp = L3avg; wtmp = wavg; ctmp = count
       call func(f1, f2, L1tmp, L2tmp, L3tmp, wtmp, ctmp)
    end if

    !end do
  end subroutine cmc2_solve










  subroutine c2cw_solve(w1, w2, f1, f2, L, r1, step, error, func, lower, upper)

    implicit none
    double precision, intent(in) :: f1, f2, w1, w2, r1, step, error, L
    double precision, intent(inout), optional :: lower, upper
    double precision :: L1, L2, L3, L1tmp, L2tmp, L3tmp, wtmp, ctmp, Leff, w2_calc, d_crys=10, d_opo=52.8, d_d=83.7, n=1.8, &
          L_start, L_end, L_loop,  L_low=600, L_high=900
    
    double complex :: q1, q_target, q2
    external func

!    print *, f1, f2
    do L_loop = L_low, L_high
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
    Leff = L_loop
    
    do L1 = 0, Leff, step
       do L3 = 0, Leff-L1, step
          L2 = Leff-L1-L3                   
          q2 = c2w_2lens(L1, L2, L3, d_crys, d_d, n, r1, f1, f2, q1)                        
          w2_calc = w_q(q2)
          if (eq(aimag(q2),aimag(q_target)))  then
                if ((abs(real(q2)) < error) .and. eq(w2,w2_calc)) then
                   if (L1 > lower .and. L2 > 8 .and. L3 > upper ) then
                      call solution_handler(L1, L2, L3, w2_calc)
                   end if
                end if
          end if
       end do 
    end do                
 

    if (count > 0) then
       L1tmp = L1avg;  L2tmp = L2avg; L3tmp = L3avg; wtmp = wavg; ctmp = count
       call func(f1, f2, L1tmp, L2tmp, L3tmp, wtmp, ctmp)
    end if

    end do
  end subroutine c2cw_solve
  
end module c2cmod
