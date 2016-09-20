
%% First

q = [0.75; 0.25];
A = [0.99 0.01; 0.03 0.97];

mu1     = 0;
sigma1  = 1;
b1      = GaussD('Mean', mu1, 'StDev', sigma1);

mu2     = 3;
sigma2  = 2;
b2      = GaussD('Mean', mu2, 'StDev', sigma2);

mc = MarkovChain(q, A);
S  = rand(mc,10000);

h  = HMM(mc, [b1; b2]);
X  = rand(h,10000);

%%
q = [0.75; 0.25];
A = [0.99 0.01; 0.03 0.97];

mu1     = 0;
sigma1  = 1;
b1      = GaussD('Mean', mu1, 'StDev', sigma1);

mu2     = 0;
sigma2  = 2;
b2      = GaussD('Mean', mu2, 'StDev', sigma2);

mc = MarkovChain(q, A);
%S  = rand(mc,200000);

h  = HMM(mc, [b1; b2]);
X  = rand(h,500);
plot(X);

