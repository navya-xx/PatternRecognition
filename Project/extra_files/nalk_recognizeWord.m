%% record new wor

load 'TrainedHMM-Wordlength2States-002secLars'


% create audiorecorder object
recObj = audiorecorder(Fs, nBits, nChannels);

input('Press any key to start recording a word');
pause(1)
disp('Started recording...');
recordblocking(recObj, 2);
disp('Stopped recording...');
% Store data in double-precision array.
myRecording = getaudiodata(recObj);

newData = mfcc_features(myRecording,fs,winsize, nceps);

%% decide which word it is

logP = logprob(HMMS, newData);
[maxP, maxPidx] = max(logP);
disp(strcat('The recognized word is ', HMMSWords{maxPidx}));