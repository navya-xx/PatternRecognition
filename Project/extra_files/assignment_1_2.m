%% Assignment 1.2
%2. Use your Markov chain rand function to generate a sequence of T =
%10 000 state integer numbers from the test Markov chain. Calculate
%the relative frequency of occurrences of S t = 1 and S t = 2. The relative
%frequencies should of course be approximately equal to P (S t )

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

phat1 = [];
phat2 = [];

% generate ten sequences of the specified length
for ii=1:10
    mc = MarkovChain(q, A);
    S  = rand(mc,nSamples);
    phat1 = [phat1 sum(S==1)/nSamples];
    phat2 = [phat2 sum(S==2)/nSamples];
end

% take the mean of the relative frequency
mphat1 = mean(phat1);
mphat2 = mean(phat2);