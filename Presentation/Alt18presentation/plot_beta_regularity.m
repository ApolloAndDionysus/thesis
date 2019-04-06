function plot_beta_regularity()
% Generates a plot showing beta regularity.
% Also generates plots for alpha, alpha/epsilon goals.

pd = gmdistribution([.5; .6; .7; .8], ...
    cat(3, .0003, .0001, .0004, .0005), ...
    [.4; .1; .4; .1]);

mu_star = 1;
beta = 2;
E1 = 1/20;
E2 = 5;

x = linspace(0, mu_star, 1000)';
y = pd.pdf(x);

cumy = cumsum(y) / sum(y);

alpha = 0.05;
epsilon = 0.05;

x_alpha = x(find(cumy >= 1 - alpha, 1));
x_eps = x_alpha - epsilon;

f = figure('Visible','off');
% f = figure;
hold on;
% fc = hex2rgb('#666666');
plot(x, y, '-', 'Color', hex2rgb('#800000'));
ys = ylim;
plot([x_alpha x_alpha], ys, '--', 'Color', hex2rgb('#666666'));
% title('Beta Regularity');
xlabel('\mu');
ylabel('PDF');

save_plot(f, 'goal_alpha');

plot([x_eps x_eps], ys, '--', 'Color', hex2rgb('#666666'));
hold off;
save_plot(f, 'goal_alpha_eps');
% close(f);



f = figure('Visible','off');
% f = figure;
hold on;
rho = linspace(0, mu_star, 1000);
x = mu_star - rho';
y = 1 - pd.cdf(x);
% fc = hex2rgb('#666666');
plot(x, y, '-', 'Color', hex2rgb('#800000'));
plot(x, E1 * rho .^ beta, '--', 'Color', hex2rgb('#666666'));
plot(x, E2 * rho .^ beta, '--', 'Color', hex2rgb('#666666'));
title('Beta Regularity');
xlabel('\mu* - \rho');
ylabel('Probability');
% legend({'1 - CDF', 'LB', 'UB'});
ylim([0 1.2]);
hold off;

save_plot(f, 'beta_regularity');
close(f);

end

