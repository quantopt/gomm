#!/usr/bin/python


def raw_one_lens(d1, d2, f, q):
    return d2 + f*(d1+q)/(f-d1-q)

def raw_two_lens(d1, d2, d3,f1, f2, q1):
    n = d1*d3*(d2-f1)-d1*(d2+d3-f1)*f2+d3*f1*f2-d2*(d3-f2)*(f1-q1)-d3*f1*q1-d3*f2*q1+f1*f2*q1
    d = d1*(d2-f1-f2)+f1*f2-(f1+f2)*q1+d2*(q1-f1)
    return n/d

def raw_two_lens_mirror(d1, d2, d3, d4, f1, f2, r, q1):
    n = (2*d1*d4*(d2*(d3-f2)+f1*f2-d3*(f1+f2))+2*d4*(d3*f1*f2+f1*f2*q1-d3*(f1+f2)*q1)- \
         d1*((d3+d4)*(d2-f1)-(d2+d3+d4-f1)*f2)*r-((d3+d4)*f1*f2-((d3+d4)*f1+(d3+d4-f1)*f2)*q1)*r \
         +d2*(f1-q1)*(-2*d4*(d3-f2)+(d3+d4-f2)*r))
    d = (2*d3*f1*f2-2*d3*f1*q1-2*d3*f2*q1+2*f1*f2*q1-f1*f2*r+f1*q1*r+f2*q1*r+ \
    d2*(f1-q1)*(-2*d3+2*f2+r)+d1*(2*d3*(d2-f1)-2*(d2+d3-f1)*f2+(-d2+f1+f2)*r))
    return n/d

def raw_three_lens(d1, d2, d3, d4, f1, f2, f3, q1):
    return (d1*d4*(d2*(d3-f2)+f1*f2-d3*(f1+f2))-d1*((d3+d4)*(d2-f1)-(d2+d3+d4-f1)*f2)*f3+  \
      f1*f2*(d3*d4-(d3+d4)*f3)-d2*(d3*(d4-f3)+f2*f3-d4*(f2+f3))*(f1-q1)+(d4*f1*f2-f1*f2*f3+ \
      d4*(f1+f2)*f3+d3*(f1+f2)*(-d4+f3))*q1)/(d1*(f1*f2-d3*(f1+f2)+d2*(d3-f2-f3)+(f1+f2)*f3)+ \
      f1*(f2*(d3-f3)+d2*(-d3+f2+f3))+(f1*f2-d3*(f1+f2)+d2*(d3-f2-f3)+(f1+f2)*f3)*q1)

def raw_four_lens(d1, d2, d3, d4,d5, f1, f2, f3, f4, q1):
    return -(d1*d5*(d4*(d3*(-d2+f1)+(d2+d3-f1)*f2)+((d3+d4)*(d2-f1)-(d2+d3+d4-f1)*f2)*f3)+ \
        d1*((d4+d5)*(d2*(d3-f2)+f1*f2-d3*(f1+f2))-((d3+d4+d5)*(d2-f1)-(d2+d3+d4+d5-f1)*f2)*f3)*f4-\
        f1*f2*(d3*d5*(d4-f3)-d4*d5*f3-d3*(d4+d5-f3)*f4+(d4+d5)*f3*f4)+d2*(d4*d5*(d3-f2)- \
        d5*(d3+d4-f2)*f3-((d4+d5)*(d3-f2)-(d3+d4+d5-f2)*f3)*f4)*(f1-q1)+(d5*f1*f2*f3+ \
        (d5*f1*f2-f1*f2*f3+d5*(f1+f2)*f3)*f4+d4*(f2*f3+f1*(f2+f3))*(-d5+f4)+d3*(f1+f2)*(d4*(d5-f4)+ \
        f3*f4-d5*(f3+f4)))*q1)/(f1*f2*(d3*(d4-f3-f4)+f3*(-d4+f4))+d1*(d4*f1*f2+d4*f1*f3+d4*f2*f3-  \
        f1*f2*f3-(f2*f3+f1*(f2+f3))*f4+d3*(f1+f2)*(-d4+f3+f4)+d2*(f2*f3-d4*(f2+f3)+d3*(d4-f3-f4)+ \
        (f2+f3)*f4))+(d4*f1*f2+d4*f1*f3+d4*f2*f3-f1*f2*f3-(f2*f3+f1*(f2+f3))*f4+d3*(f1+f2)* \
        (-d4+f3+f4))*q1+d2*(f2*f3-d4*(f2+f3)+d3*(d4-f3-f4)+(f2+f3)*f4)*(-f1+q1))

def raw_three_lens_mirror(d1, d2, d3, d4, d5, f1, f2, f3, r, q1):
    pass 

