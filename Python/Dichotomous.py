import sympy as sp
import math
def dichotomous (a , b, function, epsilon ,tol= 0.0001):

    midpoint = (a + b)/2
    print(midpoint)
    x1 = midpoint + epsilon
    x2 = midpoint - epsilon
    fx1 = function.subs(x, x1)
    fx2 = function.subs(x, x2)
    interval_length = abs(a -b)
    if(interval_length < tol ):
        return (a + b )/2
    if(fx2 > fx1):
        return dichotomous(a, x2, function, tol)
    else: return dichotomous(x1, b, function, tol)
    
x = sp.symbols("x")
function1 = x**2 + 2* x**2 - 5*x
print(dichotomous(-100, 100,function1, 0.0001) )