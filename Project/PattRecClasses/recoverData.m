function [ ] = recoverData( name, noRecordings )
%Recover data that was recorded with previously wrong recordWord.m script
%   Detailed explanation goes here

filetype = '.wav';
nBits = 16;

for ii=1:noRecordings
    tmpName = strcat(name, int2str(ii), filetype);
    [y, fs] = audioread(tmpName);
    y       = y(:,end);
    audiowrite(tmpName, y, fs, 'BitsPerSample',nBits);
end

end

