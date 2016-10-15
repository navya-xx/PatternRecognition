%% Assignment 2.6
%

function [feature_vector] = mfcc_features(signal, frequency, winsize, ncel)
%function returns a vector containing mfcc_norm, delta_mfcc and
%delta_delta_mfcc each in ncel rows
% signal =      audio signal from audo file, e.g wav file
% frequency=    sampling frequency of audio file
% winlength=    length of the analysis window in seconds
% ncep=         number of cepstral coefficients to return (including order 0)
    
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
    % delta (add one column of zeros which is lost when differentiating)
    delta_mfcc = [zeros(ncel,1) diff(mfcc_norm, 1, 2)];
    % delta-delta (add two columns of zeros which are lost when diff)
    delta_delta_mfcc = [zeros(ncel,1) diff(mfcc,2,2) zeros(ncel,1)];
    
    %                 [ mfcc_norm       ]
    %feature vector = [ delta_mfcc      ]
    %                 [ delta_delta_mfcc]
    % size = [ 3*ncep, #frames ]
    feature_vector(ncel+1:2*ncel,:) = delta_mfcc;
    feature_vector(2*ncel+1:end,:) = delta_delta_mfcc;
    
end