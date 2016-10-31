% this is a simple calendar app which use user audio input to show the
% calendar entries for coming week

function [output] = APP()
    % init
    winsize         = 0.02; % 0.02 seems to work better than 0.01 or 0.03
    nceps           = 13; % use delta and delta-delta to improve performance
    Fs      = 22050;
    nBits   = 16;
    nChannels = 1;
    % step1
    disp('APP ready!')
    % record signal
    rec_data = record_single_word();
    %get features
    featureVec = mfcc_features(rec_data, Fs, winsize, nceps);
    logP = logprob(HMMS, featureVec);
    [maxP, maxPidx] = max(logP);
    output = maxPidx;
end
