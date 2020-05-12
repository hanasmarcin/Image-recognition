function [errors] = compErrors(confmx)
% Given confusion matrix computes classification/error/reject coefficients
% confmx - confusion matrix of the classifier
%		rows - are for ground truth
%		columns - are for classfier output
% 	It's assumed that rejection decision is coded as max(labels)+1
% Output:
% 	errors - vector containing proper classifications, errors and reject decision coefficients

	total = sum(sum(confmx));
% 	errors(1) = trace(confmx) / total;
% 	errors(2) = (total - trace(confmx) - sum(confmx(:,end))) / total;
% 	errors(3) = sum(confmx(:,end)) / total;
	errors(1) = trace(confmx(:,1:end-1)) / total;
	errors(2) = (total - trace(confmx(:,1:end-1)) - sum(confmx(:,end))) / total;
	errors(3) = sum(confmx(:,end)) / total;

