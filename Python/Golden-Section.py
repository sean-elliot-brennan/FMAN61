import sympy as sp
import math
def goldensection (a , b, function, tol= 0.0001):
    x1 = b - 0.618*(b-a)
    x2 = a + 0.618*(b-a)
    fx1 = function.subs(x, x1)
    fx2 = function.subs(x, x2)
    interval_length = abs(a -b)
    if(interval_length < tol ):
        return (a + b )/2
    if(fx2 > fx1):
        return goldensection(a, x2, function, tol)
    else: return goldensection(x1, b, function, tol) 
    
x = sp.symbols("x")
function1 = x**2 + 2* x**2 - 5*x
print(goldensection(-100, 100,function1) )