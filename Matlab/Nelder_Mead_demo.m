% Nelder_Mead_demo.m
% Press space bar each iteration.
max_iter = 8;
simp_edge = 1;

%F=@(x,y) (x-1).^2 + 100*(y-x.^2).^2;  % Rosenbrock
F=@(x,y) 2*(x-1).^2+6*(y-1).^2 + 6*abs(x/4+0.6-y); %non-differentiable
x=linspace(-1.1,2.2,200);y=x;[X,Y]=meshgrid(x,y);
Z=F(X,Y);
figure(1),clf
contour(X,Y,Z,50,'k','LineWidth',0.5);
axis square
hold on
f = @(x) F(x(1),x(2));
x0 = [-1 -1];
simplex = x0 + [0 0; simp_edge 0; 0 simp_edge];  % Initial simplex in R^2
[x_min, iter] = nelder_mead(f, simplex, 2, 3, 0.5, 0.5, 1e-2, max_iter, 1, 1);
disp('Approximate minimizer:');
disp(x_min);
