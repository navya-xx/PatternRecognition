%% Record words for speech recognizer
% Authors: Navneet Agrawal and Lars Kuger
% Fall term 2016, KTH Royal Institute of Technology
% Pattern Recognition course

% fix parameters
Fs      = 22050;
nBits   = 16;
nChannels = 1;
filedir = 'audiofiles/';
if ~exist(filedir, 'dir')
   mkdir(filedir); 
   pause(0.1)
end
fileformat = '.wav';

% make separate folder for each word
filename = input('Which word do you want to record?', 's');
if ~exist(filename,'dir')
    mkdir(filedir, filename);
    pause(0.1)
end
path = strcat(filedir, filename, '/');

% and separate folder for each speaker
speakername = input('What is your name?', 's');
if ~exist(strcat(path, speakername),'dir')
    mkdir(path, speakername);
    pause(0.1)
end
path = strcat(path, speakername, '/');

numberRec = input('How many times do you want to record this word?');


% create audiorecorder object
recObj = audiorecorder(Fs, nBits, nChannels);

myRecording = [];

% record word
for idx=1:numberRec

    disp('Start speaking.')
    recordblocking(recObj, 2);
    disp('End of Recording.')

    % Play back the recording.
    play(recObj);
    pause(2);

    % Store data in double-precision array.
    myRecording = getaudiodata(recObj);

    % Number the recorded files
    audiowrite(strcat(path, filename, int2str(idx), fileformat), myRecording, Fs, 'BitsPerSample',nBits);
end

% play back
%for idx=1:numberRec
%    sound(myRecording(:,idx), Fs, nBits);
%    pause( ceil(size(myRecording(:,idx),1) / Fs));
%end
