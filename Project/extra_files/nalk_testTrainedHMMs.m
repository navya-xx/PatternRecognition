% Test trained HMMs with the remaining Data

%load 'TrainedHMM-Wordlength2States-002sec' % working well only for Navneet
%load 'TrainedHMM-Wordlength2States-002secwithoutNavneet' 
%load 'TrainedHMM-2WordlengthStates-002secwithoutNavneet'
%load 'TrainedHMM-2Wordlength2States-002secwithoutNavneet' % working okay for all except for Navneet
%load 'TrainedHMM-2Wordlength2States-recTr12-002secwithoutNavneet'
load 'TrainedHMM2-2Wordlength2States-002secgirls'

addpath(strcat(pwd,audiodir));             % Add audiofiles to path
addpath(strcat(pwd,'/../PattRecClasses'));      % Add classes to path

dirlist     = dir(strcat(pwd,audiodir));   % list recorded words
offset      = 2;
nrWords     = size(dirlist,1)-offset;


% First dimension: The correct word
% Second dimension: The recognized word
recognizedWords = zeros(4, nrWords,nrWords);


disp('Start loop...');

for idx=1+offset:nrWords+offset                   % loop through words
    word    = dirlist(idx).name;
    speakerlist = dir(strcat(pwd,audiodir,'/', word));
    nrSpeakers = size(speakerlist,1)-offset;
    
    for speakeridx=1+offset:nrSpeakers+offset    % loop through speakers
        
        
        speaker = speakerlist(speakeridx).name;

        for recidx=recPerWord-recForCheck+1:recPerWord             % loop through recordings
            tmpfile = strcat(pwd, audiodir, '/', word, '/',...
                speaker, '/', word, int2str(recidx), filetype);
            [rec, fs]= audioread(tmpfile);
            featureVec  = mfcc_features(rec,fs,winsize, nceps);
            logP = logprob(HMMS, featureVec);
            [maxP, maxPidx] = max(logP);
            %disp(strcat('Correct word is ',word));
            %disp(strcat('Recognized word is ',HMMSWords{maxPidx}));
            % Add one for recognized word
            recognizedWords(speakeridx-offset, idx-offset, maxPidx) = ...
                recognizedWords(speakeridx-offset, idx-offset, maxPidx) +1 ; 
        end
        
        if showPlots
            % plots cepstral coefficients for 4 recordings of each word 
            % for every speaker so be careful 
            % (produces nrSpeakers*nrWords figures)
            plotCepsCoef(obsData, lData, word, speaker);
        end
    end
    
    disp(strcat('Tests for word ', word, ' finished.'));
end

figure;
for ii=1:4
    subplot(2,2,ii)
    imagesc(squeeze(recognizedWords(ii,:,:)))
    colormap gray
    title(strcat('Recognized words vs correct words (',speakerlist(ii+offset).name,')'));
    xlabel('Word #');
    ylabel('Word #');
end