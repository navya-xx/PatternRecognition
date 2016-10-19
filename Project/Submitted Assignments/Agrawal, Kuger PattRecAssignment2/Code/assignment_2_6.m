%% Assignment 2.6
% A working MatLab function which computes feature vector series that
% combine normalized static and dynamic features, if you wish to use
% this technique in your recognizer.

addpath(strcat(pwd,'/Sounds'));
addpath(strcat(pwd,'/Songs'));
addpath(strcat(pwd,'/GetSpeechFeatures'));
% extract audio from female.wav
[Yf,Ffs] = audioread('female.wav');

% spectogram params
X = 30;
winlength = X * 1e-3; % corresopnd to X ms
ncel = 13;

% get feature vector with mfcc_norm and derivatives 1 and 2
[feature_vector] = mfcc_features(Yf, Ffs, winlength, ncel);