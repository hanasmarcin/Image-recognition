% ladowanie danych
load iris2.txt;
iris2(:, 1) = 2;
load iris3.txt;
iris3(:, 1) = 3;

iris = [iris2; iris3];

%klasyfikator
ts = iris;
%x = ts(6, 2:end)

%for i=1:rows(ts)
%  cls1nn(ts(1:end != i), ts(i, 2:end))
%end
for i=2:5
  jackknife(ts, i)
  jackknife(ts, [2:i-1 i+1:5])
end

% jackknife(ts, [2 3 4 5])

% jackknife(ts(randperm(100), :), [3])
% rows(unique(iris(:,[3])))