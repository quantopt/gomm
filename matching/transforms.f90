module transforms
  implicit none



contains

  double complex function one_lens(d1, d2, f, q)
    implicit none
    double precision, intent(in) :: d1, d2, f
    double complex, intent(in) :: q
    one_lens = d2 + f*(d1+q)/(f-d1-q)
  end function one_lens


  double complex function two_lens(d1, d2, d3, f1, f2, q1)
    implicit none
    double precision, intent(in) :: d1, d2, d3, f1, f2
    double complex, intent(in) :: q1
    double complex :: n, d

    n = d1*d3*(d2-f1)-d1*(d2+d3-f1)*f2+d3*f1*f2-d2*(d3-f2)*(f1-q1)-d3*f1*q1-d3*f2*q1+f1*f2*q1
    d = d1*(d2-f1-f2)+f1*f2-(f1+f2)*q1+d2*(q1-f1)
    two_lens = n/d
  end function two_lens

  double complex function two_lens_crystal(d1, d2, d3, d4, f1, f2, n, r, q1)
    implicit none
    double precision, intent(in) :: d1, d2, d3, d4, f1, f2, n, r
    double complex, intent(in) :: q1
    double complex :: q2
    q2 = (2*d1*d4*(d2*(d3-f2)+f1*f2-d3*(f1+f2))*(1+n)- & 
         2*d4*(1+n)*(-d3*f1*f2+d2*(d3-f2)*(f1-q1)-f1*f2*q1+ & 
         d3*(f1+f2)*q1)-d1*(d4*(d2-f1-f2)+((d3+d4)*(d2-f1)-(d2+d3+d4- &
         f1)*f2)*n)*r+(-f1*f2*(d4+(d3+d4)*n)+d2*(d4+(d3+d4-f2)*n)*(f1- & 
         q1)+((-f1*f2+d3*(f1+f2))*n+d4*(f1+f2)*(1+n))*q1)*r)/(n*(2*d3*f1*f2 - &
         2*d3*f1*q1-2*d3*f2*q1+2*f1*f2*q1-f1*f2*r+f1*q1*r+f2*q1*r+  &
         d2*(f1-q1)*(-2*d3+2*f2+r)+d1*(2*d3*(d2-f1)-2*(d2+d3-f1)*f2+ &
         (-d2+f1+f2)*r)))

    two_lens_crystal = q2
  end function two_lens_crystal



  double complex function two_lens_mirror_crystal(d1, d2, d3, d4, d5, f1, f2, r, n, q1)
    implicit none
    double precision, intent(in) :: d1, d2, d3, d4, d5, f1, f2, r, n
    double complex, intent(in) :: q1
    double complex :: q2
    q2 = (2*d1*(d2*(d3-f2)+f1*f2-d3*(f1+f2))*(d5+d4*n)- &
         2*(d5+d4*n)*(-d3*f1*f2+d2*(d3-f2)*(f1-q1)-f1*f2*q1+  & 
         d3*(f1+f2)*q1)-d1*(-d5*(f1+f2)-((d3+d4)*f1+(d3+d4-f1)*f2)*n+  & 
         d2*(d5+(d3+d4-f2)*n))*r+(-f1*f2*(d5+(d3+d4)*n)+d2*(d5+(d3+d4-f2)*n)*(f1-  &
         q1)+(d5*(f1+f2)+((d3+d4)*f1+(d3+d4-f1)*f2)*n)*q1)*r)/(n*(2*d3*f1*f2-2*d3*f1*q1-  & 
         2*d3*f2*q1+2*f1*f2*q1-f1*f2*r+f1*q1*r+f2*q1*r+d2*(f1-q1)*(-2*d3+2*f2+r)+ & 
         d1*(2*d3*(d2-f1)-2*(d2+d3-f1)*f2+(-d2+f1+f2)*r)))
    two_lens_mirror_crystal = q2
  end function two_lens_mirror_crystal

  double complex function two_lens_mirror(d1, d2, d3, d4, f1, f2, r, q1)
    implicit none
    double precision, intent(in) :: d1, d2, d3, d4, f1, f2, r
    double complex, intent(in) :: q1
    double complex :: n, d

    n = (2*d1*d4*(d2*(d3-f2)+f1*f2-d3*(f1+f2))+2*d4*(d3*f1*f2+f1*f2*q1-d3*(f1+f2)*q1)-     &
         d1*((d3+d4)*(d2-f1)-(d2+d3+d4-f1)*f2)*r-((d3+d4)*f1*f2-((d3+d4)*f1+(d3+d4-f1)*   & 
         f2)*q1)*r+d2*(f1-q1)*(-2*d4*(d3-f2)+(d3+d4-f2)*r))
    d = (2*d3*f1*f2-2*d3*f1*q1-2*d3*f2*q1+2*f1*f2*q1-f1*f2*r+f1*q1*r+f2*q1*r+  &
         d2*(f1-q1)*(-2*d3+2*f2+r)+d1*(2*d3*(d2-f1)-2*(d2+d3-f1)*f2+(-d2+f1+f2)*r))

    two_lens_mirror = n/d
  end function two_lens_mirror

  double complex function three_lens(d1, d2, d3, d4, f1, f2, f3, q1)
    implicit none
    double precision, intent(in) :: d1, d2, d3, d4, f1, f2, f3
    double complex, intent(in) :: q1

    three_lens =  (d1*d4*(d2*(d3-f2)+f1*f2-d3*(f1+f2))-d1*((d3+d4)*(d2-f1)- &
         (d2+d3+d4-f1)*f2)*f3+f1*f2*(d3*d4-(d3+d4)*f3)-d2*(d3*(d4-f3)+f2*f3- &
         d4*(f2+f3))*(f1-q1)+(d4*f1*f2-f1*f2*f3+d4*(f1+f2)*f3+d3*(f1+f2)*(-d4+f3))* &
         q1)/(d1*(f1*f2-d3*(f1+f2)+d2*(d3-f2-f3)+(f1+f2)*f3)+f1*(f2*(d3-f3)+d2* &
         (-d3+f2+f3))+(f1*f2-d3*(f1+f2)+d2*(d3-f2-f3)+(f1+f2)*f3)*q1)
  end function three_lens

  double complex function four_lens(d1, d2, d3, d4, d5, f1, f2, f3, f4, q1)
    implicit none
    double precision, intent(in) :: d1, d2, d3, d4, d5, f1, f2, f3, f4
    double complex, intent(in) :: q1

    four_lens = -(d1*d5*(d4*(d3*(-d2+f1)+(d2+d3-f1)*f2)+((d3+d4)*(d2-f1)-(d2+d3+d4-f1)*f2)*f3)+ &
         d1*((d4+d5)*(d2*(d3-f2)+f1*f2-d3*(f1+f2))-((d3+d4+d5)*(d2-f1)-(d2+d3+d4+d5-f1)*f2)*f3)*f4- &
         f1*f2*(d3*d5*(d4-f3)-d4*d5*f3-d3*(d4+d5-f3)*f4+(d4+d5)*f3*f4)+d2*(d4*d5*(d3-f2)- &
         d5*(d3+d4-f2)*f3-((d4+d5)*(d3-f2)-(d3+d4+d5-f2)*f3)*f4)*(f1-q1)+(d5*f1*f2*f3+ &
         (d5*f1*f2-f1*f2*f3+d5*(f1+f2)*f3)*f4+d4*(f2*f3+f1*(f2+f3))*(-d5+f4)+d3*(f1+f2)*(d4*(d5-f4)+ &
         f3*f4-d5*(f3+f4)))*q1)/(f1*f2*(d3*(d4-f3-f4)+f3*(-d4+f4))+d1*(d4*f1*f2+d4*f1*f3+d4*f2*f3-  &
         f1*f2*f3-(f2*f3+f1*(f2+f3))*f4+d3*(f1+f2)*(-d4+f3+f4)+d2*(f2*f3-d4*(f2+f3)+d3*(d4-f3-f4)+ &
         (f2+f3)*f4))+(d4*f1*f2+d4*f1*f3+d4*f2*f3-f1*f2*f3-(f2*f3+f1*(f2+f3))*f4+d3*(f1+f2)* &
         (-d4+f3+f4))*q1+d2*(f2*f3-d4*(f2+f3)+d3*(d4-f3-f4)+(f2+f3)*f4)*(-f1+q1))
  end function four_lens

  double complex function c2w_1lens(d1, d2, d_crys,d_d, n, r1, f1, q1)
    implicit none
    double precision, intent(in) :: d1, d2, d_crys, d_d, n, r1, f1
    double complex, intent(in) :: q1


    c2w_1lens = -(((f1-d2)*n*q1+((d_d+d2+d1)*f1-d2*d_d-d1*d2)*n+d_crys*f1-d2* &
     d_crys)*r1+((-2*d2-2*d1)*f1+2*d1*d2)*n*q1+((-2*d2-2*d1)*d_d* &
     f1+2*d1*d2*d_d)*n+(-2*d2-2*d1)*d_crys*f1+2*d1*d2*d_crys)/ &
     ((n*q1+(-f1+d_d+d1)*n+d_crys)*r1+(2*f1-2*d1)*n*q1+(2*d_d* &
     f1-2*d1*d_d)*n+2*d_crys*f1-2*d1*d_crys)

  end function c2w_1lens

  double complex function c2w_2lens(d1, d2, d3, d_crys, d_d, n, r1, f1, f2, q1)
    implicit none
    double precision, intent(in) :: d1, d2, d3, d_crys, d_d, n, r1, f1, f2
    double complex, intent(in) :: q1

    c2w_2lens = -((((f1-d3-d2)*f2-d3*f1+d2*d3)*n*q1+(((d_d+d3+d2+d1)*f1+(-d3-d2)* &
     d_d-d1*d3-d1*d2)*f2+((-d2-d1)*d3-d3*d_d)*f1+d2*d3*d_d+d1*d2* &
     d3)*n+(d_crys*f1+(-d3-d2)*d_crys)*f2-d3*d_crys*f1+d2*d3* &
     d_crys)*r1+(((-2*d3-2*d2-2*d1)*f1+2*d1*d3+2*d1*d2)*f2+(2* &
     d2+2*d1)*d3*f1-2*d1*d2*d3)*n*q1+(((-2*d3-2*d2-2*d1)*d_d* &
     f1+(2*d1*d3+2*d1*d2)*d_d)*f2+(2*d2+2*d1)*d3*d_d*f1-2*d1*d2* &
     d3*d_d)*n+((-2*d3-2*d2-2*d1)*d_crys*f1+(2*d1*d3+2*d1*d2)* &
     d_crys)*f2+(2*d2+2*d1)*d3*d_crys*f1-2*d1*d2*d3*d_crys)/ &
     (((f2+f1-d2)*n*q1+((-f1+d_d+d1)*f2+(d_d+d2+d1)*f1-d2*d_d-d1* &
     d2)*n+d_crys*f2+d_crys*f1-d2*d_crys)*r1+((2*f1-2*d1)*f2+(-2* &
     d2-2*d1)*f1+2*d1*d2)*n*q1+((2*d_d*f1-2*d1*d_d)*f2+(-2*d2-2* &
     d1)*d_d*f1+2*d1*d2*d_d)*n+(2*d_crys*f1-2*d1*d_crys)*f2+(-2* &
     d2-2*d1)*d_crys*f1+2*d1*d2*d_crys)

  end function c2w_2lens

  double complex function c2c_1lens(d1, d2, d_crys, d_opo, d_d, n, r2, r1, f1, q1)
    implicit none
    double precision, intent(in) :: d1, d2, d_crys, d_opo, d_d, n, r2, r1, f1
    double complex, intent(in) :: q1

    c2c_1lens = -(((((f1-d_opo-d2)*n**2-d_crys*n)*q1+((d_opo+d_d+d2+d1)* &
     f1+(-d_d-d1)*d_opo-d2*d_d-d1*d2)*n**2+(2*d_crys*f1-d_crys* &
     d_opo-d_crys*d_d+(-d2-d1)*d_crys)*n-d_crys**2)*r1+(((-2* &
     d_opo-2*d2-2*d1)*f1+2*d1*d_opo+2*d1*d2)*n**2+(2*d1*d_crys-2* &
     d_crys*f1)*n)*q1+(((-2*d2-2*d1)*d_d-2*d_d*d_opo)*f1+2*d1* &
     d_d*d_opo+2*d1*d2*d_d)*n**2+((-2*d_crys*d_opo-2*d_crys* &
     d_d+(-2*d2-2*d1)*d_crys)*f1+2*d1*d_crys*d_opo+2*d1*d_crys* &
     d_d+2*d1*d2*d_crys)*n-2*d_crys**2*f1+2*d1*d_crys**2)* &
     r2+(((2*d2*d_opo-2*d_opo*f1)*n**2+(2*d2*d_crys-2*d_crys*f1)* &
     n)*q1+((-2*d_d-2*d2-2*d1)*d_opo*f1+(2*d2*d_d+2*d1*d2)* &
     d_opo)*n**2+((-2*d_crys*d_opo-2*d_crys*d_d+(-2*d2-2*d1)* &
     d_crys)*f1+2*d2*d_crys*d_opo+2*d2*d_crys*d_d+2*d1*d2* &
     d_crys)*n-2*d_crys**2*f1+2*d2*d_crys**2)*r1+(((4*d2+4*d1)* &
     d_opo*f1-4*d1*d2*d_opo)*n**2+((4*d2+4*d1)*d_crys*f1-4*d1*d2* &
     d_crys)*n)*q1+((4*d2+4*d1)*d_d*d_opo*f1-4*d1*d2*d_d*d_opo)* &
     n**2+(((4*d2+4*d1)*d_crys*d_opo+(4*d2+4*d1)*d_crys*d_d)* &
     f1-4*d1*d2*d_crys*d_opo-4*d1*d2*d_crys*d_d)*n+(4*d2+4*d1)* &
     d_crys**2*f1-4*d1*d2*d_crys**2)/ &
     (((n**2*q1+(-f1+d_d+d1)*n**2+d_crys*n)*r1+(2*f1-2*d1)*n**2* &
     q1+(2*d_d*f1-2*d1*d_d)*n**2+(2*d_crys*f1-2*d1*d_crys)*n)* &
     r2+((2*f1-2*d2)*n**2*q1+((2*d_d+2*d2+2*d1)*f1-2*d2*d_d-2*d1* &
     d2)*n**2+(2*d_crys*f1-2*d2*d_crys)*n)*r1+((-4*d2-4*d1)*f1+4* &
     d1*d2)*n**2*q1+((-4*d2-4*d1)*d_d*f1+4*d1*d2*d_d)*n**2+((-4* &
     d2-4*d1)*d_crys*f1+4*d1*d2*d_crys)*n)

  end function c2c_1lens

  double complex function w2c(d, d_crys, d_opo, n, r2, q1)
    implicit none
    double precision, intent(in) :: d, d_crys, d_opo, n, r2
    double complex, intent(in) :: q1
    w2c = ((n*q1+(d_opo+d)*n+d_crys)*r2+(-2*d_opo*n-2*d_crys)*q1-2*d*d_opo* &
     n-2*d*d_crys)/(n*r2-2*n*q1-2*d*n)
  end function w2c

  double complex function w2cm(d, d_crys, d_opo, n, f2, q1)
    implicit none
    double precision, intent(in) :: d, d_crys, d_opo, n, f2
    double complex, intent(in) :: q1
    w2cm = -(((f2-2*d_opo)*n-2*d_crys)*q1+((d_opo+d)*f2-2*d*d_opo)*n+d_crys* &
     f2-2*d*d_crys)/(2*n*q1+(2*d-f2)*n)
  end function w2cm

  double complex function c2c_2lens(d1, d2, d3, d_crys, d_opo, d_d, n, r2, r1, f2, f1, q1)
    implicit none
    double precision, intent(in) :: d1, d2, d3, d_crys, d_opo, d_d, n, r2, r1, f2, f1
    double complex, intent(in) :: q1

    c2c_2lens = -((((((f1-d_opo-d3-d2)*f2+(-d_opo-d3)*f1+d2*d_opo+d2*d3)*n** &
     2+(-d_crys*f2-d_crys*f1+d2*d_crys)*n)* &
     q1+(((d_opo+d_d+d3+d2+d1)*f1+(-d_d-d1)*d_opo+(-d3-d2)* &
     d_d-d1*d3-d1*d2)*f2+((-d_d-d2-d1)*d_opo-d3*d_d+(-d2-d1)*d3)* &
     f1+(d2*d_d+d1*d2)*d_opo+d2*d3*d_d+d1*d2*d3)*n**2+((2*d_crys* &
     f1-d_crys*d_opo-d_crys*d_d+(-d3-d2-d1)*d_crys)*f2+(-d_crys* &
     d_opo-d_crys*d_d+(-d3-d2-d1)*d_crys)*f1+d2*d_crys*d_opo+d2* &
     d_crys*d_d+(d2*d3+d1*d2)*d_crys)*n-d_crys**2*f2-d_crys**2* &
     f1+d2*d_crys**2)*r1+((((-2*d_opo-2*d3-2*d2-2*d1)*f1+2*d1* &
     d_opo+2*d1*d3+2*d1*d2)*f2+((2*d2+2*d1)*d_opo+(2*d2+2*d1)* &
     d3)*f1-2*d1*d2*d_opo-2*d1*d2*d3)*n**2+((2*d1*d_crys-2* &
     d_crys*f1)*f2+(2*d2+2*d1)*d_crys*f1-2*d1*d2*d_crys)*n)* &
     q1+((((-2*d3-2*d2-2*d1)*d_d-2*d_d*d_opo)*f1+2*d1*d_d* &
     d_opo+(2*d1*d3+2*d1*d2)*d_d)*f2+((2*d2+2*d1)*d_d*d_opo+(2* &
     d2+2*d1)*d3*d_d)*f1-2*d1*d2*d_d*d_opo-2*d1*d2*d3*d_d)*n** &
     2+(((-2*d_crys*d_opo-2*d_crys*d_d+(-2*d3-2*d2-2*d1)*d_crys)* &
     f1+2*d1*d_crys*d_opo+2*d1*d_crys*d_d+(2*d1*d3+2*d1*d2)* &
     d_crys)*f2+((2*d2+2*d1)*d_crys*d_opo+(2*d2+2*d1)*d_crys* &
     d_d+(2*d2+2*d1)*d3*d_crys)*f1-2*d1*d2*d_crys*d_opo-2*d1*d2* &
     d_crys*d_d-2*d1*d2*d3*d_crys)*n+(2*d1*d_crys**2-2*d_crys**2* &
     f1)*f2+(2*d2+2*d1)*d_crys**2*f1-2*d1*d2*d_crys**2)* &
     r2+(((((2*d3+2*d2)*d_opo-2*d_opo*f1)*f2+2*d3*d_opo*f1-2*d2* &
     d3*d_opo)*n**2+(((2*d3+2*d2)*d_crys-2*d_crys*f1)*f2+2*d3* &
     d_crys*f1-2*d2*d3*d_crys)*n)*q1+(((-2*d_d-2*d3-2*d2-2*d1)* &
     d_opo*f1+((2*d3+2*d2)*d_d+2*d1*d3+2*d1*d2)*d_opo)*f2+(2*d3* &
     d_d+(2*d2+2*d1)*d3)*d_opo*f1+(-2*d2*d3*d_d-2*d1*d2*d3)* &
     d_opo)*n**2+(((-2*d_crys*d_opo-2*d_crys*d_d+(-2*d3-2*d2-2* &
     d1)*d_crys)*f1+(2*d3+2*d2)*d_crys*d_opo+(2*d3+2*d2)*d_crys* &
     d_d+(2*d1*d3+2*d1*d2)*d_crys)*f2+(2*d3*d_crys*d_opo+2*d3* &
     d_crys*d_d+(2*d2+2*d1)*d3*d_crys)*f1-2*d2*d3*d_crys*d_opo-2* &
     d2*d3*d_crys*d_d-2*d1*d2*d3*d_crys)*n+((2*d3+2*d2)*d_crys** &
     2-2*d_crys**2*f1)*f2+2*d3*d_crys**2*f1-2*d2*d3*d_crys**2)* &
     r1+((((4*d3+4*d2+4*d1)*d_opo*f1+(-4*d1*d3-4*d1*d2)*d_opo)* &
     f2+(-4*d2-4*d1)*d3*d_opo*f1+4*d1*d2*d3*d_opo)*n**2+(((4* &
     d3+4*d2+4*d1)*d_crys*f1+(-4*d1*d3-4*d1*d2)*d_crys)*f2+(-4* &
     d2-4*d1)*d3*d_crys*f1+4*d1*d2*d3*d_crys)*n)*q1+(((4*d3+4* &
     d2+4*d1)*d_d*d_opo*f1+(-4*d1*d3-4*d1*d2)*d_d*d_opo)*f2+(-4* &
     d2-4*d1)*d3*d_d*d_opo*f1+4*d1*d2*d3*d_d*d_opo)*n**2+((((4* &
     d3+4*d2+4*d1)*d_crys*d_opo+(4*d3+4*d2+4*d1)*d_crys*d_d)* &
     f1+(-4*d1*d3-4*d1*d2)*d_crys*d_opo+(-4*d1*d3-4*d1*d2)* &
     d_crys*d_d)*f2+((-4*d2-4*d1)*d3*d_crys*d_opo+(-4*d2-4*d1)* &
     d3*d_crys*d_d)*f1+4*d1*d2*d3*d_crys*d_opo+4*d1*d2*d3*d_crys* &
     d_d)*n+((4*d3+4*d2+4*d1)*d_crys**2*f1+(-4*d1*d3-4*d1*d2)* &
     d_crys**2)*f2+(-4*d2-4*d1)*d3*d_crys**2*f1+4*d1*d2*d3* &
     d_crys**2)/ &
     ((((f2+f1-d2)*n**2*q1+((-f1+d_d+d1)*f2+(d_d+d2+d1)*f1-d2* &
     d_d-d1*d2)*n**2+(d_crys*f2+d_crys*f1-d2*d_crys)*n)*r1+((2* &
     f1-2*d1)*f2+(-2*d2-2*d1)*f1+2*d1*d2)*n**2*q1+((2*d_d*f1-2* &
     d1*d_d)*f2+(-2*d2-2*d1)*d_d*f1+2*d1*d2*d_d)*n**2+((2*d_crys* &
     f1-2*d1*d_crys)*f2+(-2*d2-2*d1)*d_crys*f1+2*d1*d2*d_crys)* &
     n)*r2+(((2*f1-2*d3-2*d2)*f2-2*d3*f1+2*d2*d3)*n**2*q1+(((2* &
     d_d+2*d3+2*d2+2*d1)*f1+(-2*d3-2*d2)*d_d-2*d1*d3-2*d1*d2)* &
     f2+((-2*d2-2*d1)*d3-2*d3*d_d)*f1+2*d2*d3*d_d+2*d1*d2*d3)*n** &
     2+((2*d_crys*f1+(-2*d3-2*d2)*d_crys)*f2-2*d3*d_crys*f1+2*d2* &
     d3*d_crys)*n)*r1+(((-4*d3-4*d2-4*d1)*f1+4*d1*d3+4*d1*d2)* &
     f2+(4*d2+4*d1)*d3*f1-4*d1*d2*d3)*n**2*q1+(((-4*d3-4*d2-4* &
     d1)*d_d*f1+(4*d1*d3+4*d1*d2)*d_d)*f2+(4*d2+4*d1)*d3*d_d* &
     f1-4*d1*d2*d3*d_d)*n**2+(((-4*d3-4*d2-4*d1)*d_crys*f1+(4*d1* &
     d3+4*d1*d2)*d_crys)*f2+(4*d2+4*d1)*d3*d_crys*f1-4*d1*d2*d3* &
     d_crys)*n)

  end function c2c_2lens

  double complex function cmc_1lens(d1, d2, d_crys, d_opo, d_d, n, c2, c1, f1, q1)
    implicit none
    double precision, intent(in) :: d1, d2, d_crys, d_opo, d_d, n, c2, c1, f1
    double complex, intent(in) :: q1

  cmc_1lens = (((((d2+d1-c2-c1)*d_opo-c2*d2-c2*d1+c1*c2)*f1+((c1-d1)*d2+c2* &
     d1-c1*c2)*d_opo+(c2*d1-c1*c2)*d2)*n**2+((d2+d1-c2-c1)* &
     d_crys*f1+((c1-d1)*d2+c2*d1-c1*c2)*d_crys)*n)* &
     q1+((((d2+d1-c2-c1)*d_d-c1*d2-c1*d1+c1*c2)*d_opo+(-c2*d2-c2* &
     d1+c1*c2)*d_d+c1*c2*d2+c1*c2*d1)*f1+(((c1-d1)*d2+c2*d1-c1* &
     c2)*d_d+c1*d1*d2-c1*c2*d1)*d_opo+(c2*d1-c1*c2)*d2*d_d-c1*c2* &
     d1*d2)*n**2+(((d2+d1-c2-c1)*d_crys*d_opo+(d2+d1-c2-c1)* &
     d_crys*d_d+((-c2-c1)*d2+(-c2-c1)*d1+2*c1*c2)*d_crys)* &
     f1+((c1-d1)*d2+c2*d1-c1*c2)*d_crys*d_opo+((c1-d1)*d2+c2* &
     d1-c1*c2)*d_crys*d_d+(((c2+c1)*d1-c1*c2)*d2-c1*c2*d1)* &
     d_crys)*n+(d2+d1-c2-c1)*d_crys**2*f1+((c1-d1)*d2+c2*d1-c1* &
     c2)*d_crys**2)/ &
     (((d2+d1-c2-c1)*f1+(c1-d1)*d2+c2*d1-c1*c2)*n**2* &
     q1+(((d2+d1-c2-c1)*d_d-c1*d2-c1*d1+c1*c2)*f1+((c1-d1)*d2+c2* &
     d1-c1*c2)*d_d+c1*d1*d2-c1*c2*d1)*n**2+((d2+d1-c2-c1)*d_crys* &
     f1+((c1-d1)*d2+c2*d1-c1*c2)*d_crys)*n)

  end function cmc_1lens

  double complex function cmc_2lens(d1, d2, d3, d_crys, d_opo, d_d, n, c2, c1, f2, f1, q1)
    implicit none
    double precision, intent(in) :: d1, d2, d3, d_crys, d_opo, d_d, n, c2, c1, f2, f1
    double complex, intent(in) :: q1

  cmc_2lens = ((((((d3+d2+d1-c2-c1)*d_opo-c2*d3-c2*d2-c2*d1+c1*c2)*f1+((c1-d1)* &
     d3+(c1-d1)*d2+c2*d1-c1*c2)*d_opo+(c2*d1-c1*c2)*d3+(c2*d1-c1* &
     c2)*d2)*f2+(((-d2-d1+c1)*d3+c2*d2+c2*d1-c1*c2)*d_opo+(c2* &
     d2+c2*d1-c1*c2)*d3)*f1+((d1-c1)*d2*d3+(c1*c2-c2*d1)*d2)* &
     d_opo+(c1*c2-c2*d1)*d2*d3)*n**2+(((d3+d2+d1-c2-c1)*d_crys* &
     f1+((c1-d1)*d3+(c1-d1)*d2+c2*d1-c1*c2)*d_crys)* &
     f2+((-d2-d1+c1)*d3+c2*d2+c2*d1-c1*c2)*d_crys*f1+((d1-c1)*d2* &
     d3+(c1*c2-c2*d1)*d2)*d_crys)*n)*q1+(((((d3+d2+d1-c2-c1)* &
     d_d-c1*d3-c1*d2-c1*d1+c1*c2)*d_opo+(-c2*d3-c2*d2-c2*d1+c1* &
     c2)*d_d+c1*c2*d3+c1*c2*d2+c1*c2*d1)*f1+(((c1-d1)*d3+(c1-d1)* &
     d2+c2*d1-c1*c2)*d_d+c1*d1*d3+c1*d1*d2-c1*c2*d1)*d_opo+((c2* &
     d1-c1*c2)*d3+(c2*d1-c1*c2)*d2)*d_d-c1*c2*d1*d3-c1*c2*d1*d2)* &
     f2+((((-d2-d1+c1)*d3+c2*d2+c2*d1-c1*c2)*d_d+(c1*d2+c1*d1)* &
     d3-c1*c2*d2-c1*c2*d1)*d_opo+(c2*d2+c2*d1-c1*c2)*d3*d_d+(-c1* &
     c2*d2-c1*c2*d1)*d3)*f1+(((d1-c1)*d2*d3+(c1*c2-c2*d1)*d2)* &
     d_d-c1*d1*d2*d3+c1*c2*d1*d2)*d_opo+(c1*c2-c2*d1)*d2*d3* &
     d_d+c1*c2*d1*d2*d3)*n**2+((((d3+d2+d1-c2-c1)*d_crys* &
     d_opo+(d3+d2+d1-c2-c1)*d_crys*d_d+((-c2-c1)*d3+(-c2-c1)* &
     d2+(-c2-c1)*d1+2*c1*c2)*d_crys)*f1+((c1-d1)*d3+(c1-d1)* &
     d2+c2*d1-c1*c2)*d_crys*d_opo+((c1-d1)*d3+(c1-d1)*d2+c2* &
     d1-c1*c2)*d_crys*d_d+(((c2+c1)*d1-c1*c2)*d3+((c2+c1)*d1-c1* &
     c2)*d2-c1*c2*d1)*d_crys)*f2+(((-d2-d1+c1)*d3+c2*d2+c2*d1-c1* &
     c2)*d_crys*d_opo+((-d2-d1+c1)*d3+c2*d2+c2*d1-c1*c2)*d_crys* &
     d_d+(((c2+c1)*d2+(c2+c1)*d1-c1*c2)*d3-c1*c2*d2-c1*c2*d1)* &
     d_crys)*f1+((d1-c1)*d2*d3+(c1*c2-c2*d1)*d2)*d_crys* &
     d_opo+((d1-c1)*d2*d3+(c1*c2-c2*d1)*d2)*d_crys* &
     d_d+(((-c2-c1)*d1+c1*c2)*d2*d3+c1*c2*d1*d2)*d_crys)* &
     n+((d3+d2+d1-c2-c1)*d_crys**2*f1+((c1-d1)*d3+(c1-d1)*d2+c2* &
     d1-c1*c2)*d_crys**2)*f2+((-d2-d1+c1)*d3+c2*d2+c2*d1-c1*c2)* &
     d_crys**2*f1+((d1-c1)*d2*d3+(c1*c2-c2*d1)*d2)*d_crys**2)/ &
     ((((d3+d2+d1-c2-c1)*f1+(c1-d1)*d3+(c1-d1)*d2+c2*d1-c1*c2)* &
     f2+((-d2-d1+c1)*d3+c2*d2+c2*d1-c1*c2)*f1+(d1-c1)*d2*d3+(c1* &
     c2-c2*d1)*d2)*n**2*q1+((((d3+d2+d1-c2-c1)*d_d-c1*d3-c1* &
     d2-c1*d1+c1*c2)*f1+((c1-d1)*d3+(c1-d1)*d2+c2*d1-c1*c2)* &
     d_d+c1*d1*d3+c1*d1*d2-c1*c2*d1)*f2+(((-d2-d1+c1)*d3+c2* &
     d2+c2*d1-c1*c2)*d_d+(c1*d2+c1*d1)*d3-c1*c2*d2-c1*c2*d1)* &
     f1+((d1-c1)*d2*d3+(c1*c2-c2*d1)*d2)*d_d-c1*d1*d2*d3+c1*c2* &
     d1*d2)*n**2+(((d3+d2+d1-c2-c1)*d_crys*f1+((c1-d1)* &
     d3+(c1-d1)*d2+c2*d1-c1*c2)*d_crys)*f2+((-d2-d1+c1)*d3+c2* &
     d2+c2*d1-c1*c2)*d_crys*f1+((d1-c1)*d2*d3+(c1*c2-c2*d1)*d2)* &
     d_crys)*n)
  end function cmc_2lens

end module transforms




