import sympy as sp
import math
def bisection (a , b, function, tol= 0.0001):
    midpoint = (a + b) /2
    df = sp.diff(function, x)
    
    mid_derive = df.subs(x, midpoint)
    if(math.abs(mid_derive) < tol ):
        return midpoint
    if(mid_derive > 0):
        return bisection(a, midpoint, function, tol)
    elif(mid_derive < 0):
        return bisection(midpoint, b, function, tol)
    # else: return midpoint
    
    
x = sp.symbols("x")
function1 = x**2 + 2* x**2 - 5*x
print(bisection(-100, 100,function) )