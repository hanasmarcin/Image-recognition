function [hidlw outlw terr] = backprop(tset, tslb, inihidlw, inioutlw, lr)
% derivative of sigmoid activation function
% tset - training set (every row represents a sample)
% tslb - column vector of labels 
% inihidlw - initial hidden layer weight matrix
% inioutlw - initial output layer weight matrix
% lr - learning rate

% hidlw - hidden layer weight matrix
% outlw - output layer weight matrix
% terr - total squared error of the ANN

% 1. Set output matrices to initial values
	hidlw = inihidlw;
	outlw = inioutlw;
	
% 2. Set total error to 0
	terr = 0;
    
    labels = unique(tslb);
	
% foreach sample in the training set
	for i=1:rows(tset)

		% 3. Set desired output of the ANN (it depends on actf you use!)
		desired_olout = -1 .* ones(1, columns(outlw));
        desired_olout(tslb(i, :) == labels) = 1;
        
		% 4. Propagate input forward through the ANN
        hlact = [tset(i, :) 1] * hidlw;
        hlout = actf(hlact);
	
        olact = [hlout 1] * outlw;
        olout = actf(olact);
		% 5. Adjust total error
		terr = 0.5 .* sum(sum((desired_olout - olout).^2));
		% 6. Compute delta error of the output layer
        ol_derr = (desired_olout - olout).* actdf(olout);
		% 7. Compute delta error of the hidden layer
		hl_derr = ol_derr * outlw(1:end-1, :)' .* actdf(hlout);
        % 8. Update output layer weights
		outlw = outlw + lr .* [hlout 1]' * ol_derr;
		% 9. Update hidden layer weights
        hidlw = hidlw + lr .* [tset(i, :) 1]' * hl_derr;
	end
