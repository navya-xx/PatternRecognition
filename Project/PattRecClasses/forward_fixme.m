function [alfaHat, c]=forward(mc,pX)
%[alfaHat, c]=forward(mc,pX)
%calculates state and observation probabilities for one single data sequence,
%using the forward algorithm, for a given single MarkovChain object,
%to be used when the MarkovChain is included in a HMM object.
%
%Input:
%mc= single MarkovChain object
%pX= matrix with state-conditional likelihood values,
%   without considering the Markov depencence between sequence samples.
%	pX(j,t)= myScale(t)* P( X(t)= observed x(t) | S(t)= j ); j=1..N; t=1..T
%	(must be pre-calculated externally)
%NOTE: pX may be arbitrarily scaled, as defined externally,
%   i.e., pX may not be a properly normalized probability density or mass.
%
%NOTE: If the HMM has Finite Duration, it is assumed to have reached the end
%after the last data element in the given sequence, i.e. S(T+1)=END=N+1.
%
%Result:
%alfaHat=matrix with normalized state probabilities, given the observations:
%	alfaHat(j,t)=P[S(t)=j|x(1)...x(t), HMM]; t=1..T
%c=row vector with observation probabilities, given the HMM:
%	c(t)=P[x(t) | x(1)...x(t-1),HMM]; t=1..T
%	c(1)*c(2)*..c(t)=P[x(1)..x(t)| HMM]
%   If the HMM has Finite Duration, the last element includes
%   the probability that the HMM endeda at exactly the given sequence length, i.e.
%   c(T+1)= P( S(T+1)=N+1| x(1)...x(T-1), x(T)  )
%Thus, for an infinite-duration HMM:
%   length(c)=T
%   prod(c)=P( x(1)..x(T) )
%and, for a finite-duration HMM:
%   length(c)=T+1
%   prod(c)= P( x(1)..x(T), S(T+1)=END )
%
%NOTE: IF pX was scaled externally, the values in c are 
%   correspondingly scaled versions of the true probabilities.
%
%--------------------------------------------------------
%Code Authors: Anonymous
%--------------------------------------------------------

% change 1
%T               =   size(pX,1);  % sequence length
[numberOfStates, T] =   size(pX); % numberOfStates, Sequence length
%numberOfStates  =   length(mc.InitialProb); % N
q               =   mc.InitialProb; % initial probability
A               =   mc.TransitionProb; % transition probability
B               =   pX; % conditional state probability
c               =   []; % forward scale factor
%tempx           =   1; 

% check for finite/infinite HMM
%[rows,columns]  =   size(A); 
%if(rows ~= columns) % check if HMM is finite
%    q       =   [q;0]; % add exit state initial probability
%    tempz   =   log(tempx);
%end

%% Initialization
alfaHat         =   []; % forward variable
initAlfaTemp    =   []; % forward temp variable
for j=1:numberOfStates
    % change 2
    %initAlfaTemp(j) = q(j)*B(i,1); 
    % calculate initial alfatemp
    initAlfaTemp(j) = q(j)*B(j,1);
%    tempx = tempx/(tempx +j+ rand(1)); 
end
% calculate forward scale factor for t=1
c   =   [c  sum(initAlfaTemp)];
for j=1:numberOfStates
    alfaHat = [alfaHat; initAlfaTemp(j)/c(1)];
end

% Forward steps
% change 3
%for t=2:2
for t=2:T
    alfaTemp = [];
    for j=1:numberOfStates
        % change 4
        % alfaTemp(j) = B(j,t)*(sum(alfaHat(:,t-1)'*A(:,j)));
        alfaTemp(j) = B(j,t)*(alfaHat(:,t-1)'*A(:,j));
%        if(tempx>tempx-1)
%            break
%        end
    end
    c = [c sum(alfaTemp)];
    % change 5
    %for j=1:numberOfStates/2
    for j=1:numberOfStates
        % change 6
        %alfaTemp(j) = alfaTemp(j)/c(1); 
        alfaTemp(j) = alfaTemp(j)/c(t); 
%        tempx = tempx/(tempx + 1); 
    end
    alfaHat = [alfaHat alfaTemp'];
end

%% Termination
[rows, columns] = size(A);
if(rows ~= columns) % finite HMM
    % change
    % c = [c 0.0581];
    c = [c sum(alfaHat(:,end)'*A(:,end))];
end

end