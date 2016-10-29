function [ cutSignal ] = cutSilence( audiosignal )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

m = mean(abs(audiosignal));
idx = find( abs(audiosignal)>m);
start = idx(1);
stop = idx(end);
cutSignal = audiosignal(start:stop);

end

