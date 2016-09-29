%% Assignment 2.3
% MFCC

addpath(strcat(pwd,'/Sounds'));
addpath(strcat(pwd,'/Songs'));
addpath(strcat(pwd,'/GetSpeechFeatures'));
% extract audio from female.wav
[Yf,Ffs] = audioread('female.wav');
% play
% soundsc(Yf,Ffs);
% pause(size(Yf,1)/Ffs);

% extract audio from female.wav
[Ym,Fms] = audioread('melody_1.wav');
% play
% soundsc(Ym,Fms);
% pause(size(Ym,1)/Fms);

% spectogram params
X = 30;
winlength = X * 1e-3; % corresopnd to X ms
ncel = 13;

% mfcc, spectogram calculation
[mfcc_fem, spectogram_fem ,f ,t ] =   GetSpeechFeatures(Yf,Ffs,winlength,ncel);
[mfcc_mel, spectogram_mel ,f ,t ] =   GetSpeechFeatures(Ym,Fms,winlength,ncel);

% Normalize cepstrum values
mfcc_fem_norm = zeros(size(mfcc_fem));
for i = 1:size(mfcc_fem,2)
    m = mean(mfcc_fem(:,i));
    v = var(mfcc_fem(:,i));
    mfcc_fem_norm(:,i) = (mfcc_fem(:,i)-m)./sqrt(v);
end

mfcc_mel_norm = zeros(size(mfcc_mel));
for i = 1:size(mfcc_mel,2)
    m = mean(mfcc_mel(:,i));
    v = var(mfcc_mel(:,i));
    mfcc_mel_norm(:,i) = (mfcc_mel(:,i)-m)./sqrt(v);
end

% plot
h = figure(1);
subplot(2,2,1)
imagesc(10*log10(spectogram_fem));
axis xy
colormap jet;
colorbar
title('Spectrogram plot of female.wav')
xlabel('time')
ylabel('frequency spectrum')

subplot(2,2,2)
imagesc(10*log10(spectogram_mel));
axis xy
colormap jet;
colorbar
title('Spectrogram plot of melody\_1.wav')
xlabel('time')
ylabel('frequency spectrum')

subplot(2,2,3)
imagesc(mfcc_fem_norm);
axis xy
colormap jet;
colorbar
title('Cepstrogram plot of female.wav')
xlabel('time')
ylabel('frequency cepstrum')


subplot(2,2,4)
imagesc(mfcc_mel_norm);
axis xy
colormap jet;
colorbar
title('Cepstrogram plot of melody\_1.wav')
xlabel('time')
ylabel('frequency cepstrum')

%% Male Female voice spectrogram cepstrogram
[Yml,Fmls] = audioread('male.wav');

% mfcc, spectogram calculation
[mfcc_male, spectogram_male ,f ,t ] =   GetSpeechFeatures(Yml,Fmls,winlength,ncel);

% Normalize cepstrum values
mfcc_male_norm = zeros(size(mfcc_male));
for i = 1:size(mfcc_male,2)
    m = mean(mfcc_male(:,i));
    v = var(mfcc_male(:,i));
    mfcc_male_norm(:,i) = (mfcc_male(:,i)-m)./sqrt(v);
end

h2 = figure(2);
subplot(2,2,1)
imagesc(10*log10(spectogram_male));
axis xy
colormap jet;
colorbar
title('Spectrogram plot of male.wav')
xlabel('time')
ylabel('frequency spectrum')

subplot(2,2,2)
imagesc(10*log10(spectogram_fem));
axis xy
colormap jet;
colorbar
title('Spectrogram plot of female.wav')
xlabel('time')
ylabel('frequency spectrum')

subplot(2,2,3)
imagesc(mfcc_male_norm);
axis xy
colormap jet;
colorbar
title('Cepstrogram plot of male.wav')
xlabel('time')
ylabel('frequency cepstrum')

subplot(2,2,4)
imagesc(mfcc_fem_norm);
axis xy
colormap jet;
colorbar
title('Cepstrogram plot of female.wav')
xlabel('time')
ylabel('frequency cepstrum')




