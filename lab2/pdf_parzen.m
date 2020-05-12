function pdf = pdf_parzen_HM(pts, para)
% Aproksymuje wartoœæ gêstoœci prawdopodobieñstwa z wykorzystaniem okna Parzena
% pts zawiera punkty, dla których liczy siê f-cjê gêstoœci (punkt = wiersz)
% para - struktura zawieraj¹ca parametry:
%	para.samples - tablica komórek zawieraj¹ca próbki z poszczególnych klas
%	para.parzenw - szerokoœæ okna Parzena
% pdf - macierz gêstoœci prawdopodobieñstwa
%	liczba wierszy = liczba próbek w pts
%	liczba kolumn = liczba klas

	pdf = zeros(rows(pts), rows(para.samples));
	
	% przy liczeniu gêstoœci warto zastanowiæ siê
	% nad kolejnoœci¹ obliczeñ (pêtli)

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
