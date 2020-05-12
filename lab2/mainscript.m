% % malutki plik do uruchomienia funkcji pdf
% load pdf_test.txt
% size(pdf_test)
% 
% % ile jest klas? - 2 klasy
% labels = unique(pdf_test(:,1))
% 
% % ile jest pr�bek w ka?dej klasie? - po 10
% [labels'; sum(pdf_test(:,1) == labels')]
% 		  % ^^^ dobrze by?oby pomy�le? o tym wyra?eniu
% 
% % jak uk?adaj? si� pr�bki?
% plot2features(pdf_test, 2, 3)
% 
% 
% pdfindep_para = para_indep(pdf_test);
% % para_indep jest do zaimplementowania, tak ?eby dawa?a:
% 
% % pdfindep_para = DONE
% %  scalar structure containing the fields:
% %    labels =
% %       1
% %       2
% %    mu =
% %       0.7970000   0.8200000
% %      -0.0090000   0.0270000
% %    sig =
% %       0.21772   0.19172
% %       0.19087   0.27179
% 
% % teraz do zaimplementowania jest sama funkcja licz?ca pdf 
% %  przygotowuj?c te dane skorzysta?em z funkcji normpdf
% %  ta funkcja jest zdefiniowana w pakiecie statistics i w mojej
% %  lokalnej konfiguracji musz� najpierw za?adowa? ten pakiet:
% 
% % pkg load statistics % mo?e nie by? konieczne
% pi_pdf = pdf_indep(pdf_test([2 7 12 17],2:end), pdfindep_para)
% 
% %pi_pdf = DONE
% %  1.4700e+000  4.5476e-007
% %  3.4621e+000  4.9711e-005
% %  6.7800e-011  2.7920e-001
% %  5.6610e-008  1.8097e+000
% 
% % wielowymiarowy rozk?ad normalny - parametry ...
% 
% pdfmulti_para = para_multi(pdf_test)
% 
% %pdfmulti_para = DONE
% %  scalar structure containing the fields:
% %    labels =
% %       1
% %       2
% %    mu =
% %       0.7970000   0.8200000
% %      -0.0090000   0.0270000
% %    sig =
% %    ans(:,:,1) =
% %       0.047401   0.018222
% %       0.018222   0.036756
% %    ans(:,:,2) =
% %       0.036432  -0.033186
% %      -0.033186   0.073868  
% 
% % ... i funkcja licz?ca g�sto�?
% % paradoksalnie sytuacja jest tutaj prostsza, bo w pakiecie
% % macie Pa�stwo plik mvnpdf.m zawieraj?cy funkcj�, kt�ra
% % liczy wielowymiarow? funkcj� g�sto�ci prawdobie�stwa rozk?adu
% % normalnego
% 
% pm_pdf = pdf_multi(pdf_test([2 7 12 17],2:end), pdfmulti_para)
% 
% %pm_pdf = DONE
% %  7.9450e-001  6.5308e-017
% %  3.9535e+000  3.8239e-013
% %  1.6357e-009  8.6220e-001
% %  4.5833e-006  2.8928e+000
% 
% % parametry dla aproksymacji oknem Parzena
% % t� funkcj� macie Pa�stwo gotow? - u?ywam w niej cell arrays
% % warto doczyta?: https://octave.org/doc/v4.2.1/Cell-Arrays.html
% 
% pdfparzen_para = para_parzen(pdf_test, 0.5)
% 									 % ^^^ szeroko�? okna
% 
% %pdfparzen_para =
% %  scalar structure containing the fields:
% %    labels =
% %       1
% %       2
% %    samples =
% %    {
% %      [1,1] =
% %         1.10000   0.95000
% %         0.98000   0.61000
% % .....
% %         0.69000   0.93000
% %         0.79000   1.01000
% %      [2,1] =
% %        -0.010000   0.380000
% %         0.250000  -0.440000
% % .....
% %        -0.110000   0.030000
% %         0.120000  -0.090000
% %    }
% %    parzenw =  0.50000
% 
% pp_pdf = pdf_parzen(pdf_test([2 7 12 17],2:end), pdfparzen_para)
% 
% %pp_pdf =
% %  9.7779e-001  6.1499e-008
% %  2.1351e+000  4.2542e-006
% %  9.4059e-010  9.8823e-001
% %  2.0439e-006  1.9815e+000

% wreszcie mo?na zaj?? si? kartami!
% wcze�niejszy fragment mo?na spokojnie usun?? po uruchomieniu
% funkcji licz?cych pdf
[train test] = load_cardsuits_data();
train = train(1:end ~= 642, :);
train = train(1:end ~= 186, :);
test = test(1:end ~= 642, :);
test = test(1:end ~= 186, :);

