% Project - EQ2340
% Assignment 1
% Authors : Lars Kuger, Navneet Agrawal

% Tests scripts for assignment 1

%% test 2, 3 markov chain and HMM E[X] and var[X]
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

disp('Relative frequency (S==1):')
disp(sum(S==1))

disp('Relative frequency (S==2):')
disp(sum(S==2))

%%

h  = HMM(mc, [b1; b2]);
X  = rand(h,10000);

disp('E[X] = ')
disp(mean(X))

disp('var[X] =')
disp(var(X))

%% test 4
q = [0.75; 0.25];
%A = [0.98 0.01 0.01; 0.03 0.96 0.01];
A = [0.99 0.01; 0.03 0.97];

mu1     = 0;
sigma1  = 1;
b1      = GaussD('Mean', mu1, 'StDev', sigma1);

mu2     = 3;
sigma2  = 2;
b2      = GaussD('Mean', mu2, 'StDev', sigma2);

mc = MarkovChain(q, A);
%S  = rand(mc,200000);

h  = HMM(mc, [b1 b2]);
X  = rand(h,500);
figure;
plot(X);
xlabel('Sequence number')
ylabel('Random value')
title('@HMM/rand with b_1(x)~N(0,1) & b_2(x)~N(3,2)')

%% test 5
q = [0.75; 0.25];
%A = [0.98 0.01 0.01; 0.03 0.96 0.01];
A = [0.99 0.01; 0.03 0.97];

mu1     = 0;
sigma1  = 1;
b1      = GaussD('Mean', mu1, 'StDev', sigma1);

mu2     = 0;
sigma2  = 2;
b2      = GaussD('Mean', mu2, 'StDev', sigma2);

mc = MarkovChain(q, A);
%S  = rand(mc,200000);

h  = HMM(mc, [b1 b2]);
X  = rand(h,500);
figure;
plot(X);
xlabel('Sequence number')
ylabel('Random value')
title('@HMM/rand with b_1(x)~N(0,1) & b_2(x)~N(0,2)')

%% test 6
q = [0.75; 0.25];
A = [0.88 0.02 0.1; 0.04 0.86 0.1];
%A = [0.99 0.01; 0.03 0.97];

mu1     = 0;
sigma1  = 1;
b1      = GaussD('Mean', mu1, 'StDev', sigma1);

mu2     = 3;
sigma2  = 2;
b2      = GaussD('Mean', mu2, 'StDev', sigma2);

check_step = 3;

prob_ex_50 = 0;
for i = 1:check_step
    prob_ex_50 = prob_ex_50 + (1-A(1,3)).^(i-1) .* A(1,3);
end
disp(prob_ex_50);
mc = MarkovChain(q, A);
%S  = rand(mc,200000);

h  = HMM(mc, [b1 b2]);
l = zeros(1000,1);
for j = 1:1000
    X = rand(h,500);
    l(j,1) = length(X);
end
histogram(l,'Normalization','cdf');
figure;

    X  = rand(h,500);
    length(X)
    plot(X, '-k');
    hold on;
    X  = rand(h,500);
    length(X)
    plot(X, '--r');
    X  = rand(h,500);
    length(X)
    plot(X, '-.b');

xlabel('Sequence number')
ylabel('Random value')
title('Finite @HMM (500) with exit state')

%% test 7
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