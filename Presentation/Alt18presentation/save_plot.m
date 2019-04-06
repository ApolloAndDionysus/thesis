function save_plot(f, filename)

addpath export_fig;

f.Color = 'w';
f.CurrentAxes.LineWidth = max(f.CurrentAxes.LineWidth,2);
for i=1:length(f.CurrentAxes.Children)
    f.CurrentAxes.Children(i).LineWidth = max(f.CurrentAxes.Children(i).LineWidth,2);
    if isprop(f.CurrentAxes.Children(i),'FontSize')
        f.CurrentAxes.Children(i).FontSize = 16;
    end
end
f.CurrentAxes.Title.FontSize = 20;

savefig(f, sprintf('%s.fig', filename));
export_fig(f, sprintf('%s.pdf', filename), '-pdf');

end
