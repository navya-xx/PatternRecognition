
%% Finite HMM
q = [1; 0];
A = [0.9 0.1 0; 0 0.9 0.1];

% Output distributions
mu1     = 0;
sigma1  = 1;
b1      = GaussD('Mean', mu1, 'StDev', sigma1);

mu2     = 3;
sigma2  = 2;
b2      = GaussD('Mean', mu2, 'StDev', sigma2);

% Create Markov chain and hidden Markov model
mc = MarkovChain(q, A);
h  = HMM(mc, [b1 b2]);

x  = [-0.2, 2.6, 1.3];              % observed sequence
[pX, logS] = prob([b1,b2], x);      % get state probabilities scaled by logS
[alfahat, cScaled] = forward(mc, pX);% forward algorithm. Note that c 
                                    % values are scaled
                                    
%betaHat = backward(mc, pX, cScaled);% run backward algorithm with scaled c
                                    % note that results differ from
                                    % textbook results since c is stored 
                                    % more precise internally and the
                                    % textbook most likely only works with
                                    % 4 digits
disp('alphahat:');
disp(alfahat);
disp('scaled factor c_t');
disp(cScaled);

%% Check if algorithms work for infinite HMM
% Author: Navneet Agrawal and Lars Kuger
% EQ2340 Pattern Recognition course
% Project part 3
% Fall term 2016
% Description: Compare obtained results with the results that are shown in
% the solutions of task 5.1 from the course book
% Conclusion: Forward algorithm working properly as can be seen from the
% comparison. For the backward algorithm we can consider that the only
% difference between finite and infinite HMM is the initialization. So the
% algorithm itself is working properly as can be seen from assignment31.m


% Infinite HMM
q = [1; 0; 0];
A = [0.3 0.7 0; 0 0.5 0.5; 0 0 1];

% Output distributions
b1 = DiscreteD([1 0 0 0]);
b2 = DiscreteD([0 0.5 0.4 0.1]);
b3 = DiscreteD([0.1 0.1 0.2 0.6]);


% Create Markov chain and hidden Markov model
mc = MarkovChain(q, A);
h  = HMM(mc, [b1, b2, b3]);

x  = [1 2 4 4 1];                   % observed sequence
[pX, logS] = prob([b1,b2, b3], x);  % get state probabilities scaled by logS
                                    % (logS will be zero in our case)
[alfahat, cScaled] = forward(mc, pX);% forward algorithm. Note that c 
                                    % values may be scaled
                                    
%betaHat = backward(mc, pX, cScaled);% run backward algorithm with scaled c
                                    % note that results differ from
                                    % textbook results since c is stored 
                                    % more precise internally and the
                                    % textbook most likely only works with
                                    % 4 digits
     
if logS                                    
    c = cScaled.*logS;
else
    c = cScaled;
end

disp('alphahat:');
disp(alfahat);
disp('scaled factor c_t');
disp(cScaled);
