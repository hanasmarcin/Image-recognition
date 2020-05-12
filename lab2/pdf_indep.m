function pdf = pdf_indep(pts, para)
% Liczy funkcj� g�sto�ci prawdopodobie�stwa przy za�o�eniu, �e cechy s� niezale�ne
% pts zawiera punkty, dla kt�rych liczy si� f-cj� g�sto�ci (punkt = wiersz, bez etykiety!)
% para - struktura zawieraj�ca parametry:
%	para.mu - warto�ci �rednie cech (wiersz na klas�)
%	para.sig - odchylenia standardowe cech (wiersz na klas�)
% pdf - macierz g�sto�ci prawdopodobie�stwa
%	liczba wierszy = liczba pr�bek w pts
%	liczba kolumn = liczba klas

	% znam rozmiar wyniku, wi�c go alokuj�
	pdf = ones(rows(pts), rows(para.mu));
  
	% tu trzeba policzy� warto�� funkcji g�sto�ci
	% jako iloczyn g�sto�ci jednowymiarowych
  for x = 1:rows(pdf)
    for y = 1:columns(pdf)
      for label = 1:columns(para.mu)
        pdf(x, y) = pdf(x, y) .* normpdf(pts(x, label), para.mu(y, label), para.sig(y, label));
      end
    end
  end
  
 end
