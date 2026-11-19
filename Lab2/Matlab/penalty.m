function P = penalty(x,A,b)
    g = A*x -b;
    p= sum(max(0,g));
end