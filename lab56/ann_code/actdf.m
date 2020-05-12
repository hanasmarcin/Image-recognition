function res = actdf(sfvalue)
% derivative of sigmoid activation function
% sfvalue - value of sigmoid activation function (!!!)

% 	res = ones(size(sfvalue));

    % Pochodna dla f-cji postaci 1/(1 + exp(-lambda*tact(j, i)))
%     res = sfvalue .* (1 - sfvalue);
    
    % Pochodna dla f-cji postaci 2/(1 + exp(-lambda*tact(j, i))) - 1
    res = 0.5 .* (1 - sfvalue.^2);
