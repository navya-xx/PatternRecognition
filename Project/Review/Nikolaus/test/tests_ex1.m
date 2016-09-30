%%
%Code used for the report of Exercise 1 in Pattern Recognition 

%% verify HMM rand method A.1.2.3


clear all; clc
mc = MarkovChain([0.75;0.25], [0.99 0.01;0.03 0.97]);%State generator

g1 = GaussD('Mean',0,'StDev',1); %Distribution for state=1
g2 = GaussD('Mean',3,'StDev',2); %Distribution for state=2
h = HMM(mc, [g1; g2]); %The HMM
x=rand(h, 10000); %Generate an output sequence
mean(x)
var(x)


%% vector valued HMM testing


clear all; clc;
nStates=3;
A=[.95 .03 .02; .03 .95 .02;.03 0.02 0.95];
p0=[.25;.25;.5];
mc=MarkovChain(p0,A);
%fairly difficult for ergodic HMM, because GaussD are highly overlapping
pDgen(1)=GaussD('Mean',[10 8],'StDev',[1 10]);
%pDgen(2)=GaussD('Mean',[+1 1],'StDev',[1 3]);
pDgen(2)=GaussD('Mean',[-10 -15],'Covariance',[2 3; 3 8]);
pDgen(3)=GaussD('Mean',[-1 0],'StDev',[1 2]);
hGen=HMM(mc,pDgen);

[x,s]=rand(hGen,1000);
 plot(x(1,:), x(2,:), '*')
 
%% verifying markov chain
%A.1.2.1
mc = MarkovChain([0.75;0.25], [0.99 0.01; 0.03 0.97]);
g1 = GaussD('Mean', 0, 'StDev', 1);
g2 = GaussD('Mean', 3, 'StDev', 2);
h = HMM(mc, [g1; g2]);
[X,S]=rand(h, 10000);
hist(S)
 
 %% get an impression of how the HMM behaves
 %A.1.2.4
nsamples = 5;
seqsize = 500;
Samples = zeros(nsamples, seqsize);
States = zeros(nsamples, seqsize);
mc = MarkovChain([0.75;0.25], [0.99 0.01; 0.03 0.97]);
g1 = GaussD('Mean', 0, 'StDev', 1);
g2 = GaussD('Mean', 3, 'StDev', 2);
h = HMM(mc, [g1; g2]);

for i = 1:nsamples
   [Samples(i,:),States(i,:)]=rand(h, seqsize);
end
plot(Samples')


%%
%A.1.2.5
%Same as previous one but using zero means
nsamples = 5;
seqsize = 500;
Samples = zeros(nsamples, seqsize);
States = zeros(nsamples, seqsize);
mc = MarkovChain([0.75;0.25], [0.99 0.01; 0.03 0.97]);
g1 = GaussD('Mean', 0, 'StDev', 1);
g2 = GaussD('Mean', 0, 'StDev', 2);
h = HMM(mc, [g1; g2]);
for i = 1:nsamples
   [Samples(i,:),States(i,:)]=rand(h, seqsize);
end
plot(Samples')

%% Testing a finite duration HMM
mc=MarkovChain([0.25 0.25 0.5], [0.70 0.28 0.01 0.01; 0.15 0.81 0.03 0.01; 0.10 0.08 0.8 0.02]); 
iterations = 10000;
counts = zeros(1, iterations);
for i = 1:iterations
    r = rand(mc, 10000);
    counts(1,i) = length(r);
end
meanCounts = mean(counts)
figure;
hist(counts, 50)
mat_whole = [0.70 0.28 0.01 0.01; 0.15 0.81 0.03 0.01; 0.10 0.08 0.8 0.02; 0 0 0 1];
mat_33 = [0.70 0.28 0.01; 0.15 0.81 0.03; 0.10 0.08 0.8];
inverse = inv(eye(3) - mat_33);
final = inverse*ones(3,1)

diag = eye(3);
ex1 = [0.5 0.5 0; 0 0.5 0.5; 0.5 0 0];



 
 