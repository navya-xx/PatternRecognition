%% Third

q = [0.75; 0.25];
A = [0.99 0.01; 0.03 0.97];

mu1     = [0 0];
sigma1  = [4 1; 1 2];
b1      = GaussD('Mean', mu1, 'AllowCorr', 1, 'Covariance', sigma1);

mu2     = [3 3];
sigma2  = [1 0; 0 1];
b2      = GaussD('Mean', mu2, 'Covariance', sigma2, 'AllowCorr', true);

mc = MarkovChain(q, A);
%S  = rand(mc,200000);

h  = HMM(mc, [b1 b2]);
X  = rand(h,1000);

plot(X(1,:));
hold;
plot(X(2,:), 'g');