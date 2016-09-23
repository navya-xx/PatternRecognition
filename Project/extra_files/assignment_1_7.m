%% Third

q = [0.75; 0.25];
A = [0.99 0.01; 0.03 0.97];

mu1     = [-6 6];
sigma1  = [2 1; 1 4];
b1      = GaussD('Mean', mu1, 'AllowCorr', 1, 'Covariance', sigma1);

mu2     = [2 -2];
sigma2  = [1 0; 0 1];
b2      = GaussD('Mean', mu2, 'Covariance', sigma2, 'AllowCorr', true);

mc = MarkovChain(q, A);
%S  = rand(mc,200000);

h  = HMM(mc, [b1 b2]);
X  = rand(h,1000);

figure;
plot(X(1,:), 'k');
xlabel('Sequence number')
ylabel('Random value')
title('Random sequence X(1,:)')
grid on
figure;
plot(X(2,:), 'r');
xlabel('Sequence number')
ylabel('Random value')
title('Random sequence X(2,:)')
grid on