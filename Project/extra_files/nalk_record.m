function [ myRecording ] = nalk_record( recObj, pauseLength, recordLength )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

pause(pauseLength)
disp('Started recording...');
recordblocking(recObj, recordLength);
disp('Stopped recording...');
% Store data in double-precision array.
myRecording = getaudiodata(recObj);

end

