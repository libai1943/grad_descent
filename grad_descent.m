function [x_star, f_star, iters, status, traj] = grad_descent(f, df, x0, alpha, tol, max_iter)
x = x0;
traj = x;
for k = 1:max_iter
    g = df(x);
    if abs(g) < tol
        x_star = x; f_star = f(x);
        iters = k; status = "converged"; return;
    end
    x_new = x - alpha * g;
    if ~isfinite(x_new) || abs(x_new) > 1e6
        x_star = x; f_star = f(x);
        iters = k; status = "diverged"; return;
    end
    if abs(x_new - x) < tol
        x_star = x_new; f_star = f(x_new);
        iters = k; status = "converged"; return;
    end
    x = x_new;
    traj(end+1) = x;
end
x_star = x; f_star = f(x);
iters = max_iter; status = "max_iter";
end