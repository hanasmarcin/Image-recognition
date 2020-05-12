function [sepplane fp fn] = perceptron(pclass, nclass)
% Computes separating plane (linear classifier) using
% perceptron method.
% pclass - 'positive' class (one row contains one sample)
% nclass - 'negative' class (one row contains one sample)
% Output:
% sepplane - row vector of separating plane coefficients
% fp - false positive count (i.e. number of misclassified samples of pclass)
% fn - false negative count (i.e. number of misclassified samples of nclass)

  sepplane = rand(1, columns(pclass) + 1) - 0.5;
  tset = [ ones(rows(pclass), 1) pclass; -ones(rows(nclass), 1) -nclass];
  nPos = rows(pclass); % number of positive samples
  nNeg = rows(nclass); % number of negative samples
  learning_rate = 1/(nPos+nNeg);

  i = 1;
  while i <= 200
	%%% YOUR CODE GOES HERE %%%
    miscls = false(1, rows(tset));
	%% You should:
	%% 1. Check which samples are misclassified (boolean column vector)
    % Warunek a'*y_k >= 0;
    miscls = tset * sepplane' <= 0; % (<= 0) standard, (<= 1) modified
    misclsset = tset(miscls', :);
	%% 2. Compute separating plane correction 
	%%		This is sum of misclassfied samples coordinate times learning rate
    sepplane_crr = sum(misclsset) .* learning_rate;
	%% 3. Modify solution (i.e. sepplane)
    sepplane = sepplane + sepplane_crr;
	%% 4. Optionally you can include additional conditions to the stop criterion
	%%		200 iterations can take a while and probably in most cases is unnecessary
    if (sum(miscls) == 0)
        break;
    end
	i = i+1;
  end;
  
  %%% YOUR CODE GOES HERE %%%
  %% You should:
  %% 1. Compute the numbers of false positives and false negatives
  fp = 0;
  fn = 0;

  for k = 1:nPos
      if (sepplane * tset(k, :)' <= 0)
          fn = fn + 1;
      end;
  end;
  
  for k = nPos+1:nPos + nNeg
      if (sepplane * tset(k, :)' <= 0)
          fp = fp + 1;
      end;
  end;
