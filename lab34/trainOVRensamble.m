function [ovrsp, errors] = trainOVRensamble(tset, tlab, htrain)
% Trains a set of linear classifiers (one versus rest class)
% on the training set using trainSelect function
% tset - training set samples
% tlab - labels of the samples in the training set
% htrain - handle to proper function computing separating plane
% ovosp - one versus rest class linear classifiers matrix
%   the first column contains positive class label
%   the second column contains negative class label
%   columns (3:end) contain separating plane coefficients

  labels = unique(tlab);
  ovrsp = zeros(rows(labels), 1 + 1 + columns(tset));
  errors = zeros(rows(labels), 3);

  for i=1:rows(labels)
	% store label in the first column
    ovrsp(i, 1:2) = labels(i, 1);
	
	% select samples of the digit and every other digit from the training set
    posSamples = tset(tlab == labels(i, 1), :);
    negSamples = tset(tlab ~= labels(i, 1), :);
	
	% train 5 classifiers and select the best one
    [sp fp fn] = trainSelect(posSamples, negSamples, 5, htrain);
	
	% what to do with errors?
	% it would be wise to add additional output argument
	% to return error coefficients
     errors(i, 1) = labels(i, 1);
    errors(i, 2:3) = [fp fn];
	
    % store the separating plane coefficients (this is our classifier)
	% in ovo matrix
    ovrsp(i, 2:end) = sp; 
  end
