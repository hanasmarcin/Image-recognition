function pdf = pdf_parzen_HM(pts, para)
% Aproksymuje warto�� g�sto�ci prawdopodobie�stwa z wykorzystaniem okna Parzena
% pts zawiera punkty, dla kt�rych liczy si� f-cj� g�sto�ci (punkt = wiersz)
% para - struktura zawieraj�ca parametry:
%	para.samples - tablica kom�rek zawieraj�ca pr�bki z poszczeg�lnych klas
%	para.parzenw - szeroko�� okna Parzena
% pdf - macierz g�sto�ci prawdopodobie�stwa
%	liczba wierszy = liczba pr�bek w pts
%	liczba kolumn = liczba klas

	pdf = zeros(rows(pts), rows(para.samples));
	
	% przy liczeniu g�sto�ci warto zastanowi� si�
	% nad kolejno�ci� oblicze� (p�tli)

  for m = 1:rows(para.samples)
    n = rows(para.samples{m});
    h = para.parzenw / sqrt(n);

    for k = 1:rows(pts)
      x = pts(k, :);
        
      sum = 0;
    
      for i = 1:n
        x_i = para.samples{m}(i, :);
        product = 1;
        for j = 1:columns(para.samples{m}) 
          product *= normpdf((x_i(j)), x(j), h);
        end
        sum = sum + product;
      end
      
      pdf(k, m) = sum / n;
    end
  end
  
end
