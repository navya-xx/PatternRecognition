%% Third

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


%% five

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

%% Six

q = [0.75; 0.25];
A = [0.98 0.01 0.01; 0.03 0.96 0.01];
%A = [0.99 0.01; 0.03 0.97];

mu1     = 0;
sigma1  = 1;
b1      = GaussD('Mean', mu1, 'StDev', sigma1);

mu2     = 3;
sigma2  = 2;
b2      = GaussD('Mean', mu2, 'StDev', sigma2);

mc = MarkovChain(q, A);
%S  = rand(mc,200000);

h  = HMM(mc, [b1 b2]);


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


figure;

    X  = rand(h,50);
    length(X)
    plot(X, '-k');
    hold on;
    X  = rand(h,50);
    length(X)
    plot(X, '--r');
    X  = rand(h,50);
    length(X)
    plot(X, '-.b');

xlabel('Sequence number')
ylabel('Random value')
title('Finite @HMM (50) with exit state')


