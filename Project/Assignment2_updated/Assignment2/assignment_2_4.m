%% Assignment 2.4
%

addpath(strcat(pwd,'/Sounds'));
addpath(strcat(pwd,'/Songs'));
addpath(strcat(pwd,'/GetSpeechFeatures'));
% extract audio from female.wav
[Yf,Ffs] = audioread('female.wav');

% spectogram params
X = 30;
winlength = X * 1e-3; % corresopnd to X ms
ncel = 13;

% mfcc, spectogram calculation
[mfcc_fem, spectogram_fem ,f ,t ] =   GetSpeechFeatures(Yf,Ffs,winlength,ncel);

% calculate correlation of spectrum and ceptrum
spec_corr = corr(10*log10(spectogram_fem)');

% Normalize cepstrum values
mfcc_fem_norm = zeros(size(mfcc_fem));
for i = 1:size(mfcc_fem,2)
    m = mean(mfcc_fem(:,i));
    v = var(mfcc_fem(:,i));
    mfcc_fem_norm(:,i) = (mfcc_fem(:,i)-m)./sqrt(v);
end

cepc_corr = corr(mfcc_fem_norm');

% comparison of covariance matrices
figure;
imagesc(spec_corr)
colormap gray
figure;
imagesc(cepc_corr)
colormap gray