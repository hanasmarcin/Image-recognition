function ercf = jackknife(ts, args)
  % leave-one-out test of cls1nn classifier on ts
  % ts - training set

  res = zeros(rows(ts), 1);
  for i=1:rows(ts)
    % res(i) = cls1nn(ts(1:end != i, :), ts(i, 2:end));
    res(i) = cls1nn(ts(1:end ~= i, [1 args]), ts(i, args));
  end
  
  ercf = mean(res ~= ts(:, 1));
end
