import sympy as sp
import math
count = 0

def newton(current_x, function ,tol= 0.0001):
    global count
    count = count + 1
    df = sp.diff(function,x)
    df2 = sp.diff(df, x)
    fdx = df.subs( x, current_x)
    fdx2 = df2.subs(x, current_x)

    if(abs(fdx) < tol):
        print(current_x)
        print(fdx)
        return current_x
    new_x = current_x -(fdx/fdx2)
    return newton(new_x, function, tol)
    
x = sp.symbols("x")
function1 = x**2 + 2* x**2 - 5*x 

print(newton(234567,function1) )
print(f'It took {count} attempts,')