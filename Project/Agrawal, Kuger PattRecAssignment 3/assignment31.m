%% Check if forward and backward algorithm work for finite HMM
% EQ2340 Pattern Recognition course
% Project part 3
% Authors: Navneet Agrawal and Lars Kuger
% KTH Royal Institute of Technology
% Fall term 2016
% Description: Check if forward and backward algorithm work by comparing
% the obtained results to the presented results given in the course book

% Finite HMM
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
                                    
betaHat = backward(mc, pX, cScaled);% run backward algorithm with scaled c
                                    % note that results differ from
                                    % textbook results since c is stored 
                                    % more precise internally and the
                                    % textbook most likely only works with
                                    % 4 digits