% pierwszy rzut oka na dane
size(train)
size(test)
labels = unique(train(:,1))
unique(test(:,1))
[labels'; sum(train(:,1) == labels')]

% pierwszym zadaniem po za?adowaniu danych jest sprawdzenie,
% czy w zbiorze ucz?cym nie ma pr�bek odstaj?cych
% do realizacji tego zadania przydadz? si� funkcje licz?ce
% proste statystyki: mean, median, std, 
% wy�wietlenie histogramu cech(y): hist
% spojrzenie na dwie cechy na raz: plot2features (dostarczona w pakiecie)

[mean(train); median(train)]
% hist domy�lnie dzieli zakres warto�ci na 10 koszyk�w
% wy�wietlenie w ten spos�b 8 etykiet do�? dobrze ilustruje 
% dzia?anie hist
hist(train(:,1))

% to nie s? cechy, kt�re wykorzysta?bym do klasyfikacji - mo?na
% znale�? du?o lepsze; do sprawdzania, czy s? warto�ci odstaj?ce
% nawet te cechy wystarcz?
plot2features(train, 4, 6)

% do identyfikacji odstaj?cych pr�bek doskonale nadaj? si� wersje
% funkcji min i max z dwoma argumentami wyj�ciowymi

%[mv midx] = min(train)

% poniewa? warto�ci minimalne czy maksymalne da si� wyznaczy? zawsze,
% dobrze zweryfikowa? ich odstawanie spogl?daj?c przynajmniej na s?siad�w
% podejrzanej pr�bki w zbiorze ucz?cym

% powiedzmy, ?e podejrzana jest pr�bka 41
%midx = 41
%train(midx-1:midx+1, :)

% je�li nabra?em przekonania, ?e pr�bka midx jest do usuni�cia, to:
%size(train)
%train(midx, :) = []; % usuni�cie wiersza midx z macierzy
%size(train)

% procedur� szukania i usuwania warto�ci odstaj?cych trzeba powtarza? do skutku

% po usuni�ciu warto�ci odstaj?cych mo?na zaj?? si� wyborem DW�CH cech dla klasyfikacji
% w tym przypadku w zupe?no�ci wystarczy poogl?da? wykresy dw�ch cech i wybra? te, kt�re
% daj? w miar� dobrze odseparowane od siebie klasy

% Po ustaleniu cech (dok?adniej: indeks�w kolumn, w kt�rych cechy siedz?):
first_idx = 2;
second_idx = 4;
train = train(:, [1 first_idx second_idx]);
test = test(:, [1 first_idx second_idx]);

% to nie jest najros?dniejszy wyb�r; 4 i 6 na pewno trzeba zmieni?

% tutaj jawnie tworz� struktur� z parametrami dla klasyfikatora Bayesa 
% (po prawdzie, to dla funkcji licz?cej g�sto�? prawdobie�stwa) z za?o?eniem,
% ?e cechy s? niezale?ne

pdfindep_para = para_indep(train);
pdfmulti_para = para_multi(train);
pdfparzen_para = para_parzen(train, 0.001); 
% w sprawozdaniu trzeba podawa? szeroko�? okna (nie liczymy tego parametru z danych!)	

% wyniki do punktu 3
base_ercf = zeros(1,3);
base_ercf(1) = mean(bayescls(test(:,2:end), @pdf_indep, pdfindep_para) ~= test(:,1));
base_ercf(2) = mean(bayescls(test(:,2:end), @pdf_multi, pdfmulti_para) ~= test(:,1));
base_ercf(3) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para) ~= test(:,1));
base_ercf

% W kolejnym punkcie przyda si� funkcja reduce, kt�ra redukuje liczb� pr�bek w poszczeg�lnych
% klasach (w tym przypadku redukcja b�dzie taka sama we wszystkich klasach - ZBIORU UCZ�CEGO)
% Poniewa? reduce ma losowa? pr�bki, to eksperyment nale?y powt�rzy? 5 (lub wi�cej) razy
% W sprawozdaniu prosz� poda? tylko warto�? �redni? i odchylenie standardowe wsp�?czynnika b?�du
% Wyobra?am sobie, ?e w ka?dym powt�rzeniu eksperymentu tworz�
% now? wersj� zbioru ucz?cego:
%   reduced_train = reduce(train, parts(i) * ones(1, class_count))

parts = [0.1 0.25 0.5];
rep_cnt = 6; % przynajmniej

% YOUR CODE GOES HERE 
%
result4 = zeros(columns(parts), rep_cnt, 3);
for i = 1:columns(parts)
  i
  base_ercf = zeros(1,3);
  for j = 1:rep_cnt
    j
    reduced_train = reduce(train, parts(i) * ones(1, rows(labels)));
    pdfindep_para = para_indep(reduced_train);
    pdfmulti_para = para_multi(reduced_train);
    pdfparzen_para = para_parzen(reduced_train, 0.001); 

    base_ercf(1) = mean(bayescls(test(:,2:end), @pdf_indep, pdfindep_para) ~= test(:,1));
    base_ercf(2) = mean(bayescls(test(:,2:end), @pdf_multi, pdfmulti_para) ~= test(:,1));
    base_ercf(3) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para) ~= test(:,1));
    result4(i, j, :) = base_ercf;
  end
