clear;
close all;
home;

h = HMM;

markchain = MarkovChain;
markchain.InitialProb = [0.75,0.25];
markchain.TransitionProb = [[0.99,0.01];[0.03,0.97]];

h.StateGen = markchain;

b1 = GaussD;
b1.Mean = 0;
b1.StDev = 1;

b2 = GaussD;
b2.Mean = 3;
b2.StDev = 2;

B=[b1,b2];

h.OutputDistr = B;

%% A.1.2.2
nTransitions = 10000;
nClass = 2;

[X,S] = rand(h,nTransitions);
classSums = zeros(1,nClass);
classFreqs = zeros(1,nClass);

for i=1:nClass
    classSums(i) = sum(i==S);
end

for i=1:nClass
    classFreqs(i) = classSums(i)/nTransitions;
end
% A.1.2.3
hmmMean = mean(X)
hmmVar = var(X)


disp('    c1        c2')
disp(classFreqs)
disp('mean:')
disp(hmmMean)
disp('var:')
disp(hmmVar)

%% A.1.2.4
Xt = rand(h,500);
plot(1:500,Xt);
title('Xt in time');
ylabel('Xt');
xlabel('Time');
figure();

%% A.1.2.5
h = HMM;

markchain = MarkovChain;
markchain.InitialProb = [0.75,0.25];
markchain.TransitionProb = [[0.99,0.01];[0.03,0.97]];

h.StateGen = markchain;

b1 = GaussD;
b1.Mean = 0;
b1.StDev = 1;

b2 = GaussD;
b2.Mean = 0;
b2.StDev = 2;

B=[b1,b2];

h.OutputDistr = B;

Xt = rand(h,500);
plot(1:500,Xt);
title('Xt in time, means=0');
ylabel('Xt');
xlabel('Time');

%% A.1.2.6
chain = MarkovChain;
chain.InitialProb = [0.5 0.5];
chain.TransitionProb = [ 0.69 0.3 0.01; 0.1 0.89 0.01];


b1 = GaussD;
b1.Mean = 0;
b1.StDev = 1;

b2 = GaussD;
b2.Mean = 10;
b2.StDev = 1;

B = [b1, b2];

h = HMM;
h.StateGen = chain;
h.OutputDistr = B;

[X, S] = rand(h,500);

figure
plot(X);
title('Markov Chain realizations $X_t$','interpreter','latex','fontsize',18);
ylabel('Signal $X_t$','interpreter','latex','fontsize',14);
xlabel('Time $t$','interpreter','latex','fontsize',14);
xlim([0 500]);
%% A.1.2.7


pInit = [0.75,0.25];
pTrans = [[0.99,0.01];[0.03,0.97]];
markchain = MarkovChain(pInit,pTrans);

b1 = GaussD('Mean', [0; 0], 'Covariance', [1 1; 1 2], 'AllowCorr', 1)
b2 = GaussD('Mean', [0; 0], 'Covariance', [10 3; 3 7], 'AllowCorr', 1)

B=[b1,b2];

h = HMM(markchain,B);


[Xt,S] = rand(h,500);
        
scatter3(Xt(1,:),Xt(2,:),1:500,25,S,'filled');
title('Xt in time, with covariance');
zlabel('Time');
ylabel('X2');
xlabel('X1');
colormap(jet(4));
