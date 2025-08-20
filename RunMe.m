close all;
f  = @(x) tanh(x) + 0.2*x.*exp(-0.1*x.^2) + 0.3*sin(2.5*x);
df = @(x) sech(x).^2 + 0.2*(1 - 0.2*x.^2).*exp(-0.1*x.^2) + 0.75*cos(2.5*x);

x0_list = [-6, -3.2, -1, -0.2, 0.05, 0.8, 1.8, 2.3, 3.14, 3.5, 4.2, 5.5];
alpha = 0.1; tol = 1e-4; max_iter = 500;

results = strings(length(x0_list)+1, 5);
results(1,:) = ["x0", "x*", "f(x*)", "iters", "status"];

figure; hold on; box on;
xs = linspace(-8, 8, 100000);
plot(xs, f(xs), 'LineWidth', 1.5, 'DisplayName', 'f(x)'); xlabel('x'); ylabel('f(x)'); title('一维多极值函数及梯度下降收敛点'); grid minor;

for i = 1 : length(x0_list)
    x0 = x0_list(i);
    [x_star, f_star, iters, status, traj] = grad_descent(f, df, x0, alpha, tol, max_iter);
    results(i+1,:) = [num2str(x0), num2str(x_star), num2str(f_star), num2str(iters), status];
    plot(traj, f(traj), '-o', 'MarkerSize', 4, 'LineWidth', 1.0, 'DisplayName', sprintf('x0=%.2f', x0));
end
legend show;

disp('不同初始点的收敛结果：');
disp(results);