end

squeeze(mean(result4, 2))
squeeze(std(result4, 0, 2))


% Punkt 5 dotyczy jedynie klasyfikatora z oknem Parzena (na pe?nym zbiorze ucz?cym)

parzen_widths = [0.0001, 0.0005, 0.001, 0.005, 0.01];
parzen_res = zeros(1, columns(parzen_widths));

% YOUR CODE GOES HERE 
%
for i = 1 : columns(parzen_widths)
    pdfparzen_para = para_parzen(train, parzen_widths(i)); 
    parzen_res(i) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para) ~= test(:,1));
end


[parzen_widths; parzen_res]
% Tu a? prosi si� do?o?y? do danych numerycznych wykres
semilogx(parzen_widths, parzen_res)

% W punkcie 6 redukcja dotyczy ZBIORU TESTOWEGO, natomiast warto
% zadba? o to, ?eby parametry dla funkcji pdf by?y policzone
% na ca?ym zbiorze ucz?cym (po poprzednich eksperymentach tak 
% raczej nie jest)
% Poniewa? losujemy pr�bki, to wypada powt�rzy? eksperyment 
% stosown? liczb� razy i u�redni? wyniki
% reduced_test = reduce(test, parts) 

apriori = [0.165 0.085 0.085 0.165 0.165 0.085 0.085 0.165];
parts = [1.0 0.5 0.5 1.0 1.0 0.5 0.5 1.0];
rep_cnt = 6; % powt�rka, ?eby nie zapomnie?

% YOUR CODE GOES HERE 
%
result6 = zeros(rep_cnt, 3);
pdfindep_para = para_indep(train);
pdfmulti_para = para_multi(train);
pdfparzen_para = para_parzen(train, 0.001); 

for j = 1:rep_cnt
    j
    reduced_test = reduce(test, parts)
    
    base_ercf(1) = mean(bayescls(reduced_test(:,2:end), @pdf_indep, pdfindep_para) ~= reduced_test(:,1));
    base_ercf(2) = mean(bayescls(reduced_test(:,2:end), @pdf_multi, pdfmulti_para) ~= reduced_test(:,1));
    base_ercf(3) = mean(bayescls(reduced_test(:,2:end), @pdf_parzen, pdfparzen_para) ~= reduced_test(:,1));
    result6(j, :) = base_ercf;
end
 
mean(result6, 1)
std(result6, 0, 1)

%confMx test
pdfindep_para = para_indep(train);
pdfmulti_para = para_multi(train);
pdfparzen_para = para_parzen(train, 0.001); 

declab = zeros(rows(test), 3);
declab(:, 1) = bayescls(test(:,2:end), @pdf_indep, pdfindep_para);
declab(:, 2) = bayescls(test(:,2:end), @pdf_multi, pdfmulti_para);
declab(:, 3) = bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para);
confMx(test(:, 1), declab(:, 1))
(-diag(confMx(test(:, 1), declab(:, 1))) + 228)./228
% W ostatnim punkcie trzeba zastanowi? si� nad normalizacj?
std(train(:,2:end))
% Mo?e warto sprawdzi?, jak to wygl?da w poszczeg�lnych klasach?

% Normalizacja potrzebna?
% Je�li TAK, to jej parametry s? liczone TYLKO na zbiorze ucz?cym
% Procedura normalizacji jest aplikowana do zbioru ucz?cego i testowego
% Poniewa? zbiory ucz?cy i testowy s? przyzwoitej wielko�ci 
% klasyfikujecie Pa�stwo testowy za pomoc? ucz?cego (nie ma
% potrzeby u?ycia leave-one-out)


% YOUR CODE GOES HERE 

result7 = zeros(rows(test), 1);
mean_train = mean(train);
std_train = std(train);
train_norm = [train(:, 1) zeros(rows(train), columns(train))];
test_norm = [test(:, 1) zeros(rows(test), columns(test))];

for i=1:rows(test)
  result7(i) = cls1nn(train, test(i, 2:end)) ~= test(i, 1);
end

mean(result7)

for i=2:columns(train)
  train_norm(:, i) = (train(:, i) - mean_train(i))./std_train(i);
  test_norm(:, i) = (test(:, i) - mean_train(i))./std_train(i);
end

for i=1:rows(test_norm)
  result7(i) = cls1nn(train_norm, test_norm(i, 2:end)) ~= test_norm(i, 1);
end
mean(result7)


