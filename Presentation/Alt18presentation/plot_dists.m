function plot_dists()
% plot the probability distributions for the proposal

X = linspace(0,1,1000);
% plot_dist(X,pdf('beta',X,1,1),'Beta(1,1)','beta_1_1');
% plot_dist(X,pdf('beta',X,1,3),'Beta(1,3)','beta_1_3');
plot_dist(X*1000,tradeoff(X, .55),'',...
    'tradeoff', 'Number of Coins', 'Simple Regret');
plot_dist(X*1000,tradeoff(X, 1),'',...
    'tradeoff_reality', 'Number of Coins', 'Simple Regret');

% plot_dist(X,pdf('beta',X,1,3),'Reservoir Distribution','reservoir','Pr(cured)');
end

function Y = tradeoff(X, quant)
Y = (X - quantile(X, quant)) .^ 2 + 0.05;
end

function plot_dist(X,pdf,title_text,fname,x_text,y_text)
if nargin < 5
    x_text = 'Coin Bias';
end
if nargin < 6
    y_text = 'PDF';
end

% Plot a distribution
f = figure('Visible','off');
% f = figure;
hold on;
fx = [X X(end) X(1) X(1)];
fy = [pdf 0 0 pdf(1)];
fc = hex2rgb('#666666');
fill(fx, fy, fc, 'FaceAlpha', 0.3, 'EdgeColor', fc);
plot(X, pdf, '-', 'Color', hex2rgb('#800000'));
title(title_text);
xlabel(x_text);
ylabel(y_text);
if all(pdf == pdf(1))
    ylim([0 2*pdf(1)]);
end
hold off;
save_plot(f, sprintf('%s_pdf',fname));
close(f);

end

