%% Assignment 1.2
%3. To verify your HMM rand method, first calculate E [X t ] and var [X t ]
%theoretically. The conditional expectation formulas μ X = E [X] =
%E Z [E X [X|Z]] and var [X] = E Z [var X [X|Z]] + var Z [E X [X|Z]] apply
%generally whenever some variable X depends on another variable Z
%and may be useful for the calculations. Then use your HMM rand
%function to generate a sequence of T = 10 000 output scalar random
%numbers x = (x 1 . . . x t . . . x T ) from the given HMM test example. Use
%the standard MatLab functions mean and var to calculate the mean
%and variance of your generated sequence. The result should agree
%approximately with your theoretical values.


% Initialize model
q = [0.75; 0.25];
A = [0.99 0.01; 0.03 0.97];

mu1     = 0;
sigma1  = 1;
b1      = GaussD('Mean', mu1, 'StDev', sigma1);

mu2     = 3;
sigma2  = 2;
b2      = GaussD('Mean', mu2, 'StDev', sigma2);

% determine length of sequence
nSamples = 10000;

meanx = [];
varx = [];

% generate ten sequences of the specified length
for ii=1:10
    mc = MarkovChain(q, A);
    h  = HMM(mc, [b1; b2]);
    X  = rand(h,10000);
    meanx = [meanx mean(X)];
    varx = [varx var(X)];
end

% take the mean of the means and the variance
meanmeanx = mean(meanx);
meanvarx = mean(varx);