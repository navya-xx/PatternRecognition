function [X,S]=rand(h,nSamples)
%[X,S]=rand(h,nSamples);generates a random sequence of data
%from a given Hidden Markov Model.
%
%Input:
%h=         HMM object
%nSamples=  maximum no of output samples (scalars or column vectors)
%
%Result:
%X= matrix or row vector with output data samples
%S= row vector with corresponding integer state values
%   obtained from the h.StateGen component.
%   nS= length(S) == size(X,2)= number of output samples.
%   If the StateGen can generate infinite-duration sequences,
%       nS == nSamples
%   If the StateGen is a finite-duration MarkovChain,
%       nS <= nSamples
%
%----------------------------------------------------
%Code Authors:
%----------------------------------------------------

if numel(h)>1
    error('Method works only for a single object');
end;

%continue coding from here, and delete the error message.
%error('Not yet implemented');

%% Code LK 2016-09-15
mc          = h.StateGen;
S           = rand(mc,nSamples);           % generate MarkovChain states
DataSize    = h.DataSize();                 % number of output samples per state
X           = zeros(DataSize,size(S,2));    % initialize X vector

for ii=1:length(S)
    X(:, ii) = rand(h.OutputDistr(S(ii)), 1);           % generate samples 
                                                        % with respect
                                                        % to the output
                                                        % distribution of
                                                        % the state
end



end