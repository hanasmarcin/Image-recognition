function res = actf(tact)
% sigmoid activation function
% tact - total activation 
	lambda = 2;
    res = zeros(size(tact));
    for i = 1:columns(res)
        for j = 1:rows(res)
            res(j, i) = 2/(1 + exp(-lambda*tact(j, i))) - 1;
%             res(j, i) = 1/(1 + exp(-lambda*tact(j, i)));
        end
    end
% 	res = tact;
	% linear function is not what Tiggers like best