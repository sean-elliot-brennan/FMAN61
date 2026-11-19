function B = barrier(x,A,b)
    g = A*x-B
    B = -sum(1./g);
end