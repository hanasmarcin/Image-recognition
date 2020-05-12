
labels = unique(tlab);
Legend=cell(rows(labels),1);
for i = [1 3 4 5 7 8 9 10 2 6]
    tmp = tvec(tlab == labels(i), :);
    %tmp = tmp(1:100, :);
    color = 'b';
    if (labels(i) == 2)
        color = 'g';
    elseif (labels(i) == 6)
        color = 'r';
    end
    plot(tmp(:, 1), tmp(:, 9), '.', 'Color', color, 'MarkerSize', 0.1);
    hold on;
    Legend{i} = sprintf('Klasa %d', labels(i));
end
legend(Legend, 'Location', 'northeastoutside');
xlabel('Cecha 1.');
ylabel('Cecha 2.');
title('Rozk³ad klas w przestrzeni dwóch cech');