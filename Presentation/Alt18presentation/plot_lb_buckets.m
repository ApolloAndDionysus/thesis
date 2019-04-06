function plot_lb_buckets()
% Generates a plot showing the reservoir buckets for the lower bound.

mu = 0.5;
sigma = 0.25;
lb = 0; ub = 0.95;
pd = truncate(makedist('normal', mu, sigma), lb, ub);

alpha = 0.1;
bi = zeros(ceil(1/alpha) + 1,1);
bi(1) = ub;
bi(end) = lb;
blabels = cell(size(bi));
% blabels{1} = sprintf('\\mu^* = %0.2f', ub);
blabels{1} = sprintf('\\mu^* = b_0', ub);
for i = 2:length(bi)-1
    bi(i) = pd.icdf(pd.cdf(bi(i-1)) - alpha);
    blabels{i} = sprintf('b_{%d}', i - 1);
%     blabels{i} = sprintf('%0.2f', (bi(i) - lb) / (ub - lb));
end

f = figure('Visible','off');
% f = figure;
hold on;
x = linspace(floor(lb), ceil(ub), 1000);
y = pd.cdf(x);
fx = [x x(end) x(1) x(1)];
fy = [y 0 0 y(1)];
fc = hex2rgb('#666666');
fill(fx, fy, fc, 'FaceAlpha', 0.3, 'EdgeColor', fc);
plot(x, y, '-', 'Color', hex2rgb('#800000'));
for i = 1:length(bi)
    plot([bi(i) bi(i) 0], [0 pd.cdf(bi(i)) pd.cdf(bi(i))], 'k:');
    if i > 1
        if i == length(bi)
            x = bi(i-1) - 0.06;
        else
            x = mean(bi(i-1:i)) - 0.015;
        end
        text(x, 0.05, sprintf('S^{%d}', i-1), 'FontSize', 12);
        text(lb + 0.01, mean(pd.cdf(bi(i-1:i))), '\alpha');
    end
end
ax = gca;
ax.XTick = bi(end:-1:1);
ax.XTickLabel = blabels(end:-1:1);
% title('Reservoir Buckets for \alpha = 0.1');
xlabel('Coin Bias');
ylabel('CDF');
hold off;

save_plot(f, 'lb_buckets_cdf');
close(f);


f = figure('Visible','off');
% f = figure;
hold on;
x = linspace(floor(lb), ceil(ub), 1000);
y = pd.pdf(x);
fx = [x x(end) x(1) x(1)];
fy = [y 0 0 y(1)];
fc = hex2rgb('#666666');
fill(fx, fy, fc, 'FaceAlpha', 0.3, 'EdgeColor', fc);
plot(x, y, '-', 'Color', hex2rgb('#800000'));
for i = 1:length(bi)
    plot([bi(i) bi(i)], [0 pd.pdf(bi(i))], 'k:');
    if i > 1
        x = mean(bi(i-1:i)) - 0.015;
        text(x, 0.1, sprintf('S^{%d}', i-1), 'FontSize', 12);
    end
end
ax = gca;
ax.XTick = bi(end:-1:1);
ax.XTickLabel = blabels(end:-1:1);
% title('Reservoir Buckets for \alpha = 0.1');
xlabel('Coin Bias');
ylabel('PDF');
hold off;

save_plot(f, 'lb_buckets_pdf');
close(f);

end

