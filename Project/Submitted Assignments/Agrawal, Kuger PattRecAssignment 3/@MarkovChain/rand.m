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

TmpS=zeros(1,T);%space for resulting row vector
nS=mc.nStates;

%error('Method not yet implemented');
%continue code from here, and erase the error message........


%% use previously written @DiscreteD/rand fcn
% code LK 2016-09-14

init = DiscreteD(mc.InitialProb);       % generate discrete RV with initial
                                        % probability mass function
TmpS(1) = rand(init, 1);              % generate first state

for idx=2:T                             % maximum length of chain is T
    prevState   = TmpS(idx-1);             % previous state
    tmp         = ...                   % discrete RV with transition probabilities
        DiscreteD(mc.TransitionProb(prevState,:));
    currState   = rand(tmp,1);          % generate random current state
    if currState == nS+1
        S = TmpS(1:idx-1);
        return;                          % break if end state is reached
    else
        TmpS(idx)  = currState;            % add to state chain if not end state
    end
end

S = TmpS;



end