## def raw_four_lens_cavity(d1, d2, d3, d4, d5, d6, f1, f2, f3, f4, r, q1):
##     return (((d6*((d1*((d4*f1*f2+d4*f1*f3+d4*f2*f3-f1*f2*f3-((f2*f3+f1*((f2+f3))))*f4+d3*((f1+f2))* \
##     (((-d4)+f3+f4))+d2((f2*f3-d4((f2+f3))+d3*((d4-f3-f4))+((f2+f3))*f4))))-f1*((d2*((f2*f3-d4* \
##     ((f2+f3))+d3((d4-f3-f4))+((f2+f3))*f4))+f2*((f3*((d4-f4))+d3*(((-d4)+f3+f4))))))))+q1*((d6* \
##     ((d4*f1*f2+d4*f1*f3+d4*f2*f3-f1*f2*f3-((f2*f3+f1*((f2+f3))))*f4+d3*((f1+f2))*(((-d4)+f3+f4))+ \
##     d2*((f2*f3-d4*((f2+f3))+d3*((d4-f3-f4))+((f2+f3))*f4))))+((d4*d5*((d2*((d3-f2))+f1*f2-d3*((f1+ \
##     f2))))-d5*((((d3+d4))*((d2-f1))-((d2+d3+d4-f1))*f2))*f3-((((d4+d5))*((d2*((d3-f2))+f1*f2-d3*((f1+ \
##     f2))))-((((d3+d4+d5))*((d2-f1))-((d2+d3+d4+d5-f1))*f2))*f3))*f4))*((1-(2*d6)/r))))+((1/r)*((((d5* \
##     f1*((d2*d4*((d3-f2))-d3*d4*f2-d2*((d3+d4-f2))*f3+((d3+d4))*f2*f3))+d1*d5*((d4*((d3*(((-d2)+f1))+ \
##     ((d2+d3-f1))*f2))+((((d3+d4))*((d2-f1))-((d2+d3+d4-f1))*f2))*f3))-f1*((((d4+d5))*((d2*d3-((d2+ \
##     *d3))*f2))-((d2*((d3+d4+d5))-((d2+d3+d4+d5))*f2))*f3))*f4+d1*((((d4+d5))*((d2*((d3-f2))+f1*f2- \
##     d3*((f1+f2))))-((((d3+d4+d5))*((d2-f1))-((d2+d3+d4+d5-f1))*f2))*f3))*f4))*((2*d6-r)))))))/((d1* \
##     ((d4*f1*f2+d4*f1*f3+d4*f2*f3-f1*f2*f3-((f2*f3+f1*((f2+f3))))*f4+d3*((f1+f2))*(((-d4)+f3+f4))+ \
##     d2*((f2*f3-d4((f2+f3))+d3*((d4-f3-f4))+((f2+f3))*f4))))-f1*((d2*((f2*f3-d4*((f2+f3))+d3*((d4- \
##     f3-f4))+((f2+f3))*f4))+f2*((f3*((d4-f4))+d3*(((-d4)+f3+f4))))))+q1*((d4*f1*f2+d4*f1*f3+d4*f2*f3- \
##     f1*f2*f3-((f2*f3+f1*((f2+f3))))*f4+d3*((f1+f2))*(((-d4)+f3+f4))+d2*((f2*f3-d4*((f2+f3))+d3*((d4- \
##     f3-f4))+((f2+f3))*f4))+((1/r)*((2*d5*((d4*(((-f1)*f2+d2*(((-d3)+f2))+d3*((f1+f2))))+((((d3+ \
##     d4))*((d2-f1))-((d2+d3+d4-f1))*f2))*f3))+2*((((d4+d5))*((d2*((d3-f2))+f1*f2-d3*((f1+f2))))-((((d3+ \
##     d4+d5))*((d2-f1))-((d2+d3+d4+d5-f1))*f2))*f3))*f4)))))+((1/r)*((2*((d5*f1*((d2*d4*((d3-f2))-d3*d4* \
##     f2-d2*((d3+d4-f2))*f3+((d3+d4))*f2*f3))+d1*d5*((d4*((d3*(((-d2)+f1))+((d2+d3-f1))*f2))+((((d3+ \
##     d4))*((d2-f1))-((d2+d3+d4-f1))*f2))*f3))-f1*((((d4+d5))*((d2*d3-((d2+d3))*f2))-((d2*((d3+d4+ \
##     d5))-((d2+d3+d4+d5))*f2))*f3))*f4+d1*((((d4+d5))*((d2*((d3-f2))+f1*f2-d3*((f1+f2))))-((((d3+d4+ \
##     d5))*((d2-f1))-((d2+d3+d4+d5-f1))*f2))*f3))*f4))))))))
