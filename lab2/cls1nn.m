function lab = cls1nn(ts, x)
% 1-NN classifier
% ts - training set (first column contains labels)
% x - label to be classified (no label here)
% lab - x's nearest neighbour label
  sqdist = sumsq(ts(:, 2:end) - x, 2);
  [mv mi] = min(sqdist);
  lab = ts(mi, 1);
end
