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

% extract audio from music.wav
[Ym,Fms] = audioread('music.wav');
% play
% soundsc(Ym,Fms);
% pause(size(Ym,1)/Fms);

% spectogram params
X = 30;
winlength = X * 1e-3; % corresopnd to X ms
ncel = 13;

% mfcc, spectogram calculation
[mfcc_fem, spectogram_fem ,f1 ,t1 ] =   GetSpeechFeatures(Yf,Ffs,winlength,ncel);
[mfcc_mel, spectogram_mel ,f2 ,t2 ] =   GetSpeechFeatures(Ym,Fms,winlength,ncel);

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
imagesc(t1,f1,10*log10(spectogram_fem));
axis xy
colormap jet;
c = colorbar;
c.Label.String = 'Frequency spectrum |Y(f)|^2 [dB]';
title('Spectrogram plot of female.wav')
xlabel('time [s]')
ylabel('frequency [Hz]')

subplot(2,2,2)
imagesc(t2,f2,10*log10(spectogram_mel));
axis xy
colormap jet;
c = colorbar;
c.Label.String = 'Frequency spectrum |Y(f)|^2 [dB]';
title('Spectrogram plot of music.wav')
xlabel('time [s]')
ylabel('frequency [Hz]')

subplot(2,2,3)
imagesc(mfcc_fem_norm);
axis xy
colormap jet;
c = colorbar;
c.Label.String = 'Coefficient amplitude';
title('Cepstrogram plot of female.wav')
xlabel('time [frame]')
ylabel('frequency cepstrum [coefficient #]')


subplot(2,2,4)
imagesc(mfcc_mel_norm);
axis xy
colormap jet;
c = colorbar;
c.Label.String = 'Coefficient amplitude';
title('Cepstrogram plot of music.wav')
xlabel('time [frame]')
ylabel('frequency cepstrum [coefficient #]')

%% Male Female voice spectrogram cepstrogram
[Yml,Fmls] = audioread('male.wav');

% mfcc, spectogram calculation
[mfcc_male, spectogram_male ,f3 ,t3 ] =   GetSpeechFeatures(Yml,Fmls,winlength,ncel);

% Normalize cepstrum values
mfcc_male_norm = zeros(size(mfcc_male));
for i = 1:size(mfcc_male,2)
    m = mean(mfcc_male(:,i));
    v = var(mfcc_male(:,i));
    mfcc_male_norm(:,i) = (mfcc_male(:,i)-m)./sqrt(v);
end

h2 = figure(2);
subplot(2,2,1)
imagesc(t3,f3,10*log10(spectogram_male));
axis xy
colormap jet;
c = colorbar;
c.Label.String = 'Frequency spectrum |Y(f)|^2 [dB]';
title('Spectrogram plot of male.wav')
xlabel('time [s]')
ylabel('frequency [Hz]')

subplot(2,2,2)
imagesc(t1,f1,10*log10(spectogram_fem));
axis xy
colormap jet;
c = colorbar;
c.Label.String = 'Frequency spectrum |Y(f)|^2 [dB]';
title('Spectrogram plot of female.wav')
xlabel('time [s]')
ylabel('frequency [Hz]')

subplot(2,2,3)
imagesc(mfcc_male_norm);
axis xy
colormap jet;
c = colorbar;
c.Label.String = 'Coefficient amplitude';
title('Cepstrogram plot of male.wav')
xlabel('time [frame]')
ylabel('frequency cepstrum [coefficient #]')

subplot(2,2,4)
imagesc(mfcc_fem_norm);
axis xy
colormap jet;
c = colorbar;
c.Label.String = 'Coefficient amplitude';
title('Cepstrogram plot of female.wav')
xlabel('time [frame]')
ylabel('frequency cepstrum [coefficient #]')




