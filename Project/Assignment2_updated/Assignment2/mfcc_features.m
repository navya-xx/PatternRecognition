%% Assignment 2.6
%

function [feature_vector] = mfcc_features(signal, frequency, winsize, ncel)
    
    
    [mfcc] = ...
        GetSpeechFeatures(signal,frequency,winsize,ncel);
    
    feature_vector = zeros(ncel*3, size(mfcc,2));
    % Normalize cepstrum values
    mfcc_norm = zeros(size(mfcc));
    for i = 1:size(mfcc,2)
        m = mean(mfcc(:,i));
        v = var(mfcc(:,i));
        mfcc_norm(:,i) = (mfcc(:,i)-m)./sqrt(v);
    end
    
    feature_vector(1:ncel,:) = mfcc_norm;
    
    % difference features
    % delta
    delta_mfcc = [zeros(ncel,1) diff(mfcc_norm, 1, 2)];
    % delta-delta
    delta_delta_mfcc = [zeros(ncel,1) diff(mfcc,2,2) zeros(ncel,1)];
    
    feature_vector(ncel+1:2*ncel,:) = delta_mfcc;
    feature_vector(2*ncel+1:end,:) = delta_delta_mfcc;