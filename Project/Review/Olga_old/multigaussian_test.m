mc = MarkovChain([0.5 0.5], [0.6 0.4; 0.4 0.6]);
g1=GaussD('Mean',[5 0],'Covariance',[2 1; 1 4]);
g2=GaussD('Mean',[5 0],'Covariance',[2 1; 1 4]);
h = HMM(mc, [g1,g2]);
seq = rand(h,1000);
mean(seq,2)
cov(seq(1,:),seq(2,:))