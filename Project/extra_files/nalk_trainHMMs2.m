% Train HMM models with recorded words

clear all

%% Init parameters

disp('Start initializing...');

showPlots       = 1;

recPerWord      = 15;
recForTraining  = 10;   % Actual number of recordings used for training is
                        % recForTraining-1 !
recForCheck     = recPerWord - recForTraining;

nStates         = 0;
filetype        = '.wav';
audiodir        = '/audiofiles';

winsize         = 0.02; % 0.02 seems to work better than 0.01 or 0.03
nceps           = 10; % use delta and delta-delta to improve performance

Fs      = 22050;
nBits   = 16;
nChannels = 1;

pd      = GaussMixD(3);

disp('Successfully initialized.');
%%

addpath(strcat(pwd,audiodir));             % Add audiofiles to path
addpath(strcat(pwd,'/../PattRecClasses'));      % Add classes to path

dirlist     = dir(strcat(pwd,audiodir));   % list recorded words
offset      = 2;
nrWords     = size(dirlist,1)-offset;

HMMS        = [];
HMMSWords   = [];

disp('Start loop...');

for idx=1+offset:nrWords+offset                   % loop through words
    word    = dirlist(idx).name;
    speakerlist = dir(strcat(pwd,audiodir,'/', word));
    nrSpeakers = size(speakerlist,1)-offset;
    
    
    obsData    = [];    % feature vector
    lData   = [];   % length of single recordings
    
    for recidx=2:recForTraining             % loop through recordings
        for speakeridx=1+offset:nrSpeakers+offset    % loop through speakers
        
            speaker = speakerlist(speakeridx).name;
            
            %if ~strcmp(speaker,'Madolyn')
            %    continue;
            %end


            tmpfile = strcat(pwd, audiodir, '/', word, '/',...
                speaker, '/', word, int2str(recidx), filetype);
            [rec, fs]= audioread(tmpfile);
            %rec     = cutSilence(rec);
            featureVec  = mfcc_features(rec,fs,winsize, nceps);
            obsData     = [ obsData, featureVec];
            lData       = [ lData, length(featureVec)];
            
        end
        

    end
    
    nStates = 2*length(word)+2;
    HMMS = [HMMS, MakeLeftRightHMM(nStates, pd, obsData, lData)];
    HMMSWords = [HMMSWords; {word}];
    disp(strcat('Trained left right HMM #',int2str(idx-2), ' for word ', word));
end


save 'Test' HMMS HMMSWords Fs fs nChannels nBits winsize nceps recPerWord recForCheck obsData lData pd
disp('Saved trained HMM.');

