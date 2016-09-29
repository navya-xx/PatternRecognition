%rand('seed', 1);
mc = MarkovChain([0.5 0.5], [0.5 0.2 0.3; 0.2 0.5 0.3]);
g1=GaussD('Mean',0,'StDev',1);
g2=GaussD('Mean',3,'StDev',2);
h = HMM(mc, [g1,g2]);
l = zeros(10000,1);
for i=1:10000
    l(i,1) = length(rand(h,100));
end
%histogram(l,'Normalization', 'pdf')
histogram(l,'Normalization', 'cdf')
xlabel('Sequence length')
title('Cumulative normalized histogram of sequence length for the finite-duration HMM test')