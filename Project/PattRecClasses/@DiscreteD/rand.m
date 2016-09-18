function R=rand(pD,nData)
%R=rand(pD,nData) returns random scalars drawn from given Discrete Distribution.
%
%Input:
%pD=    DiscreteD object
%nData= scalar defining number of wanted random data elements
%
%Result:
%R= row vector with integer random data drawn from the DiscreteD object pD
%   (size(R)= [1, nData]
%
%----------------------------------------------------
%Code Authors:
%----------------------------------------------------

if numel(pD)>1
    error('Method works only for a single DiscreteD object');
end;

%*** Insert your own code here and remove the following error message 
%error('Not yet implemented');

% start code LK 2016-09-14
%lowerBound  = 0;                    % summed up probabilities
%upperBound  = 0;                    % summed up probabilities
%tmpR        = rand(1,nData);        % generate uniformly distributed numbers
R           = zeros(1,nData);

% Inverse Transform Method
% Alternative: Acceptance-Rejection-Method
% idea: the probability that an integer jj occurs is equal to the
% probability that a uniformly generated number between 0 and 1 is in a
% particular interval of the size pD.ProbMass(jj)
% for ii=1:nData
%     upperBound = 0;
%     lowerBound = 0;
%     for jj=1:length(pD.ProbMass)
%         upperBound = upperBound + pD.ProbMass(jj);
%         if (tmpR(ii) > lowerBound) && (tmpR(ii)<=upperBound)
%             R(ii) = jj;
%             break;
%         end
%         lowerBound = upperBound;
%     end
% end


%%% This function creates gaussian data using uniform distribution by the
% method of acceptance rejection.
% INPUT: p - probability vector (column vector)
%        N - size of output Y
% The method involves following steps:
% 1. Generate a known random variable X (uniformly distributed)
% 2. create random number u and test for u < p(x)/c*q, if true Y=X
 
 
success = 0;
p = pD.ProbMass';
while(success < nData)
     % uniform distribution q(x)
     q = 1/size(p,2);
     a = 1;
     % bound for Y
     c = max(p/q);
     % step 1
     u1 = rand();
     X = floor(u1/q) + a;
     % step 2
     u = rand();
     if u < p(X)/(c*q)
        success = success + 1;
        R(1,success) = X;
     end
end

end

