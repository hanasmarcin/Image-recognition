function rds = reduce(ds, parts)
% Funkcja redukcji liczby pr�bek poszczeg�lnych klas w zbiorze ds
% ds - zbi�r danych do redukcji; pierwsza kolumna zawiera etykiet�
% parts - wierszowy wektor wsp�czynnik�w redukcji dla poszczeg�lnych klas

	labels = unique(ds(:,1));
	if rows(labels) ~= columns(parts)
		error("Liczba klas nie zgadza sie z liczba wsp. redukcji.");
	end

	if max(parts) > 1 || min(parts) < 0
		error("Niewlasciwe wspolczynniki redukcji.");
	end
		
	% zdecydowanie wypadaloby uzyc randperm do mieszania probek w klasach
	% ta implementacja jest daleka od doskonalosci
  rows_count = 0;
  for i = 1:rows(labels)
    sample_count = sum(ds(:, 1) == labels(i));
    rows_count = rows_count + round(parts(i) * sample_count);
  end
  
  rds = zeros(rows_count, columns(ds));
  id = 0;
  for i = 1:rows(labels)
    sample_count = sum(ds(:, 1) == labels(i));
    samples = ds(ds(:, 1) == labels(i), :);
    rds(id+1:id+round(parts(i)*sample_count), :) = samples(randperm(rows(samples), round(parts(i) * sample_count)), :);
    id = id+round(parts(i)*sample_count);
  end

end
