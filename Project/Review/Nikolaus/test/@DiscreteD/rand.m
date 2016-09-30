function R=rand(pD,nData)
%R=rand(pD,nData) returns random scalars drawn from given Discrete Distribution.
%
%Input:
%pD=    DiscreteD object
%nData= scalar defining number of wanted random data elements
%
%Result:
%R= row vector with integer random data drawn from the DiscreteD object pD
%   (size(R)= [1, nData]
%
%----------------------------------------------------
%Code Authors:
%----------------------------------------------------

if numel(pD)>1
    error('Method works only for a single DiscreteD object');
end;


numElements = length(pD.ProbMass);
%mass = reshape(pD.ProbMass,numElements,1);
mass = pD.ProbMass;
%make an array with size [numElements, nData] and based on cumulative sums
%of (distributions from) numbers decide which one to pick
%this way works for "distributions" that don't sum to one too
R = sum(repmat(rand(1,nData),numElements,1)> repmat(cumsum(mass)/sum(mass),1,nData),1)+1;
%inspiration from
%https://se.mathworks.com/matlabcentral/newsreader/view_thread/262226 in
%order to write it neat

%error('Not yet implemented');




