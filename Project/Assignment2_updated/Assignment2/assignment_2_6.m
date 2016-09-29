%% Assignment 2.6

addpath(strcat(pwd,'/Sounds'));
addpath(strcat(pwd,'/Songs'));
addpath(strcat(pwd,'/GetSpeechFeatures'));
% extract audio from female.wav
[Yf,Ffs] = audioread('female.wav');

% spectogram params
X = 30;
winlength = X * 1e-3; % corresopnd to X ms
ncel = 13;

[feature_vector] = mfcc_features(Yf, Ffs, winlength, ncel);