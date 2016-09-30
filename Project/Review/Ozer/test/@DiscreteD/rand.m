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
%http://stackoverflow.com/questions/13914066/generate-random-number-with-given-probability-matlab
R = zeros(1,nData);
for i=1:nData
    r = rand();
    cs = cumsum([0, transpose(pD.ProbMass)]); %this might need to change to non-transpose, beacuse matlab vectors are weird
    x = sum(r >= cs);
    R(i) = x;
end;


