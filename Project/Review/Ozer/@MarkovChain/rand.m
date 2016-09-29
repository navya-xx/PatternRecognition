function S=rand(mc,T)
%S=rand(mc,T) returns a random state sequence from given MarkovChain object.
%
%Input:
%mc=    a single MarkovChain object
%T= scalar defining maximum length of desired state sequence.
%   An infinite-duration MarkovChain always generates sequence of length=T
%   A finite-duration MarkovChain may return shorter sequence,
%   if END state was reached before T samples.
%
%Result:
%S= integer row vector with random state sequence,
%   NOT INCLUDING the END state,
%   even if encountered within T samples
%If mc has INFINITE duration,
%   length(S) == T
%If mc has FINITE duration,
%   length(S) <= T
%
%---------------------------------------------
%Code Authors:
%---------------------------------------------

S=zeros(1,T);%space for resulting row vector
nS=mc.nStates;

%initial state
discDist = DiscreteD;
discDist.ProbMass = mc.InitialProb;
initialState = rand(discDist,1);
S(1) = initialState;
%disp(discDist);

for i=2:T
    %discDist = DiscreteD;
    discDist.ProbMass = mc.TransitionProb(S(i-1),:);
    newState = rand(discDist,1);
    if newState == nS+1 %not entirely sure if this is correct. how would this condition ever hold?
        S = S(1:find(0 == S, 1,'first')-1); %cut the resulting vector from where the first 0 is seen. 
        return
    end
    S(i) = newState;
    %disp(discDist);
    %disp(S);
end
return
