function [Y] = acceptance_rejection(p, N)
%%% This function creates gaussian data using uniform distribution by the
% method of acceptance rejection.
% INPUT: p - probability vector (column vector)
%        N - size of output Y
% The method involves following steps:
% 1. Generate a known random variable X (uniformly distributed)
% 2. create random number u and test for u < p(x)/c*q, if true Y=X
 
 
success = 0;
Y = zeros(N,1);
while(success < N)
     % uniform distribution q(x)
     q = 1/size(p,2);
     a = 1;
     % bound for Y
     c = max(p/q);
     % step 1
     u1 = rand();
     X = floor(u1/q) + a;
     % step 2
     u = rand();
     if u < p(X)/(c*q)
        success = success + 1;
        Y(success) = X;
     end
end