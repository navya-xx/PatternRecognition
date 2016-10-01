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


%take the distributions from state matrix
initial = mc.InitialProb;
states = mc.TransitionProb;


if (length(initial) < length(states))%finite duration markov chain, redundant
    %calculate a sequence
    d1 = DiscreteD(initial');
    d2 = DiscreteD(states);
    S(1,1) = rand(d1, 1);
    for index = 2:T
        currentState = S(1,index-1);
        currentDistribution = d2(currentState);
        nState = rand(currentDistribution, 1);
        if nState == length(states)%reached end of sequence
            S = S(1,1:index-1);
            break;
        end
        S(1,index) = nState;
        
    end
    
    
    
else
    %calculate a sequence
    d1 = DiscreteD(initial');
    d2 = DiscreteD(states);

    S(1,1) = rand(d1, 1);
    for index = 2: T
       %sample state based on previous state p(S_{i}|S_{i-1})
       currentState = S(1,index-1);
       currentDistribution = d2(currentState);
       S(1,index) = rand(currentDistribution, 1);

    end
end





%error('Method not yet implemented gd');
%continue code from here, and erase the error message........








