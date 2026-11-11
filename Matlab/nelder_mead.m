function [x_min, iter] = nelder_mead(f, simplex, alpha, beta, gamma, delta, tol, max_iter, prnt, plot2d)
% Nelder-Mead method for unconstrained optimization
% Inputs:
%   f        - function handle to minimize
%   simplex  - (n+1) x n matrix where each row is a point in R^n
%   alpha    - reflection coefficient (e.g., 2)
%   beta     - expansion coefficient (e.g., 3)
%   gamma    - contraction coefficient (e.g., 1.5)
%   delta    - shrink coefficient (e.g., 0.5)
%   tol      - termination tolerance (e.g., 1e-6)
%   max_iter - maximum number of iterations > 3
%   prnt     - print all iterations
%   plot2d   - plot iterations in 2d problem
% Output:
%   x_min    - approximate minimizer

if nargin < 10
    plot2d = 0;
end
if plot2d
    disp(' ')
    disp('Press space bar for next iteration.')
end
if prnt
    disp(' ')
    disp(' Iteration   Func-count         f(x)         Procedure')
end

[n1, n] = size(simplex);  % n1 equals n+1

% Evaluate function at initial simplex vertices
f_vals = zeros(n1, 1);
for i = 1:n1
    f_vals(i) = f(simplex(i, :));
end
func_evals = n1;

if prnt
    fprintf(' %5.0f        %5.0f     %12.6g         %s\n', 3, func_evals, f_vals(1), '');
end

if plot2d   % plot initial simplex
    plot([simplex(:,1); simplex(1,1)], [simplex(:,2); simplex(1,2)],'r');
    for i=1:3
        plot(simplex(i,1), simplex(i,2),'ro','Markersize',2, 'LineWidth', 2);
    end
end

for iter = n1+1:max_iter

    % Sort simplex by function values
    [f_vals, idx] = sort(f_vals);
    simplex = simplex(idx, :);
    
    % Check termination criterion
    if f_vals(end)-f_vals(1) < tol...
            && norm(simplex(end,:)-simplex(1,:)) < tol...
            && iter == max_iter
        break;
    end

    % Centroid of best n points
    x_star = mean(simplex(1:end-1, :), 1);
    d = x_star - simplex(end, :);  % direction

    % Compute reflection point
    x_r = simplex(end, :) + alpha * d;
    f_r = f(x_r);
    func_evals = func_evals + 1;

    if f_r <= f_vals(1)     % reflection point good
        % Try expansion
        x_e = simplex(end, :) + beta * d;
        f_e = f(x_e);
        func_evals = func_evals + 1;
        if f_e < f_r
            simplex(end, :) = x_e;  % expand
            f_vals(end) = f_e;
            procedure = 'expand';
        else
            simplex(end, :) = x_r;  % reflect
            f_vals(end) = f_r;
            procedure = 'reflect';
        end
    else
        if f_r < f_vals(n)          % reflection point acceptable
            simplex(end, :) = x_r;  % reflect
            f_vals(end) = f_r;
            procedure = 'reflect';
        else    % reflection point acceptable
            if f_r < f_vals(end)
                % Try outside contraction
                x_co = simplex(end, :) + (1+gamma) * d;
                f_co = f(x_co);
                func_evals = func_evals + 1;
                if f_co <= f_r
                    simplex(end, :) = x_co;
                    f_vals(end) = f_co;
                    procedure = 'contract outside';
                else
                    % Shrink
                    for i = 2:n1
                        simplex(i, :) = simplex(1, :) + delta * (simplex(i, :) - simplex(1, :));
                        f_vals(i) = f(simplex(i, :));
                        func_evals = func_evals + 1;
                        procedure = 'shrink';
                    end
                end
            else
                % Try inside contraction
                x_ci = simplex(end, :) + (1-gamma) * d;
                f_ci = f(x_ci);
                func_evals = func_evals + 1;
                if f_ci < f_vals(end)
                    simplex(end, :) = x_ci;
                    f_vals(end) = f_ci;
                    procedure = 'contract inside';
                else
                    % Shrink
                    for i = 2:n1
                        simplex(i, :) = simplex(1, :) + delta * (simplex(i, :) - simplex(1, :));
                        f_vals(i) = f(simplex(i, :));
                        func_evals = func_evals + 1;
                        procedure = 'shrink';
                    end
                end
            end
        end
    end

    if plot2d
        pause
        plot([simplex(1,1) simplex(end,1) simplex(2,1)], [simplex(1,2) simplex(end,2) simplex(2,2)],'r');
        plot(simplex(end,1), simplex(end,2),'ro','Markersize',2, 'LineWidth', 2);
    end

    if prnt
       fprintf(' %5.0f        %5.0f     %12.6g         %s\n', iter, func_evals, f_vals(1), procedure);
    end
end

[f_vals, idx] = sort(f_vals);
simplex = simplex(idx, :);
x_min = simplex(1, :);
end
